#!/usr/bin/env python3
"""
pack_wad.py — Embed a WAD into a Mana Minix FS disk image (binary)

Usage:
    python3 tools/pack_wad.py assets/doom1.wad

Output:
    build/disk.img          — raw 48MB Minix image
    (Makefile objcopy → build/fs/disk_image.o)

Then:
    make doom-disk
"""

import struct
import sys
import os
import math

BLOCK_SIZE  = 1024
DISK_BLOCKS = 49152       # 48MB
DISK_SIZE   = DISK_BLOCKS * BLOCK_SIZE

NINODES         = 512
IMAP_BLOCKS     = 1
ZMAP_BLOCKS     = 8       # 65536 bits
INODE_SIZE      = 32
INODES_PER_BLOCK = BLOCK_SIZE // INODE_SIZE  # 32
INODE_TABLE_BLOCKS = math.ceil(NINODES * INODE_SIZE / BLOCK_SIZE)
FIRST_DATA_ZONE = 1 + 1 + IMAP_BLOCKS + ZMAP_BLOCKS + INODE_TABLE_BLOCKS
MAGIC = 0x137F

disk = bytearray(DISK_SIZE)

def blk_write(n, data):
    assert len(data) <= BLOCK_SIZE
    off = n * BLOCK_SIZE
    disk[off:off + len(data)] = data
    if len(data) < BLOCK_SIZE:
        # pad already zero
        pass

def blk_read(n):
    off = n * BLOCK_SIZE
    return bytearray(disk[off:off + BLOCK_SIZE])

def set_bit(block_num, bit):
    blk = blk_read(block_num)
    blk[bit // 8] |= (1 << (bit % 8))
    blk_write(block_num, blk)

IMAP_START = 2
ZMAP_START = IMAP_START + IMAP_BLOCKS
INODE_TABLE_START = ZMAP_START + ZMAP_BLOCKS

def write_superblock():
    first_data = FIRST_DATA_ZONE
    sb = struct.pack('<HHHHHHIH',
        NINODES,
        min(DISK_BLOCKS, 65535),
        IMAP_BLOCKS,
        ZMAP_BLOCKS,
        first_data,
        0,
        DISK_SIZE if DISK_SIZE < 0xFFFFFFFF else 0xFFFFFFFF,
        MAGIC)
    blk = bytearray(BLOCK_SIZE)
    blk[:len(sb)] = sb
    blk_write(1, blk)
    return first_data

def inode_block(inum):
    return INODE_TABLE_START + ((inum - 1) * INODE_SIZE) // BLOCK_SIZE

def inode_offset(inum):
    return ((inum - 1) * INODE_SIZE) % BLOCK_SIZE

def write_inode(inum, mode, size, zones):
    zones = (zones + [0] * 9)[:9]
    data = struct.pack('<HHIIBB' + 'H' * 9,
        mode, 0, size, 0, 0, 1, *zones)
    blkno = inode_block(inum)
    offset = inode_offset(inum)
    blk = blk_read(blkno)
    blk[offset:offset + INODE_SIZE] = data
    blk_write(blkno, blk)

_next_bit = [0]  # bit index in zone map (0 → first_data zone)

def alloc_zone(first_data):
    """Match runtime alloc_zone: bit b maps to zone first_data + b."""
    bit = _next_bit[0]
    max_bits = ZMAP_BLOCKS * BLOCK_SIZE * 8
    if bit >= max_bits:
        raise RuntimeError("disk full")
    blkno = ZMAP_START + bit // (BLOCK_SIZE * 8)
    local = bit % (BLOCK_SIZE * 8)
    blk = blk_read(blkno)
    blk[local // 8] |= (1 << (local % 8))
    blk_write(blkno, blk)
    z = first_data + bit
    _next_bit[0] = bit + 1
    return z

def make_dir_entry(inum, name):
    name_bytes = name.encode('ascii')[:14].ljust(14, b'\x00')
    return struct.pack('<H', inum) + name_bytes

def mkfs(first_data):
    _next_bit[0] = 0
    set_bit(IMAP_START, 0)
    set_bit(IMAP_START, 1)
    root_zone = alloc_zone(first_data)
    write_inode(1, 0x41ED, BLOCK_SIZE, [root_zone])
    blk = bytearray(BLOCK_SIZE)
    blk[0:16] = make_dir_entry(1, '.')
    blk[16:32] = make_dir_entry(1, '..')
    blk_write(root_zone, blk)
    print(f"  mkfs: root_zone={root_zone} first_data={first_data}")

def copy_file(first_data, filename, data):
    file_size = len(data)
    zones_needed = math.ceil(file_size / BLOCK_SIZE) if file_size else 0
    max_zones = 7 + 512 + 512 * 512
    if zones_needed > max_zones:
        raise ValueError(f"File too large ({file_size} bytes)")

    allocated = []
    for i in range(zones_needed):
        z = alloc_zone(first_data)
        allocated.append(z)
        chunk = data[i * BLOCK_SIZE:(i + 1) * BLOCK_SIZE]
        blk = bytearray(BLOCK_SIZE)
        blk[:len(chunk)] = chunk
        blk_write(z, blk)

    zone_list = [0] * 9

    # direct
    for i in range(min(7, zones_needed)):
        zone_list[i] = allocated[i]

    # single indirect
    if zones_needed > 7:
        ind = alloc_zone(first_data)
        zone_list[7] = ind
        iblk = bytearray(BLOCK_SIZE)
        n_single = min(512, zones_needed - 7)
        for i in range(n_single):
            struct.pack_into('<H', iblk, i * 2, allocated[7 + i])
        blk_write(ind, iblk)

    # double indirect
    if zones_needed > 7 + 512:
        dind = alloc_zone(first_data)
        zone_list[8] = dind
        dblk = bytearray(BLOCK_SIZE)
        remaining = zones_needed - 7 - 512
        outer = 0
        pos = 7 + 512
        while remaining > 0:
            sind = alloc_zone(first_data)
            struct.pack_into('<H', dblk, outer * 2, sind)
            sblk = bytearray(BLOCK_SIZE)
            n = min(512, remaining)
            for i in range(n):
                struct.pack_into('<H', sblk, i * 2, allocated[pos + i])
            blk_write(sind, sblk)
            pos += n
            remaining -= n
            outer += 1
        blk_write(dind, dblk)

    set_bit(IMAP_START, 2)
    write_inode(2, 0x8180, file_size, zone_list)

    # dir entry
    root_blk = blk_read(inode_block(1))
    root_off = inode_offset(1)
    root_zone = struct.unpack_from('<H', root_blk, root_off + 14)[0]
    dir_blk = blk_read(root_zone)
    base = os.path.basename(filename)
    if len(base) > 14:
        base = base[:14]
    for i in range(0, BLOCK_SIZE, 16):
        if struct.unpack_from('<H', dir_blk, i)[0] == 0:
            dir_blk[i:i+16] = make_dir_entry(2, base)
            blk_write(root_zone, dir_blk)
            break

    print(f"  packed: '{base}' — {file_size:,} bytes ({zones_needed} zones)")

def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    wad_path = sys.argv[1]
    if not os.path.exists(wad_path):
        print(f"Error: {wad_path} not found")
        sys.exit(1)

    with open(wad_path, 'rb') as f:
        wad = f.read()
    print(f"Mana WAD packer (48MB disk)")
    print(f"  input: {wad_path} ({len(wad):,} bytes)")
    if wad[:4] not in (b'IWAD', b'PWAD'):
        print(f"  warning: magic={wad[:4]!r}")

    first = write_superblock()
    mkfs(first)
    copy_file(first, wad_path, wad)

    out_dir = os.path.join(os.path.dirname(__file__), '..', 'build')
    os.makedirs(out_dir, exist_ok=True)
    out_img = os.path.normpath(os.path.join(out_dir, 'disk.img'))
    with open(out_img, 'wb') as f:
        f.write(disk)
    print(f"  wrote: {out_img} ({os.path.getsize(out_img):,} bytes)")
    print("Done. Rebuild with: make doom-disk")

if __name__ == '__main__':
    main()
