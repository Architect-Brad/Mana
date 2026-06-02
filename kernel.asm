
kernel.elf:     file format elf64-littleaarch64


Disassembly of section .text:

0000000040000000 <ramfb_init>:
    40000000:	d503233f 	paciasp
    40000004:	b0000020 	adrp	x0, 40005000 <tanf+0x30>
    40000008:	9102a000 	add	x0, x0, #0xa8
    4000000c:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
    40000010:	910003fd 	mov	x29, sp
    40000014:	940000eb 	bl	400003c0 <uart_puts>
    40000018:	d2800100 	mov	x0, #0x8                   	// #8
    4000001c:	f2a12040 	movk	x0, #0x902, lsl #16
    40000020:	52832001 	mov	w1, #0x1900                	// #6400
    40000024:	910083e6 	add	x6, sp, #0x20
    40000028:	d2a12042 	mov	x2, #0x9020000             	// #151126016
    4000002c:	79000001 	strh	w1, [x0]
    40000030:	910073e0 	add	x0, sp, #0x1c
    40000034:	b9001fff 	str	wzr, [sp, #28]
    40000038:	39400041 	ldrb	w1, [x2]
    4000003c:	38001401 	strb	w1, [x0], #1
    40000040:	eb06001f 	cmp	x0, x6
    40000044:	54ffffa1 	b.ne	40000038 <ramfb_init+0x38>  // b.any
    40000048:	b9401fe7 	ldr	w7, [sp, #28]
    4000004c:	34000347 	cbz	w7, 400000b4 <ramfb_init+0xb4>
    40000050:	5ac008e7 	rev	w7, w7
    40000054:	52800005 	mov	w5, #0x0                   	// #0
    40000058:	d2a12044 	mov	x4, #0x9020000             	// #151126016
    4000005c:	b0000028 	adrp	x8, 40005000 <tanf+0x30>
    40000060:	aa0603e0 	mov	x0, x6
    40000064:	d503201f 	nop
    40000068:	39400081 	ldrb	w1, [x4]
    4000006c:	38001401 	strb	w1, [x0], #1
    40000070:	910183e1 	add	x1, sp, #0x60
    40000074:	eb00003f 	cmp	x1, x0
    40000078:	54ffff81 	b.ne	40000068 <ramfb_init+0x68>  // b.any
    4000007c:	3940a3e0 	ldrb	w0, [sp, #40]
    40000080:	91026101 	add	x1, x8, #0x98
    40000084:	9100a3e2 	add	x2, sp, #0x28
    40000088:	350000a0 	cbnz	w0, 4000009c <ramfb_init+0x9c>
    4000008c:	14000007 	b	400000a8 <ramfb_init+0xa8>
    40000090:	38401c40 	ldrb	w0, [x2, #1]!
    40000094:	91000421 	add	x1, x1, #0x1
    40000098:	34000180 	cbz	w0, 400000c8 <ramfb_init+0xc8>
    4000009c:	39400023 	ldrb	w3, [x1]
    400000a0:	6b00007f 	cmp	w3, w0
    400000a4:	54ffff60 	b.eq	40000090 <ramfb_init+0x90>  // b.none
    400000a8:	110004a5 	add	w5, w5, #0x1
    400000ac:	6b0500ff 	cmp	w7, w5
    400000b0:	54fffd88 	b.hi	40000060 <ramfb_init+0x60>  // b.pmore
    400000b4:	b0000020 	adrp	x0, 40005000 <tanf+0x30>
    400000b8:	91030000 	add	x0, x0, #0xc0
    400000bc:	a8c67bfd 	ldp	x29, x30, [sp], #96
    400000c0:	d50323bf 	autiasp
    400000c4:	140000bf 	b	400003c0 <uart_puts>
    400000c8:	39400020 	ldrb	w0, [x1]
    400000cc:	35fffee0 	cbnz	w0, 400000a8 <ramfb_init+0xa8>
    400000d0:	79404be0 	ldrh	w0, [sp, #36]
    400000d4:	90000085 	adrp	x5, 40010000 <fb_width>
    400000d8:	910000a4 	add	x4, x5, #0x0
    400000dc:	b0000083 	adrp	x3, 40011000 <raw_framebuffer>
    400000e0:	91000063 	add	x3, x3, #0x0
    400000e4:	91475061 	add	x1, x3, #0x1d4, lsl #12
    400000e8:	91300021 	add	x1, x1, #0xc00
    400000ec:	f9000883 	str	x3, [x4, #16]
    400000f0:	5ac00402 	rev16	w2, w0
    400000f4:	52806400 	mov	w0, #0x320                 	// #800
    400000f8:	b90000a0 	str	w0, [x5]
    400000fc:	52804b00 	mov	w0, #0x258                 	// #600
    40000100:	b9000480 	str	w0, [x4, #4]
    40000104:	52819000 	mov	w0, #0xc80                 	// #3200
    40000108:	b9000880 	str	w0, [x4, #8]
    4000010c:	aa0303e0 	mov	x0, x3
    40000110:	b800441f 	str	wzr, [x0], #4
    40000114:	eb01001f 	cmp	x0, x1
    40000118:	54ffffc1 	b.ne	40000110 <ramfb_init+0x110>  // b.any
    4000011c:	dac00c63 	rev	x3, x3
    40000120:	d2864680 	mov	x0, #0x3234                	// #12852
    40000124:	f2ab0a40 	movk	x0, #0x5852, lsl #16
    40000128:	91006081 	add	x1, x4, #0x18
    4000012c:	dac00c21 	rev	x1, x1
    40000130:	a9018083 	stp	x3, x0, [x4, #24]
    40000134:	d2a40060 	mov	x0, #0x20030000            	// #537067520
    40000138:	f2eb0040 	movk	x0, #0x5802, lsl #48
    4000013c:	f9001480 	str	x0, [x4, #40]
    40000140:	52b00180 	mov	w0, #0x800c0000            	// #-2146697216
    40000144:	b9003080 	str	w0, [x4, #48]
    40000148:	53103c40 	lsl	w0, w2, #16
    4000014c:	321d0400 	orr	w0, w0, #0x18
    40000150:	5ac00800 	rev	w0, w0
    40000154:	b9004080 	str	w0, [x4, #64]
    40000158:	52a38000 	mov	w0, #0x1c000000            	// #469762048
    4000015c:	b9004480 	str	w0, [x4, #68]
    40000160:	f9002481 	str	x1, [x4, #72]
    40000164:	d5033f9f 	dsb	sy
    40000168:	91010080 	add	x0, x4, #0x40
    4000016c:	d2800202 	mov	x2, #0x10                  	// #16
    40000170:	f2a12042 	movk	x2, #0x902, lsl #16
    40000174:	d360fc01 	lsr	x1, x0, #32
    40000178:	5ac00821 	rev	w1, w1
    4000017c:	5ac00800 	rev	w0, w0
    40000180:	b9000041 	str	w1, [x2]
    40000184:	b9000440 	str	w0, [x2, #4]
    40000188:	b9404080 	ldr	w0, [x4, #64]
    4000018c:	5ac00800 	rev	w0, w0
    40000190:	7100041f 	cmp	w0, #0x1
    40000194:	540000c9 	b.ls	400001ac <ramfb_init+0x1ac>  // b.plast
    40000198:	d503203f 	yield
    4000019c:	b9404080 	ldr	w0, [x4, #64]
    400001a0:	5ac00800 	rev	w0, w0
    400001a4:	7100041f 	cmp	w0, #0x1
    400001a8:	54ffff88 	b.hi	40000198 <ramfb_init+0x198>  // b.pmore
    400001ac:	b9404080 	ldr	w0, [x4, #64]
    400001b0:	37c00120 	tbnz	w0, #24, 400001d4 <ramfb_init+0x1d4>
    400001b4:	f9400881 	ldr	x1, [x4, #16]
    400001b8:	b0000020 	adrp	x0, 40005000 <tanf+0x30>
    400001bc:	91052000 	add	x0, x0, #0x148
    400001c0:	b94000a2 	ldr	w2, [x5]
    400001c4:	b9400483 	ldr	w3, [x4, #4]
    400001c8:	a8c67bfd 	ldp	x29, x30, [sp], #96
    400001cc:	d50323bf 	autiasp
    400001d0:	140000c4 	b	400004e0 <uart_printf>
    400001d4:	b0000020 	adrp	x0, 40005000 <tanf+0x30>
    400001d8:	91042000 	add	x0, x0, #0x108
    400001dc:	94000079 	bl	400003c0 <uart_puts>
    400001e0:	90000080 	adrp	x0, 40010000 <fb_width>
    400001e4:	91000004 	add	x4, x0, #0x0
    400001e8:	f900089f 	str	xzr, [x4, #16]
    400001ec:	a8c67bfd 	ldp	x29, x30, [sp], #96
    400001f0:	d50323bf 	autiasp
    400001f4:	d65f03c0 	ret
    400001f8:	d503201f 	nop
    400001fc:	d503201f 	nop

0000000040000200 <ramfb_clear>:
    40000200:	d503245f 	bti	c
    40000204:	90000082 	adrp	x2, 40010000 <fb_width>
    40000208:	91000043 	add	x3, x2, #0x0
    4000020c:	f9400861 	ldr	x1, [x3, #16]
    40000210:	b4000141 	cbz	x1, 40000238 <ramfb_clear+0x38>
    40000214:	b9400042 	ldr	w2, [x2]
    40000218:	b9400463 	ldr	w3, [x3, #4]
    4000021c:	1b037c42 	mul	w2, w2, w3
    40000220:	340000a2 	cbz	w2, 40000234 <ramfb_clear+0x34>
    40000224:	8b224822 	add	x2, x1, w2, uxtw #2
    40000228:	b8004420 	str	w0, [x1], #4
    4000022c:	eb02003f 	cmp	x1, x2
    40000230:	54ffffc1 	b.ne	40000228 <ramfb_clear+0x28>  // b.any
    40000234:	d5033f9f 	dsb	sy
    40000238:	d65f03c0 	ret
    4000023c:	d503201f 	nop

0000000040000240 <ramfb_test_pattern>:
    40000240:	d503245f 	bti	c
    40000244:	90000081 	adrp	x1, 40010000 <fb_width>
    40000248:	91000020 	add	x0, x1, #0x0
    4000024c:	f9400804 	ldr	x4, [x0, #16]
    40000250:	b40005a4 	cbz	x4, 40000304 <ramfb_test_pattern+0xc4>
    40000254:	b940040b 	ldr	w11, [x0, #4]
    40000258:	3400040b 	cbz	w11, 400002d8 <ramfb_test_pattern+0x98>
    4000025c:	b9400023 	ldr	w3, [x1]
    40000260:	34000443 	cbz	w3, 400002e8 <ramfb_test_pattern+0xa8>
    40000264:	b940080a 	ldr	w10, [x0, #8]
    40000268:	531f7966 	lsl	w6, w11, #1
    4000026c:	52955560 	mov	w0, #0xaaab                	// #43691
    40000270:	72b55540 	movk	w0, #0xaaaa, lsl #16
    40000274:	52800002 	mov	w2, #0x0                   	// #0
    40000278:	52800009 	mov	w9, #0x0                   	// #0
    4000027c:	52801fe8 	mov	w8, #0xff                  	// #255
    40000280:	9ba07d65 	umull	x5, w11, w0
    40000284:	529fe007 	mov	w7, #0xff00                	// #65280
    40000288:	9ba07cc6 	umull	x6, w6, w0
    4000028c:	53027d4a 	lsr	w10, w10, #2
    40000290:	d361fca5 	lsr	x5, x5, #33
    40000294:	d361fcc6 	lsr	x6, x6, #33
    40000298:	2a0903e0 	mov	w0, w9
    4000029c:	d503201f 	nop
    400002a0:	52a01fe1 	mov	w1, #0xff0000              	// #16711680
    400002a4:	6b0200bf 	cmp	w5, w2
    400002a8:	54000068 	b.hi	400002b4 <ramfb_test_pattern+0x74>  // b.pmore
    400002ac:	6b0200df 	cmp	w6, w2
    400002b0:	1a879101 	csel	w1, w8, w7, ls	// ls = plast
    400002b4:	b8205881 	str	w1, [x4, w0, uxtw #2]
    400002b8:	11000400 	add	w0, w0, #0x1
    400002bc:	6b03001f 	cmp	w0, w3
    400002c0:	54ffff01 	b.ne	400002a0 <ramfb_test_pattern+0x60>  // b.any
    400002c4:	11000442 	add	w2, w2, #0x1
    400002c8:	0b0a0063 	add	w3, w3, w10
    400002cc:	0b0a0129 	add	w9, w9, w10
    400002d0:	6b02017f 	cmp	w11, w2
    400002d4:	54fffe21 	b.ne	40000298 <ramfb_test_pattern+0x58>  // b.any
    400002d8:	d5033f9f 	dsb	sy
    400002dc:	b0000020 	adrp	x0, 40005000 <tanf+0x30>
    400002e0:	91060000 	add	x0, x0, #0x180
    400002e4:	14000037 	b	400003c0 <uart_puts>
    400002e8:	11000460 	add	w0, w3, #0x1
    400002ec:	6b00017f 	cmp	w11, w0
    400002f0:	54ffff40 	b.eq	400002d8 <ramfb_test_pattern+0x98>  // b.none
    400002f4:	11000863 	add	w3, w3, #0x2
    400002f8:	6b03017f 	cmp	w11, w3
    400002fc:	54ffff61 	b.ne	400002e8 <ramfb_test_pattern+0xa8>  // b.any
    40000300:	17fffff6 	b	400002d8 <ramfb_test_pattern+0x98>
    40000304:	d65f03c0 	ret
    40000308:	d503201f 	nop
    4000030c:	d503201f 	nop

0000000040000310 <ramfb_get_buffer>:
    40000310:	d503245f 	bti	c
    40000314:	b0000080 	adrp	x0, 40011000 <raw_framebuffer>
    40000318:	91000000 	add	x0, x0, #0x0
    4000031c:	d65f03c0 	ret

0000000040000320 <timer_handler>:
    40000320:	d503233f 	paciasp
    40000324:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    40000328:	910003fd 	mov	x29, sp
    4000032c:	f9000bf3 	str	x19, [sp, #16]
    40000330:	940003c8 	bl	40001250 <disable_cntv>
    40000334:	52800360 	mov	w0, #0x1b                  	// #27
    40000338:	940004be 	bl	40001630 <gicd_clear_pending>
    4000033c:	b0000f20 	adrp	x0, 401e5000 <raw_framebuffer+0x1d4000>
    40000340:	b94c0013 	ldr	w19, [x0, #3072]
    40000344:	940003db 	bl	400012b0 <raw_read_cntvct_el0>
    40000348:	8b000260 	add	x0, x19, x0
    4000034c:	940003e1 	bl	400012d0 <raw_write_cntv_cval_el0>
    40000350:	f9400bf3 	ldr	x19, [sp, #16]
    40000354:	a8c27bfd 	ldp	x29, x30, [sp], #32
    40000358:	d50323bf 	autiasp
    4000035c:	140003c5 	b	40001270 <enable_cntv>

0000000040000360 <timer_test>:
    40000360:	d503233f 	paciasp
    40000364:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    40000368:	910003fd 	mov	x29, sp
    4000036c:	f9000bf3 	str	x19, [sp, #16]
    40000370:	940004d0 	bl	400016b0 <gic_v3_initialize>
    40000374:	940003b7 	bl	40001250 <disable_cntv>
    40000378:	940003c6 	bl	40001290 <raw_read_cntfrq_el0>
    4000037c:	2a0003f3 	mov	w19, w0
    40000380:	b0000f20 	adrp	x0, 401e5000 <raw_framebuffer+0x1d4000>
    40000384:	b90c0013 	str	w19, [x0, #3072]
    40000388:	940003ca 	bl	400012b0 <raw_read_cntvct_el0>
    4000038c:	8b334000 	add	x0, x0, w19, uxtw
    40000390:	940003d0 	bl	400012d0 <raw_write_cntv_cval_el0>
    40000394:	940003b7 	bl	40001270 <enable_cntv>
    40000398:	f9400bf3 	ldr	x19, [sp, #16]
    4000039c:	a8c27bfd 	ldp	x29, x30, [sp], #32
    400003a0:	d50323bf 	autiasp
    400003a4:	14000373 	b	40001170 <enable_irq>
	...

00000000400003b0 <uart_putc>:
    400003b0:	d503245f 	bti	c
    400003b4:	d2a12001 	mov	x1, #0x9000000             	// #150994944
    400003b8:	39000020 	strb	w0, [x1]
    400003bc:	d65f03c0 	ret

00000000400003c0 <uart_puts>:
    400003c0:	d503245f 	bti	c
    400003c4:	39400001 	ldrb	w1, [x0]
    400003c8:	340000e1 	cbz	w1, 400003e4 <uart_puts+0x24>
    400003cc:	91000400 	add	x0, x0, #0x1
    400003d0:	d2a12002 	mov	x2, #0x9000000             	// #150994944
    400003d4:	d503201f 	nop
    400003d8:	39000041 	strb	w1, [x2]
    400003dc:	38401401 	ldrb	w1, [x0], #1
    400003e0:	35ffffc1 	cbnz	w1, 400003d8 <uart_puts+0x18>
    400003e4:	d65f03c0 	ret
    400003e8:	d503201f 	nop
    400003ec:	d503201f 	nop

00000000400003f0 <uart_putd>:
    400003f0:	d503245f 	bti	c
    400003f4:	2a0003e2 	mov	w2, w0
    400003f8:	37f800c0 	tbnz	w0, #31, 40000410 <uart_putd+0x20>
    400003fc:	35000120 	cbnz	w0, 40000420 <uart_putd+0x30>
    40000400:	d2a12000 	mov	x0, #0x9000000             	// #150994944
    40000404:	52800601 	mov	w1, #0x30                  	// #48
    40000408:	39000001 	strb	w1, [x0]
    4000040c:	d65f03c0 	ret
    40000410:	d2a12000 	mov	x0, #0x9000000             	// #150994944
    40000414:	528005a1 	mov	w1, #0x2d                  	// #45
    40000418:	4b0203e2 	neg	w2, w2
    4000041c:	39000001 	strb	w1, [x0]
    40000420:	d10083ff 	sub	sp, sp, #0x20
    40000424:	529999a7 	mov	w7, #0xcccd                	// #52429
    40000428:	72b99987 	movk	w7, #0xcccc, lsl #16
    4000042c:	910023e6 	add	x6, sp, #0x8
    40000430:	aa0603e5 	mov	x5, x6
    40000434:	52800004 	mov	w4, #0x0                   	// #0
    40000438:	9ba77c41 	umull	x1, w2, w7
    4000043c:	2a0403e3 	mov	w3, w4
    40000440:	11000484 	add	w4, w4, #0x1
    40000444:	d363fc21 	lsr	x1, x1, #35
    40000448:	0b010820 	add	w0, w1, w1, lsl #2
    4000044c:	4b000440 	sub	w0, w2, w0, lsl #1
    40000450:	2a0103e2 	mov	w2, w1
    40000454:	1100c000 	add	w0, w0, #0x30
    40000458:	380014a0 	strb	w0, [x5], #1
    4000045c:	35fffee1 	cbnz	w1, 40000438 <uart_putd+0x48>
    40000460:	8b23c0c0 	add	x0, x6, w3, sxtw
    40000464:	d10004c2 	sub	x2, x6, #0x1
    40000468:	d2a12003 	mov	x3, #0x9000000             	// #150994944
    4000046c:	d503201f 	nop
    40000470:	385ff401 	ldrb	w1, [x0], #-1
    40000474:	39000061 	strb	w1, [x3]
    40000478:	eb00005f 	cmp	x2, x0
    4000047c:	54ffffa1 	b.ne	40000470 <uart_putd+0x80>  // b.any
    40000480:	910083ff 	add	sp, sp, #0x20
    40000484:	d65f03c0 	ret
    40000488:	d503201f 	nop
    4000048c:	d503201f 	nop

0000000040000490 <uart_puthex64>:
    40000490:	d503245f 	bti	c
    40000494:	52800782 	mov	w2, #0x3c                  	// #60
    40000498:	d2a12003 	mov	x3, #0x9000000             	// #150994944
    4000049c:	14000006 	b	400004b4 <uart_puthex64+0x24>
    400004a0:	1100c021 	add	w1, w1, #0x30
    400004a4:	51001042 	sub	w2, w2, #0x4
    400004a8:	39000061 	strb	w1, [x3]
    400004ac:	3100105f 	cmn	w2, #0x4
    400004b0:	54000140 	b.eq	400004d8 <uart_puthex64+0x48>  // b.none
    400004b4:	9ac22401 	lsr	x1, x0, x2
    400004b8:	12000c21 	and	w1, w1, #0xf
    400004bc:	7100243f 	cmp	w1, #0x9
    400004c0:	54ffff09 	b.ls	400004a0 <uart_puthex64+0x10>  // b.plast
    400004c4:	11015c21 	add	w1, w1, #0x57
    400004c8:	51001042 	sub	w2, w2, #0x4
    400004cc:	39000061 	strb	w1, [x3]
    400004d0:	3100105f 	cmn	w2, #0x4
    400004d4:	54ffff01 	b.ne	400004b4 <uart_puthex64+0x24>  // b.any
    400004d8:	d65f03c0 	ret
    400004dc:	d503201f 	nop

00000000400004e0 <uart_printf>:
    400004e0:	d503245f 	bti	c
    400004e4:	aa0003e9 	mov	x9, x0
    400004e8:	d503233f 	paciasp
    400004ec:	a9b97bfd 	stp	x29, x30, [sp, #-112]!
    400004f0:	9101c3e0 	add	x0, sp, #0x70
    400004f4:	910003fd 	mov	x29, sp
    400004f8:	a90103e0 	stp	x0, x0, [sp, #16]
    400004fc:	9100c3e0 	add	x0, sp, #0x30
    40000500:	f90013e0 	str	x0, [sp, #32]
    40000504:	128006e0 	mov	w0, #0xffffffc8            	// #-56
    40000508:	b9002fff 	str	wzr, [sp, #44]
    4000050c:	b9002be0 	str	w0, [sp, #40]
    40000510:	a9038be1 	stp	x1, x2, [sp, #56]
    40000514:	a90493e3 	stp	x3, x4, [sp, #72]
    40000518:	a9059be5 	stp	x5, x6, [sp, #88]
    4000051c:	f90037e7 	str	x7, [sp, #104]
    40000520:	39400120 	ldrb	w0, [x9]
    40000524:	34000500 	cbz	w0, 400005c4 <uart_printf+0xe4>
    40000528:	52800008 	mov	w8, #0x0                   	// #0
    4000052c:	d2a1200a 	mov	x10, #0x9000000             	// #150994944
    40000530:	14000005 	b	40000544 <uart_printf+0x64>
    40000534:	39000140 	strb	w0, [x10]
    40000538:	11000508 	add	w8, w8, #0x1
    4000053c:	3868c920 	ldrb	w0, [x9, w8, sxtw]
    40000540:	34000420 	cbz	w0, 400005c4 <uart_printf+0xe4>
    40000544:	7100941f 	cmp	w0, #0x25
    40000548:	54ffff61 	b.ne	40000534 <uart_printf+0x54>  // b.any
    4000054c:	11000508 	add	w8, w8, #0x1
    40000550:	3868c920 	ldrb	w0, [x9, w8, sxtw]
    40000554:	7101901f 	cmp	w0, #0x64
    40000558:	540003c0 	b.eq	400005d0 <uart_printf+0xf0>  // b.none
    4000055c:	7101cc1f 	cmp	w0, #0x73
    40000560:	54000580 	b.eq	40000610 <uart_printf+0x130>  // b.none
    40000564:	7101e01f 	cmp	w0, #0x78
    40000568:	54fffe81 	b.ne	40000538 <uart_printf+0x58>  // b.any
    4000056c:	b9402be0 	ldr	w0, [sp, #40]
    40000570:	f9400be1 	ldr	x1, [sp, #16]
    40000574:	37f806e0 	tbnz	w0, #31, 40000650 <uart_printf+0x170>
    40000578:	91003c20 	add	x0, x1, #0xf
    4000057c:	927df000 	and	x0, x0, #0xfffffffffffffff8
    40000580:	f9000be0 	str	x0, [sp, #16]
    40000584:	f9400023 	ldr	x3, [x1]
    40000588:	d2a12002 	mov	x2, #0x9000000             	// #150994944
    4000058c:	52800781 	mov	w1, #0x3c                  	// #60
    40000590:	14000006 	b	400005a8 <uart_printf+0xc8>
    40000594:	1100c000 	add	w0, w0, #0x30
    40000598:	39000040 	strb	w0, [x2]
    4000059c:	51001021 	sub	w1, w1, #0x4
    400005a0:	3100103f 	cmn	w1, #0x4
    400005a4:	54fffca0 	b.eq	40000538 <uart_printf+0x58>  // b.none
    400005a8:	9ac12460 	lsr	x0, x3, x1
    400005ac:	12000c00 	and	w0, w0, #0xf
    400005b0:	7100241f 	cmp	w0, #0x9
    400005b4:	54ffff09 	b.ls	40000594 <uart_printf+0xb4>  // b.plast
    400005b8:	11015c00 	add	w0, w0, #0x57
    400005bc:	39000040 	strb	w0, [x2]
    400005c0:	17fffff7 	b	4000059c <uart_printf+0xbc>
    400005c4:	a8c77bfd 	ldp	x29, x30, [sp], #112
    400005c8:	d50323bf 	autiasp
    400005cc:	d65f03c0 	ret
    400005d0:	b9402be0 	ldr	w0, [sp, #40]
    400005d4:	f9400be1 	ldr	x1, [sp, #16]
    400005d8:	37f800e0 	tbnz	w0, #31, 400005f4 <uart_printf+0x114>
    400005dc:	91002c20 	add	x0, x1, #0xb
    400005e0:	927df000 	and	x0, x0, #0xfffffffffffffff8
    400005e4:	f9000be0 	str	x0, [sp, #16]
    400005e8:	b9400020 	ldr	w0, [x1]
    400005ec:	97ffff81 	bl	400003f0 <uart_putd>
    400005f0:	17ffffd2 	b	40000538 <uart_printf+0x58>
    400005f4:	11002002 	add	w2, w0, #0x8
    400005f8:	b9002be2 	str	w2, [sp, #40]
    400005fc:	7100005f 	cmp	w2, #0x0
    40000600:	54fffeec 	b.gt	400005dc <uart_printf+0xfc>
    40000604:	f9400fe1 	ldr	x1, [sp, #24]
    40000608:	8b20c021 	add	x1, x1, w0, sxtw
    4000060c:	17fffff7 	b	400005e8 <uart_printf+0x108>
    40000610:	b9402be0 	ldr	w0, [sp, #40]
    40000614:	f9400be1 	ldr	x1, [sp, #16]
    40000618:	37f802a0 	tbnz	w0, #31, 4000066c <uart_printf+0x18c>
    4000061c:	91003c20 	add	x0, x1, #0xf
    40000620:	927df000 	and	x0, x0, #0xfffffffffffffff8
    40000624:	f9000be0 	str	x0, [sp, #16]
    40000628:	f9400021 	ldr	x1, [x1]
    4000062c:	39400020 	ldrb	w0, [x1]
    40000630:	34fff840 	cbz	w0, 40000538 <uart_printf+0x58>
    40000634:	91000421 	add	x1, x1, #0x1
    40000638:	d2a12002 	mov	x2, #0x9000000             	// #150994944
    4000063c:	d503201f 	nop
    40000640:	39000040 	strb	w0, [x2]
    40000644:	38401420 	ldrb	w0, [x1], #1
    40000648:	35ffffc0 	cbnz	w0, 40000640 <uart_printf+0x160>
    4000064c:	17ffffbb 	b	40000538 <uart_printf+0x58>
    40000650:	11002002 	add	w2, w0, #0x8
    40000654:	b9002be2 	str	w2, [sp, #40]
    40000658:	7100005f 	cmp	w2, #0x0
    4000065c:	54fff8ec 	b.gt	40000578 <uart_printf+0x98>
    40000660:	f9400fe1 	ldr	x1, [sp, #24]
    40000664:	8b20c021 	add	x1, x1, w0, sxtw
    40000668:	17ffffc7 	b	40000584 <uart_printf+0xa4>
    4000066c:	11002002 	add	w2, w0, #0x8
    40000670:	b9002be2 	str	w2, [sp, #40]
    40000674:	7100005f 	cmp	w2, #0x0
    40000678:	54fffd2c 	b.gt	4000061c <uart_printf+0x13c>
    4000067c:	f9400fe1 	ldr	x1, [sp, #24]
    40000680:	8b20c021 	add	x1, x1, w0, sxtw
    40000684:	17ffffe9 	b	40000628 <uart_printf+0x148>
    40000688:	d503201f 	nop
    4000068c:	d503201f 	nop

0000000040000690 <strlen>:
    40000690:	d503245f 	bti	c
    40000694:	aa0003e2 	mov	x2, x0
    40000698:	39400000 	ldrb	w0, [x0]
    4000069c:	340000e0 	cbz	w0, 400006b8 <strlen+0x28>
    400006a0:	d2800000 	mov	x0, #0x0                   	// #0
    400006a4:	d503201f 	nop
    400006a8:	91000400 	add	x0, x0, #0x1
    400006ac:	38606841 	ldrb	w1, [x2, x0]
    400006b0:	35ffffc1 	cbnz	w1, 400006a8 <strlen+0x18>
    400006b4:	d65f03c0 	ret
    400006b8:	d2800000 	mov	x0, #0x0                   	// #0
    400006bc:	d65f03c0 	ret

00000000400006c0 <uart_getchar>:
    400006c0:	d503245f 	bti	c
    400006c4:	d2800301 	mov	x1, #0x18                  	// #24
    400006c8:	f2a12001 	movk	x1, #0x900, lsl #16
    400006cc:	d503201f 	nop
    400006d0:	b9400020 	ldr	w0, [x1]
    400006d4:	3727ffe0 	tbnz	w0, #4, 400006d0 <uart_getchar+0x10>
    400006d8:	d2a12000 	mov	x0, #0x9000000             	// #150994944
    400006dc:	b9400000 	ldr	w0, [x0]
    400006e0:	d65f03c0 	ret
    400006e4:	d503201f 	nop
    400006e8:	d503201f 	nop
    400006ec:	d503201f 	nop

00000000400006f0 <read_line>:
    400006f0:	d503245f 	bti	c
    400006f4:	7100043f 	cmp	w1, #0x1
    400006f8:	5400036d 	b.le	40000764 <read_line+0x74>
    400006fc:	d2800302 	mov	x2, #0x18                  	// #24
    40000700:	f2a12002 	movk	x2, #0x900, lsl #16
    40000704:	51000426 	sub	w6, w1, #0x1
    40000708:	52800003 	mov	w3, #0x0                   	// #0
    4000070c:	d1006044 	sub	x4, x2, #0x18
    40000710:	52800107 	mov	w7, #0x8                   	// #8
    40000714:	52800408 	mov	w8, #0x20                  	// #32
    40000718:	b9400041 	ldr	w1, [x2]
    4000071c:	3727ffe1 	tbnz	w1, #4, 40000718 <read_line+0x28>
    40000720:	b9400081 	ldr	w1, [x4]
    40000724:	12001c21 	and	w1, w1, #0xff
    40000728:	7100343f 	cmp	w1, #0xd
    4000072c:	7a4a1824 	ccmp	w1, #0xa, #0x4, ne	// ne = any
    40000730:	540002e0 	b.eq	4000078c <read_line+0x9c>  // b.none
    40000734:	7101fc3f 	cmp	w1, #0x7f
    40000738:	7a481824 	ccmp	w1, #0x8, #0x4, ne	// ne = any
    4000073c:	54000181 	b.ne	4000076c <read_line+0x7c>  // b.any
    40000740:	7100007f 	cmp	w3, #0x0
    40000744:	54fffead 	b.le	40000718 <read_line+0x28>
    40000748:	51000463 	sub	w3, w3, #0x1
    4000074c:	39000087 	strb	w7, [x4]
    40000750:	39000088 	strb	w8, [x4]
    40000754:	39000087 	strb	w7, [x4]
    40000758:	6b06007f 	cmp	w3, w6
    4000075c:	54fffdeb 	b.lt	40000718 <read_line+0x28>  // b.tstop
    40000760:	8b23c000 	add	x0, x0, w3, sxtw
    40000764:	3900001f 	strb	wzr, [x0]
    40000768:	d65f03c0 	ret
    4000076c:	51008025 	sub	w5, w1, #0x20
    40000770:	12001ca5 	and	w5, w5, #0xff
    40000774:	710178bf 	cmp	w5, #0x5e
    40000778:	54ffff08 	b.hi	40000758 <read_line+0x68>  // b.pmore
    4000077c:	3823c801 	strb	w1, [x0, w3, sxtw]
    40000780:	11000463 	add	w3, w3, #0x1
    40000784:	39000081 	strb	w1, [x4]
    40000788:	17fffff4 	b	40000758 <read_line+0x68>
    4000078c:	3823c81f 	strb	wzr, [x0, w3, sxtw]
    40000790:	528001a0 	mov	w0, #0xd                   	// #13
    40000794:	39000080 	strb	w0, [x4]
    40000798:	52800140 	mov	w0, #0xa                   	// #10
    4000079c:	39000080 	strb	w0, [x4]
    400007a0:	d65f03c0 	ret
    400007a4:	d503201f 	nop
    400007a8:	d503201f 	nop
    400007ac:	d503201f 	nop

00000000400007b0 <strcmp>:
    400007b0:	d503245f 	bti	c
    400007b4:	39400002 	ldrb	w2, [x0]
    400007b8:	350000a2 	cbnz	w2, 400007cc <strcmp+0x1c>
    400007bc:	1400000c 	b	400007ec <strcmp+0x3c>
    400007c0:	38401c02 	ldrb	w2, [x0, #1]!
    400007c4:	340000e2 	cbz	w2, 400007e0 <strcmp+0x30>
    400007c8:	91000421 	add	x1, x1, #0x1
    400007cc:	39400023 	ldrb	w3, [x1]
    400007d0:	6b02007f 	cmp	w3, w2
    400007d4:	54ffff60 	b.eq	400007c0 <strcmp+0x10>  // b.none
    400007d8:	4b030040 	sub	w0, w2, w3
    400007dc:	d65f03c0 	ret
    400007e0:	39400423 	ldrb	w3, [x1, #1]
    400007e4:	4b030040 	sub	w0, w2, w3
    400007e8:	d65f03c0 	ret
    400007ec:	39400023 	ldrb	w3, [x1]
    400007f0:	17fffffa 	b	400007d8 <strcmp+0x28>
    400007f4:	d503201f 	nop
    400007f8:	d503201f 	nop
    400007fc:	d503201f 	nop

0000000040000800 <strncmp>:
    40000800:	d503245f 	bti	c
    40000804:	35000122 	cbnz	w2, 40000828 <strncmp+0x28>
    40000808:	1400000e 	b	40000840 <strncmp+0x40>
    4000080c:	39400024 	ldrb	w4, [x1]
    40000810:	6b03009f 	cmp	w4, w3
    40000814:	540000e1 	b.ne	40000830 <strncmp+0x30>  // b.any
    40000818:	71000442 	subs	w2, w2, #0x1
    4000081c:	91000400 	add	x0, x0, #0x1
    40000820:	91000421 	add	x1, x1, #0x1
    40000824:	540000e0 	b.eq	40000840 <strncmp+0x40>  // b.none
    40000828:	39400003 	ldrb	w3, [x0]
    4000082c:	35ffff03 	cbnz	w3, 4000080c <strncmp+0xc>
    40000830:	39400000 	ldrb	w0, [x0]
    40000834:	39400021 	ldrb	w1, [x1]
    40000838:	4b010000 	sub	w0, w0, w1
    4000083c:	d65f03c0 	ret
    40000840:	52800000 	mov	w0, #0x0                   	// #0
    40000844:	d65f03c0 	ret
    40000848:	d503201f 	nop
    4000084c:	d503201f 	nop

0000000040000850 <strchr>:
    40000850:	d503245f 	bti	c
    40000854:	39400002 	ldrb	w2, [x0]
    40000858:	35000082 	cbnz	w2, 40000868 <strchr+0x18>
    4000085c:	14000006 	b	40000874 <strchr+0x24>
    40000860:	38401c02 	ldrb	w2, [x0, #1]!
    40000864:	34000082 	cbz	w2, 40000874 <strchr+0x24>
    40000868:	6b01005f 	cmp	w2, w1
    4000086c:	54ffffa1 	b.ne	40000860 <strchr+0x10>  // b.any
    40000870:	d65f03c0 	ret
    40000874:	7100003f 	cmp	w1, #0x0
    40000878:	9a9f0000 	csel	x0, x0, xzr, eq	// eq = none
    4000087c:	d65f03c0 	ret

0000000040000880 <parse_two_args>:
    40000880:	d503245f 	bti	c
    40000884:	39400003 	ldrb	w3, [x0]
    40000888:	7100807f 	cmp	w3, #0x20
    4000088c:	54000081 	b.ne	4000089c <parse_two_args+0x1c>  // b.any
    40000890:	38401c03 	ldrb	w3, [x0, #1]!
    40000894:	7100807f 	cmp	w3, #0x20
    40000898:	54ffffc0 	b.eq	40000890 <parse_two_args+0x10>  // b.none
    4000089c:	34000383 	cbz	w3, 4000090c <parse_two_args+0x8c>
    400008a0:	f9000020 	str	x0, [x1]
    400008a4:	39400001 	ldrb	w1, [x0]
    400008a8:	121a7823 	and	w3, w1, #0xffffffdf
    400008ac:	34000083 	cbz	w3, 400008bc <parse_two_args+0x3c>
    400008b0:	38401c01 	ldrb	w1, [x0, #1]!
    400008b4:	121a7823 	and	w3, w1, #0xffffffdf
    400008b8:	35ffffc3 	cbnz	w3, 400008b0 <parse_two_args+0x30>
    400008bc:	7100803f 	cmp	w1, #0x20
    400008c0:	540002a0 	b.eq	40000914 <parse_two_args+0x94>  // b.none
    400008c4:	39400001 	ldrb	w1, [x0]
    400008c8:	7100803f 	cmp	w1, #0x20
    400008cc:	54000081 	b.ne	400008dc <parse_two_args+0x5c>  // b.any
    400008d0:	38401c01 	ldrb	w1, [x0, #1]!
    400008d4:	7100803f 	cmp	w1, #0x20
    400008d8:	54ffffc0 	b.eq	400008d0 <parse_two_args+0x50>  // b.none
    400008dc:	34000181 	cbz	w1, 4000090c <parse_two_args+0x8c>
    400008e0:	f9000040 	str	x0, [x2]
    400008e4:	39400001 	ldrb	w1, [x0]
    400008e8:	121a7822 	and	w2, w1, #0xffffffdf
    400008ec:	34000082 	cbz	w2, 400008fc <parse_two_args+0x7c>
    400008f0:	38401c01 	ldrb	w1, [x0, #1]!
    400008f4:	121a7822 	and	w2, w1, #0xffffffdf
    400008f8:	35ffffc2 	cbnz	w2, 400008f0 <parse_two_args+0x70>
    400008fc:	7100803f 	cmp	w1, #0x20
    40000900:	540000e0 	b.eq	4000091c <parse_two_args+0x9c>  // b.none
    40000904:	52800020 	mov	w0, #0x1                   	// #1
    40000908:	d65f03c0 	ret
    4000090c:	52800000 	mov	w0, #0x0                   	// #0
    40000910:	d65f03c0 	ret
    40000914:	3800141f 	strb	wzr, [x0], #1
    40000918:	17ffffeb 	b	400008c4 <parse_two_args+0x44>
    4000091c:	3900001f 	strb	wzr, [x0]
    40000920:	52800020 	mov	w0, #0x1                   	// #1
    40000924:	17fffff9 	b	40000908 <parse_two_args+0x88>
	...

0000000040000930 <blk_read>:
    40000930:	d503245f 	bti	c
    40000934:	d287ffe2 	mov	x2, #0x3fff                	// #16383
    40000938:	eb02001f 	cmp	x0, x2
    4000093c:	54000148 	b.hi	40000964 <blk_read+0x34>  // b.pmore
    40000940:	b0000f22 	adrp	x2, 401e5000 <raw_framebuffer+0x1d4000>
    40000944:	91308042 	add	x2, x2, #0xc20
    40000948:	8b002843 	add	x3, x2, x0, lsl #10
    4000094c:	d2800000 	mov	x0, #0x0                   	// #0
    40000950:	38606862 	ldrb	w2, [x3, x0]
    40000954:	38206822 	strb	w2, [x1, x0]
    40000958:	91000400 	add	x0, x0, #0x1
    4000095c:	f110001f 	cmp	x0, #0x400
    40000960:	54ffff81 	b.ne	40000950 <blk_read+0x20>  // b.any
    40000964:	d65f03c0 	ret
    40000968:	d503201f 	nop
    4000096c:	d503201f 	nop

0000000040000970 <blk_write>:
    40000970:	d503245f 	bti	c
    40000974:	d287ffe2 	mov	x2, #0x3fff                	// #16383
    40000978:	eb02001f 	cmp	x0, x2
    4000097c:	54000148 	b.hi	400009a4 <blk_write+0x34>  // b.pmore
    40000980:	b0000f22 	adrp	x2, 401e5000 <raw_framebuffer+0x1d4000>
    40000984:	91308042 	add	x2, x2, #0xc20
    40000988:	8b002843 	add	x3, x2, x0, lsl #10
    4000098c:	d2800000 	mov	x0, #0x0                   	// #0
    40000990:	38606822 	ldrb	w2, [x1, x0]
    40000994:	38206862 	strb	w2, [x3, x0]
    40000998:	91000400 	add	x0, x0, #0x1
    4000099c:	f110001f 	cmp	x0, #0x400
    400009a0:	54ffff81 	b.ne	40000990 <blk_write+0x20>  // b.any
    400009a4:	d65f03c0 	ret
    400009a8:	d503201f 	nop
    400009ac:	d503201f 	nop

00000000400009b0 <mkfs>:
    400009b0:	d503245f 	bti	c
    400009b4:	d283060c 	mov	x12, #0x1830                	// #6192
    400009b8:	d503233f 	paciasp
    400009bc:	d2808002 	mov	x2, #0x400                 	// #1024
    400009c0:	cb2c63ff 	sub	sp, sp, x12
    400009c4:	52800001 	mov	w1, #0x0                   	// #0
    400009c8:	9100c3e0 	add	x0, sp, #0x30
    400009cc:	a9007bfd 	stp	x29, x30, [sp]
    400009d0:	910003fd 	mov	x29, sp
    400009d4:	a90153f3 	stp	x19, x20, [sp, #16]
    400009d8:	a9025bf5 	stp	x21, x22, [sp, #32]
    400009dc:	b0000f36 	adrp	x22, 401e5000 <raw_framebuffer+0x1d4000>
    400009e0:	913082d6 	add	x22, x22, #0xc20
    400009e4:	912002d4 	add	x20, x22, #0x800
    400009e8:	9400086a 	bl	40002b90 <memset>
    400009ec:	911002c2 	add	x2, x22, #0x400
    400009f0:	9100c3e0 	add	x0, sp, #0x30
    400009f4:	aa0003e3 	mov	x3, x0
    400009f8:	aa0203e1 	mov	x1, x2
    400009fc:	d503201f 	nop
    40000a00:	f8408424 	ldr	x4, [x1], #8
    40000a04:	f8008464 	str	x4, [x3], #8
    40000a08:	eb14003f 	cmp	x1, x20
    40000a0c:	54ffffa1 	b.ne	40000a00 <mkfs+0x50>  // b.any
    40000a10:	d2804001 	mov	x1, #0x200                 	// #512
    40000a14:	f2a7fd81 	movk	x1, #0x3fec, lsl #16
    40000a18:	f2c00021 	movk	x1, #0x1, lsl #32
    40000a1c:	f2e00041 	movk	x1, #0x2, lsl #48
    40000a20:	9110c3e3 	add	x3, sp, #0x430
    40000a24:	f9001be1 	str	x1, [sp, #48]
    40000a28:	d2800281 	mov	x1, #0x14                  	// #20
    40000a2c:	f9001fe1 	str	x1, [sp, #56]
    40000a30:	52826fe1 	mov	w1, #0x137f                	// #4991
    40000a34:	790083e1 	strh	w1, [sp, #64]
    40000a38:	f8408401 	ldr	x1, [x0], #8
    40000a3c:	f8008441 	str	x1, [x2], #8
    40000a40:	eb03001f 	cmp	x0, x3
    40000a44:	54ffffa1 	b.ne	40000a38 <mkfs+0x88>  // b.any
    40000a48:	52800001 	mov	w1, #0x0                   	// #0
    40000a4c:	d2808002 	mov	x2, #0x400                 	// #1024
    40000a50:	9110c3e0 	add	x0, sp, #0x430
    40000a54:	9110c3f3 	add	x19, sp, #0x430
    40000a58:	9400084e 	bl	40002b90 <memset>
    40000a5c:	52800020 	mov	w0, #0x1                   	// #1
    40000a60:	9120c3e1 	add	x1, sp, #0x830
    40000a64:	3910c3e0 	strb	w0, [sp, #1072]
    40000a68:	f8408660 	ldr	x0, [x19], #8
    40000a6c:	f8008680 	str	x0, [x20], #8
    40000a70:	eb01027f 	cmp	x19, x1
    40000a74:	54ffffa1 	b.ne	40000a68 <mkfs+0xb8>  // b.any
    40000a78:	d2808002 	mov	x2, #0x400                 	// #1024
    40000a7c:	52800001 	mov	w1, #0x0                   	// #0
    40000a80:	aa1303e0 	mov	x0, x19
    40000a84:	94000843 	bl	40002b90 <memset>
    40000a88:	d2808002 	mov	x2, #0x400                 	// #1024
    40000a8c:	52800001 	mov	w1, #0x0                   	// #0
    40000a90:	9130c3e0 	add	x0, sp, #0xc30
    40000a94:	9400083f 	bl	40002b90 <memset>
    40000a98:	aa0003e3 	mov	x3, x0
    40000a9c:	913002c0 	add	x0, x22, #0xc00
    40000aa0:	f8408661 	ldr	x1, [x19], #8
    40000aa4:	f8008401 	str	x1, [x0], #8
    40000aa8:	eb03027f 	cmp	x19, x3
    40000aac:	54ffffa1 	b.ne	40000aa0 <mkfs+0xf0>  // b.any
    40000ab0:	d2820609 	mov	x9, #0x1030                	// #4144
    40000ab4:	914006c0 	add	x0, x22, #0x1, lsl #12
    40000ab8:	8b2963e3 	add	x3, sp, x9
    40000abc:	d503201f 	nop
    40000ac0:	f8408661 	ldr	x1, [x19], #8
    40000ac4:	f8008401 	str	x1, [x0], #8
    40000ac8:	eb13007f 	cmp	x3, x19
    40000acc:	54ffffa1 	b.ne	40000ac0 <mkfs+0x110>  // b.any
    40000ad0:	52800001 	mov	w1, #0x0                   	// #0
    40000ad4:	d2808002 	mov	x2, #0x400                 	// #1024
    40000ad8:	aa0303e0 	mov	x0, x3
    40000adc:	9400082d 	bl	40002b90 <memset>
    40000ae0:	d2828007 	mov	x7, #0x1400                	// #5120
    40000ae4:	d2830008 	mov	x8, #0x1800                	// #6144
    40000ae8:	8b0702d4 	add	x20, x22, x7
    40000aec:	aa0003f3 	mov	x19, x0
    40000af0:	aa0003e1 	mov	x1, x0
    40000af4:	8b0802d5 	add	x21, x22, x8
    40000af8:	aa1403e0 	mov	x0, x20
    40000afc:	d503201f 	nop
    40000b00:	f8408402 	ldr	x2, [x0], #8
    40000b04:	f8008422 	str	x2, [x1], #8
    40000b08:	eb0002bf 	cmp	x21, x0
    40000b0c:	54ffffa1 	b.ne	40000b00 <mkfs+0x150>  // b.any
    40000b10:	d2828605 	mov	x5, #0x1430                	// #5168
    40000b14:	d2808002 	mov	x2, #0x400                 	// #1024
    40000b18:	52800001 	mov	w1, #0x0                   	// #0
    40000b1c:	8b2563e0 	add	x0, sp, x5
    40000b20:	9400081c 	bl	40002b90 <memset>
    40000b24:	d28a8006 	mov	x6, #0x5400                	// #21504
    40000b28:	aa1403e3 	mov	x3, x20
    40000b2c:	8b0602d6 	add	x22, x22, x6
    40000b30:	d2828604 	mov	x4, #0x1430                	// #5168
    40000b34:	aa0303e1 	mov	x1, x3
    40000b38:	8b2463e0 	add	x0, sp, x4
    40000b3c:	d503201f 	nop
    40000b40:	f8408402 	ldr	x2, [x0], #8
    40000b44:	f8008422 	str	x2, [x1], #8
    40000b48:	d2830602 	mov	x2, #0x1830                	// #6192
    40000b4c:	8b2263e2 	add	x2, sp, x2
    40000b50:	eb00005f 	cmp	x2, x0
    40000b54:	54ffff61 	b.ne	40000b40 <mkfs+0x190>  // b.any
    40000b58:	91100063 	add	x3, x3, #0x400
    40000b5c:	eb0302df 	cmp	x22, x3
    40000b60:	54fffe81 	b.ne	40000b30 <mkfs+0x180>  // b.any
    40000b64:	d2883da0 	mov	x0, #0x41ed                	// #16877
    40000b68:	b9103bff 	str	wzr, [sp, #4152]
    40000b6c:	f9081be0 	str	x0, [sp, #4144]
    40000b70:	52802000 	mov	w0, #0x100                 	// #256
    40000b74:	79207be0 	strh	w0, [sp, #4156]
    40000b78:	f8408660 	ldr	x0, [x19], #8
    40000b7c:	f8008680 	str	x0, [x20], #8
    40000b80:	eb1402bf 	cmp	x21, x20
    40000b84:	54ffffa1 	b.ne	40000b78 <mkfs+0x1c8>  // b.any
    40000b88:	d2804002 	mov	x2, #0x200                 	// #512
    40000b8c:	f2a7fd82 	movk	x2, #0x3fec, lsl #16
    40000b90:	b0000f21 	adrp	x1, 401e5000 <raw_framebuffer+0x1d4000>
    40000b94:	91302020 	add	x0, x1, #0xc08
    40000b98:	f2c00022 	movk	x2, #0x1, lsl #32
    40000b9c:	f2e00042 	movk	x2, #0x2, lsl #48
    40000ba0:	d283060c 	mov	x12, #0x1830                	// #6192
    40000ba4:	f9060422 	str	x2, [x1, #3080]
    40000ba8:	52800281 	mov	w1, #0x14                  	// #20
    40000bac:	79001001 	strh	w1, [x0, #8]
    40000bb0:	52826fe1 	mov	w1, #0x137f                	// #4991
    40000bb4:	79002001 	strh	w1, [x0, #16]
    40000bb8:	a9407bfd 	ldp	x29, x30, [sp]
    40000bbc:	a94153f3 	ldp	x19, x20, [sp, #16]
    40000bc0:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40000bc4:	8b2c63ff 	add	sp, sp, x12
    40000bc8:	d50323bf 	autiasp
    40000bcc:	d65f03c0 	ret

0000000040000bd0 <alloc_inode>:
    40000bd0:	d503245f 	bti	c
    40000bd4:	b0000f29 	adrp	x9, 401e5000 <raw_framebuffer+0x1d4000>
    40000bd8:	91302120 	add	x0, x9, #0xc08
    40000bdc:	d503233f 	paciasp
    40000be0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40000be4:	910003fd 	mov	x29, sp
    40000be8:	79400808 	ldrh	w8, [x0, #4]
    40000bec:	d3763d00 	ubfiz	x0, x8, #10, #16
    40000bf0:	cb2063ff 	sub	sp, sp, x0
    40000bf4:	910003e6 	mov	x6, sp
    40000bf8:	340002c8 	cbz	w8, 40000c50 <alloc_inode+0x80>
    40000bfc:	b0000f22 	adrp	x2, 401e5000 <raw_framebuffer+0x1d4000>
    40000c00:	91308042 	add	x2, x2, #0xc20
    40000c04:	910003e3 	mov	x3, sp
    40000c08:	91200042 	add	x2, x2, #0x800
    40000c0c:	11000907 	add	w7, w8, #0x2
    40000c10:	52800044 	mov	w4, #0x2                   	// #2
    40000c14:	5287ffe5 	mov	w5, #0x3fff                	// #16383
    40000c18:	d2800000 	mov	x0, #0x0                   	// #0
    40000c1c:	6b05009f 	cmp	w4, w5
    40000c20:	540000e8 	b.hi	40000c3c <alloc_inode+0x6c>  // b.pmore
    40000c24:	d503201f 	nop
    40000c28:	38606841 	ldrb	w1, [x2, x0]
    40000c2c:	38206861 	strb	w1, [x3, x0]
    40000c30:	91000400 	add	x0, x0, #0x1
    40000c34:	f110001f 	cmp	x0, #0x400
    40000c38:	54ffff81 	b.ne	40000c28 <alloc_inode+0x58>  // b.any
    40000c3c:	11000484 	add	w4, w4, #0x1
    40000c40:	91100063 	add	x3, x3, #0x400
    40000c44:	91100042 	add	x2, x2, #0x400
    40000c48:	6b07009f 	cmp	w4, w7
    40000c4c:	54fffe61 	b.ne	40000c18 <alloc_inode+0x48>  // b.any
    40000c50:	79581125 	ldrh	w5, [x9, #3080]
    40000c54:	52800000 	mov	w0, #0x0                   	// #0
    40000c58:	35000085 	cbnz	w5, 40000c68 <alloc_inode+0x98>
    40000c5c:	14000025 	b	40000cf0 <alloc_inode+0x120>
    40000c60:	6b0000bf 	cmp	w5, w0
    40000c64:	540004e0 	b.eq	40000d00 <alloc_inode+0x130>  // b.none
    40000c68:	53037c02 	lsr	w2, w0, #3
    40000c6c:	12000803 	and	w3, w0, #0x7
    40000c70:	3862c8c1 	ldrb	w1, [x6, w2, sxtw]
    40000c74:	11000400 	add	w0, w0, #0x1
    40000c78:	12003c00 	and	w0, w0, #0xffff
    40000c7c:	1ac32824 	asr	w4, w1, w3
    40000c80:	3707ff04 	tbnz	w4, #0, 40000c60 <alloc_inode+0x90>
    40000c84:	52800024 	mov	w4, #0x1                   	// #1
    40000c88:	1ac32083 	lsl	w3, w4, w3
    40000c8c:	2a030021 	orr	w1, w1, w3
    40000c90:	3822c8c1 	strb	w1, [x6, w2, sxtw]
    40000c94:	340002e8 	cbz	w8, 40000cf0 <alloc_inode+0x120>
    40000c98:	b0000f23 	adrp	x3, 401e5000 <raw_framebuffer+0x1d4000>
    40000c9c:	91308063 	add	x3, x3, #0xc20
    40000ca0:	91200063 	add	x3, x3, #0x800
    40000ca4:	11000908 	add	w8, w8, #0x2
    40000ca8:	d2810007 	mov	x7, #0x800                 	// #2048
    40000cac:	52800045 	mov	w5, #0x2                   	// #2
    40000cb0:	5287ffe9 	mov	w9, #0x3fff                	// #16383
    40000cb4:	d12000c6 	sub	x6, x6, #0x800
    40000cb8:	8b0700c4 	add	x4, x6, x7
    40000cbc:	d2800001 	mov	x1, #0x0                   	// #0
    40000cc0:	6b0900bf 	cmp	w5, w9
    40000cc4:	540000c8 	b.hi	40000cdc <alloc_inode+0x10c>  // b.pmore
    40000cc8:	38616882 	ldrb	w2, [x4, x1]
    40000ccc:	38216862 	strb	w2, [x3, x1]
    40000cd0:	91000421 	add	x1, x1, #0x1
    40000cd4:	f110003f 	cmp	x1, #0x400
    40000cd8:	54ffff81 	b.ne	40000cc8 <alloc_inode+0xf8>  // b.any
    40000cdc:	110004a5 	add	w5, w5, #0x1
    40000ce0:	911000e7 	add	x7, x7, #0x400
    40000ce4:	91100063 	add	x3, x3, #0x400
    40000ce8:	6b0800bf 	cmp	w5, w8
    40000cec:	54fffe61 	b.ne	40000cb8 <alloc_inode+0xe8>  // b.any
    40000cf0:	910003bf 	mov	sp, x29
    40000cf4:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40000cf8:	d50323bf 	autiasp
    40000cfc:	d65f03c0 	ret
    40000d00:	910003bf 	mov	sp, x29
    40000d04:	52800000 	mov	w0, #0x0                   	// #0
    40000d08:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40000d0c:	d50323bf 	autiasp
    40000d10:	d65f03c0 	ret
    40000d14:	d503201f 	nop
    40000d18:	d503201f 	nop
    40000d1c:	d503201f 	nop

0000000040000d20 <alloc_zone>:
    40000d20:	d503245f 	bti	c
    40000d24:	b0000f29 	adrp	x9, 401e5000 <raw_framebuffer+0x1d4000>
    40000d28:	91302129 	add	x9, x9, #0xc08
    40000d2c:	d503233f 	paciasp
    40000d30:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40000d34:	910003fd 	mov	x29, sp
    40000d38:	79400d28 	ldrh	w8, [x9, #6]
    40000d3c:	d3763d00 	ubfiz	x0, x8, #10, #16
    40000d40:	cb2063ff 	sub	sp, sp, x0
    40000d44:	910003e6 	mov	x6, sp
    40000d48:	340002c8 	cbz	w8, 40000da0 <alloc_zone+0x80>
    40000d4c:	b0000f22 	adrp	x2, 401e5000 <raw_framebuffer+0x1d4000>
    40000d50:	91308042 	add	x2, x2, #0xc20
    40000d54:	910003e3 	mov	x3, sp
    40000d58:	91300042 	add	x2, x2, #0xc00
    40000d5c:	11000d07 	add	w7, w8, #0x3
    40000d60:	52800064 	mov	w4, #0x3                   	// #3
    40000d64:	5287ffe5 	mov	w5, #0x3fff                	// #16383
    40000d68:	6b05009f 	cmp	w4, w5
    40000d6c:	54000108 	b.hi	40000d8c <alloc_zone+0x6c>  // b.pmore
    40000d70:	d2800000 	mov	x0, #0x0                   	// #0
    40000d74:	d503201f 	nop
    40000d78:	38606841 	ldrb	w1, [x2, x0]
    40000d7c:	38206861 	strb	w1, [x3, x0]
    40000d80:	91000400 	add	x0, x0, #0x1
    40000d84:	f110001f 	cmp	x0, #0x400
    40000d88:	54ffff81 	b.ne	40000d78 <alloc_zone+0x58>  // b.any
    40000d8c:	11000484 	add	w4, w4, #0x1
    40000d90:	91100063 	add	x3, x3, #0x400
    40000d94:	91100042 	add	x2, x2, #0x400
    40000d98:	6b07009f 	cmp	w4, w7
    40000d9c:	54fffe61 	b.ne	40000d68 <alloc_zone+0x48>  // b.any
    40000da0:	79400520 	ldrh	w0, [x9, #2]
    40000da4:	34000520 	cbz	w0, 40000e48 <alloc_zone+0x128>
    40000da8:	52800004 	mov	w4, #0x0                   	// #0
    40000dac:	14000005 	b	40000dc0 <alloc_zone+0xa0>
    40000db0:	11000481 	add	w1, w4, #0x1
    40000db4:	12003c24 	and	w4, w1, #0xffff
    40000db8:	6b21201f 	cmp	w0, w1, uxth
    40000dbc:	540004e0 	b.eq	40000e58 <alloc_zone+0x138>  // b.none
    40000dc0:	53037c82 	lsr	w2, w4, #3
    40000dc4:	12000883 	and	w3, w4, #0x7
    40000dc8:	3862c8c1 	ldrb	w1, [x6, w2, sxtw]
    40000dcc:	1ac32825 	asr	w5, w1, w3
    40000dd0:	3707ff05 	tbnz	w5, #0, 40000db0 <alloc_zone+0x90>
    40000dd4:	52800020 	mov	w0, #0x1                   	// #1
    40000dd8:	1ac32000 	lsl	w0, w0, w3
    40000ddc:	2a000021 	orr	w1, w1, w0
    40000de0:	3822c8c1 	strb	w1, [x6, w2, sxtw]
    40000de4:	340002e8 	cbz	w8, 40000e40 <alloc_zone+0x120>
    40000de8:	b0000f22 	adrp	x2, 401e5000 <raw_framebuffer+0x1d4000>
    40000dec:	91308042 	add	x2, x2, #0xc20
    40000df0:	91300042 	add	x2, x2, #0xc00
    40000df4:	11000d08 	add	w8, w8, #0x3
    40000df8:	d2818007 	mov	x7, #0xc00                 	// #3072
    40000dfc:	52800065 	mov	w5, #0x3                   	// #3
    40000e00:	5287ffea 	mov	w10, #0x3fff                	// #16383
    40000e04:	d13000c6 	sub	x6, x6, #0xc00
    40000e08:	6b0a00bf 	cmp	w5, w10
    40000e0c:	54000108 	b.hi	40000e2c <alloc_zone+0x10c>  // b.pmore
    40000e10:	8b0700c3 	add	x3, x6, x7
    40000e14:	d2800000 	mov	x0, #0x0                   	// #0
    40000e18:	38606861 	ldrb	w1, [x3, x0]
    40000e1c:	38206841 	strb	w1, [x2, x0]
    40000e20:	91000400 	add	x0, x0, #0x1
    40000e24:	f110001f 	cmp	x0, #0x400
    40000e28:	54ffff81 	b.ne	40000e18 <alloc_zone+0xf8>  // b.any
    40000e2c:	110004a5 	add	w5, w5, #0x1
    40000e30:	911000e7 	add	x7, x7, #0x400
    40000e34:	91100042 	add	x2, x2, #0x400
    40000e38:	6b0800bf 	cmp	w5, w8
    40000e3c:	54fffe61 	b.ne	40000e08 <alloc_zone+0xe8>  // b.any
    40000e40:	79401120 	ldrh	w0, [x9, #8]
    40000e44:	0b000080 	add	w0, w4, w0
    40000e48:	910003bf 	mov	sp, x29
    40000e4c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40000e50:	d50323bf 	autiasp
    40000e54:	d65f03c0 	ret
    40000e58:	910003bf 	mov	sp, x29
    40000e5c:	52800000 	mov	w0, #0x0                   	// #0
    40000e60:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40000e64:	d50323bf 	autiasp
    40000e68:	d65f03c0 	ret
    40000e6c:	d503201f 	nop

0000000040000e70 <free_zone>:
    40000e70:	d503245f 	bti	c
    40000e74:	b0000f21 	adrp	x1, 401e5000 <raw_framebuffer+0x1d4000>
    40000e78:	b0000f23 	adrp	x3, 401e5000 <raw_framebuffer+0x1d4000>
    40000e7c:	91308063 	add	x3, x3, #0xc20
    40000e80:	79582021 	ldrh	w1, [x1, #3088]
    40000e84:	d12003ff 	sub	sp, sp, #0x800
    40000e88:	91300064 	add	x4, x3, #0xc00
    40000e8c:	910003e2 	mov	x2, sp
    40000e90:	91400467 	add	x7, x3, #0x1, lsl #12
    40000e94:	910003e5 	mov	x5, sp
    40000e98:	4b010008 	sub	w8, w0, w1
    40000e9c:	910003e1 	mov	x1, sp
    40000ea0:	12003d08 	and	w8, w8, #0xffff
    40000ea4:	aa0403e0 	mov	x0, x4
    40000ea8:	f8408406 	ldr	x6, [x0], #8
    40000eac:	f80084a6 	str	x6, [x5], #8
    40000eb0:	eb0000ff 	cmp	x7, x0
    40000eb4:	54ffffa1 	b.ne	40000ea8 <free_zone+0x38>  // b.any
    40000eb8:	d2800000 	mov	x0, #0x0                   	// #0
    40000ebc:	d503201f 	nop
    40000ec0:	8b000066 	add	x6, x3, x0
    40000ec4:	8b000045 	add	x5, x2, x0
    40000ec8:	f94800c6 	ldr	x6, [x6, #4096]
    40000ecc:	91002000 	add	x0, x0, #0x8
    40000ed0:	f90200a6 	str	x6, [x5, #1024]
    40000ed4:	f110001f 	cmp	x0, #0x400
    40000ed8:	54ffff41 	b.ne	40000ec0 <free_zone+0x50>  // b.any
    40000edc:	53037d06 	lsr	w6, w8, #3
    40000ee0:	52800025 	mov	w5, #0x1                   	// #1
    40000ee4:	3866c840 	ldrb	w0, [x2, w6, sxtw]
    40000ee8:	12000908 	and	w8, w8, #0x7
    40000eec:	1ac820a5 	lsl	w5, w5, w8
    40000ef0:	0a250000 	bic	w0, w0, w5
    40000ef4:	91100045 	add	x5, x2, #0x400
    40000ef8:	3826c840 	strb	w0, [x2, w6, sxtw]
    40000efc:	d503201f 	nop
    40000f00:	f8408420 	ldr	x0, [x1], #8
    40000f04:	f8008480 	str	x0, [x4], #8
    40000f08:	eb0100bf 	cmp	x5, x1
    40000f0c:	54ffffa1 	b.ne	40000f00 <free_zone+0x90>  // b.any
    40000f10:	d2800000 	mov	x0, #0x0                   	// #0
    40000f14:	d503201f 	nop
    40000f18:	8b000044 	add	x4, x2, x0
    40000f1c:	8b000061 	add	x1, x3, x0
    40000f20:	f9420084 	ldr	x4, [x4, #1024]
    40000f24:	91002000 	add	x0, x0, #0x8
    40000f28:	f9080024 	str	x4, [x1, #4096]
    40000f2c:	f110001f 	cmp	x0, #0x400
    40000f30:	54ffff41 	b.ne	40000f18 <free_zone+0xa8>  // b.any
    40000f34:	912003ff 	add	sp, sp, #0x800
    40000f38:	d65f03c0 	ret
    40000f3c:	d503201f 	nop

0000000040000f40 <free_inode>:
    40000f40:	d503245f 	bti	c
    40000f44:	b0000f22 	adrp	x2, 401e5000 <raw_framebuffer+0x1d4000>
    40000f48:	91308042 	add	x2, x2, #0xc20
    40000f4c:	d11003ff 	sub	sp, sp, #0x400
    40000f50:	51000406 	sub	w6, w0, #0x1
    40000f54:	91200040 	add	x0, x2, #0x800
    40000f58:	12003cc6 	and	w6, w6, #0xffff
    40000f5c:	910003e7 	mov	x7, sp
    40000f60:	910003e3 	mov	x3, sp
    40000f64:	91300042 	add	x2, x2, #0xc00
    40000f68:	910003e4 	mov	x4, sp
    40000f6c:	aa0003e1 	mov	x1, x0
    40000f70:	f8408425 	ldr	x5, [x1], #8
    40000f74:	f8008485 	str	x5, [x4], #8
    40000f78:	eb02003f 	cmp	x1, x2
    40000f7c:	54ffffa1 	b.ne	40000f70 <free_inode+0x30>  // b.any
    40000f80:	53037cc5 	lsr	w5, w6, #3
    40000f84:	52800024 	mov	w4, #0x1                   	// #1
    40000f88:	3865c8e1 	ldrb	w1, [x7, w5, sxtw]
    40000f8c:	120008c6 	and	w6, w6, #0x7
    40000f90:	1ac62084 	lsl	w4, w4, w6
    40000f94:	0a240021 	bic	w1, w1, w4
    40000f98:	3825c8e1 	strb	w1, [x7, w5, sxtw]
    40000f9c:	d503201f 	nop
    40000fa0:	f8408461 	ldr	x1, [x3], #8
    40000fa4:	f8008401 	str	x1, [x0], #8
    40000fa8:	eb02001f 	cmp	x0, x2
    40000fac:	54ffffa1 	b.ne	40000fa0 <free_inode+0x60>  // b.any
    40000fb0:	911003ff 	add	sp, sp, #0x400
    40000fb4:	d65f03c0 	ret
    40000fb8:	d503201f 	nop
    40000fbc:	d503201f 	nop

0000000040000fc0 <read_inode>:
    40000fc0:	d503245f 	bti	c
    40000fc4:	51000400 	sub	w0, w0, #0x1
    40000fc8:	d11003ff 	sub	sp, sp, #0x400
    40000fcc:	d3453c02 	ubfx	x2, x0, #5, #11
    40000fd0:	531b1004 	ubfiz	w4, w0, #5, #5
    40000fd4:	91001442 	add	x2, x2, #0x5
    40000fd8:	b0000f20 	adrp	x0, 401e5000 <raw_framebuffer+0x1d4000>
    40000fdc:	91308000 	add	x0, x0, #0xc20
    40000fe0:	910003e5 	mov	x5, sp
    40000fe4:	8b022802 	add	x2, x0, x2, lsl #10
    40000fe8:	910003e0 	mov	x0, sp
    40000fec:	d503201f 	nop
    40000ff0:	f8408443 	ldr	x3, [x2], #8
    40000ff4:	f8008403 	str	x3, [x0], #8
    40000ff8:	911003e3 	add	x3, sp, #0x400
    40000ffc:	eb03001f 	cmp	x0, x3
    40001000:	54ffff81 	b.ne	40000ff0 <read_inode+0x30>  // b.any
    40001004:	8b2440a0 	add	x0, x5, w4, uxtw
    40001008:	a9401404 	ldp	x4, x5, [x0]
    4000100c:	a9410c02 	ldp	x2, x3, [x0, #16]
    40001010:	a9001424 	stp	x4, x5, [x1]
    40001014:	a9010c22 	stp	x2, x3, [x1, #16]
    40001018:	911003ff 	add	sp, sp, #0x400
    4000101c:	d65f03c0 	ret

0000000040001020 <write_inode>:
    40001020:	d503245f 	bti	c
    40001024:	51000400 	sub	w0, w0, #0x1
    40001028:	d11003ff 	sub	sp, sp, #0x400
    4000102c:	d3453c03 	ubfx	x3, x0, #5, #11
    40001030:	531b1006 	ubfiz	w6, w0, #5, #5
    40001034:	91001463 	add	x3, x3, #0x5
    40001038:	90000f20 	adrp	x0, 401e5000 <raw_framebuffer+0x1d4000>
    4000103c:	91308000 	add	x0, x0, #0xc20
    40001040:	910003e2 	mov	x2, sp
    40001044:	8b032803 	add	x3, x0, x3, lsl #10
    40001048:	910003e0 	mov	x0, sp
    4000104c:	aa0303e4 	mov	x4, x3
    40001050:	f8408485 	ldr	x5, [x4], #8
    40001054:	f8008445 	str	x5, [x2], #8
    40001058:	911003e5 	add	x5, sp, #0x400
    4000105c:	eb05005f 	cmp	x2, x5
    40001060:	54ffff81 	b.ne	40001050 <write_inode+0x30>  // b.any
    40001064:	a9411424 	ldp	x4, x5, [x1, #16]
    40001068:	8b264002 	add	x2, x0, w6, uxtw
    4000106c:	a9401c26 	ldp	x6, x7, [x1]
    40001070:	a9011444 	stp	x4, x5, [x2, #16]
    40001074:	a9001c46 	stp	x6, x7, [x2]
    40001078:	f8408401 	ldr	x1, [x0], #8
    4000107c:	f8008461 	str	x1, [x3], #8
    40001080:	911003e1 	add	x1, sp, #0x400
    40001084:	eb01001f 	cmp	x0, x1
    40001088:	54ffff81 	b.ne	40001078 <write_inode+0x58>  // b.any
    4000108c:	911003ff 	add	sp, sp, #0x400
    40001090:	d65f03c0 	ret
    40001094:	d503201f 	nop
    40001098:	d503201f 	nop
    4000109c:	d503201f 	nop

00000000400010a0 <bmap>:
    400010a0:	d503245f 	bti	c
    400010a4:	12003c21 	and	w1, w1, #0xffff
    400010a8:	7100183f 	cmp	w1, #0x6
    400010ac:	540000e8 	b.hi	400010c8 <bmap+0x28>  // b.pmore
    400010b0:	8b21240b 	add	x11, x0, w1, uxth #1
    400010b4:	79401d60 	ldrh	w0, [x11, #14]
    400010b8:	7100001f 	cmp	w0, #0x0
    400010bc:	7a400844 	ccmp	w2, #0x0, #0x4, eq	// eq = none
    400010c0:	54000081 	b.ne	400010d0 <bmap+0x30>  // b.any
    400010c4:	d65f03c0 	ret
    400010c8:	52800000 	mov	w0, #0x0                   	// #0
    400010cc:	d65f03c0 	ret
    400010d0:	d503233f 	paciasp
    400010d4:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    400010d8:	910003fd 	mov	x29, sp
    400010dc:	97ffff11 	bl	40000d20 <alloc_zone>
    400010e0:	72003c00 	ands	w0, w0, #0xffff
    400010e4:	54000081 	b.ne	400010f4 <bmap+0x54>  // b.any
    400010e8:	a8c17bfd 	ldp	x29, x30, [sp], #16
    400010ec:	d50323bf 	autiasp
    400010f0:	d65f03c0 	ret
    400010f4:	a8c17bfd 	ldp	x29, x30, [sp], #16
    400010f8:	d50323bf 	autiasp
    400010fc:	79001d60 	strh	w0, [x11, #14]
    40001100:	d65f03c0 	ret
	...

0000000040001110 <raw_read_current_el>:
    40001110:	d503245f 	bti	c
    40001114:	d5384240 	mrs	x0, currentel
    40001118:	d65f03c0 	ret
    4000111c:	d503201f 	nop

0000000040001120 <get_current_el>:
    40001120:	d503245f 	bti	c
    40001124:	d5384240 	mrs	x0, currentel
    40001128:	d3420c00 	ubfx	x0, x0, #2, #2
    4000112c:	d65f03c0 	ret

0000000040001130 <raw_read_daif>:
    40001130:	d503245f 	bti	c
    40001134:	d53b4220 	mrs	x0, daif
    40001138:	d65f03c0 	ret
    4000113c:	d503201f 	nop

0000000040001140 <raw_write_daif>:
    40001140:	d503245f 	bti	c
    40001144:	d51b4220 	msr	daif, x0
    40001148:	d65f03c0 	ret
    4000114c:	d503201f 	nop

0000000040001150 <enable_debug_exceptions>:
    40001150:	d503245f 	bti	c
    40001154:	d50348ff 	msr	daifclr, #0x8
    40001158:	d65f03c0 	ret
    4000115c:	d503201f 	nop

0000000040001160 <enable_serror_exceptions>:
    40001160:	d503245f 	bti	c
    40001164:	d50344ff 	msr	daifclr, #0x4
    40001168:	d65f03c0 	ret
    4000116c:	d503201f 	nop

0000000040001170 <enable_irq>:
    40001170:	d503245f 	bti	c
    40001174:	d50342ff 	msr	daifclr, #0x2
    40001178:	d65f03c0 	ret
    4000117c:	d503201f 	nop

0000000040001180 <enable_fiq>:
    40001180:	d503245f 	bti	c
    40001184:	d50341ff 	msr	daifclr, #0x1
    40001188:	d65f03c0 	ret
    4000118c:	d503201f 	nop

0000000040001190 <disable_debug_exceptions>:
    40001190:	d503245f 	bti	c
    40001194:	d50348df 	msr	daifset, #0x8
    40001198:	d65f03c0 	ret
    4000119c:	d503201f 	nop

00000000400011a0 <disable_serror_exceptions>:
    400011a0:	d503245f 	bti	c
    400011a4:	d50344df 	msr	daifset, #0x4
    400011a8:	d65f03c0 	ret
    400011ac:	d503201f 	nop

00000000400011b0 <disable_irq>:
    400011b0:	d503245f 	bti	c
    400011b4:	d50342df 	msr	daifset, #0x2
    400011b8:	d65f03c0 	ret
    400011bc:	d503201f 	nop

00000000400011c0 <disable_fiq>:
    400011c0:	d503245f 	bti	c
    400011c4:	d50341df 	msr	daifset, #0x1
    400011c8:	d65f03c0 	ret
    400011cc:	d503201f 	nop

00000000400011d0 <raw_read_spsr_el1>:
    400011d0:	d503245f 	bti	c
    400011d4:	d5384000 	mrs	x0, spsr_el1
    400011d8:	d65f03c0 	ret
    400011dc:	d503201f 	nop

00000000400011e0 <raw_write_spsr_el1>:
    400011e0:	d503245f 	bti	c
    400011e4:	d5184000 	msr	spsr_el1, x0
    400011e8:	d65f03c0 	ret
    400011ec:	d503201f 	nop

00000000400011f0 <raw_read_isr_el1>:
    400011f0:	d503245f 	bti	c
    400011f4:	d538c100 	mrs	x0, isr_el1
    400011f8:	d65f03c0 	ret
    400011fc:	d503201f 	nop

0000000040001200 <raw_read_rvbar_el1>:
    40001200:	d503245f 	bti	c
    40001204:	d538c020 	mrs	x0, rvbar_el1
    40001208:	d65f03c0 	ret
    4000120c:	d503201f 	nop

0000000040001210 <raw_write_rvbar_el1>:
    40001210:	d503245f 	bti	c
    40001214:	d518c020 	msr	rvbar_el1, x0
    40001218:	d65f03c0 	ret
    4000121c:	d503201f 	nop

0000000040001220 <raw_read_vbar_el1>:
    40001220:	d503245f 	bti	c
    40001224:	d538c000 	mrs	x0, vbar_el1
    40001228:	d65f03c0 	ret
    4000122c:	d503201f 	nop

0000000040001230 <raw_write_vbar_el1>:
    40001230:	d503245f 	bti	c
    40001234:	d518c000 	msr	vbar_el1, x0
    40001238:	d65f03c0 	ret
    4000123c:	d503201f 	nop

0000000040001240 <raw_read_cntv_ctl>:
    40001240:	d503245f 	bti	c
    40001244:	d53be320 	mrs	x0, cntv_ctl_el0
    40001248:	d65f03c0 	ret
    4000124c:	d503201f 	nop

0000000040001250 <disable_cntv>:
    40001250:	d503245f 	bti	c
    40001254:	d53be320 	mrs	x0, cntv_ctl_el0
    40001258:	121f7800 	and	w0, w0, #0xfffffffe
    4000125c:	d51be320 	msr	cntv_ctl_el0, x0
    40001260:	d65f03c0 	ret
    40001264:	d503201f 	nop
    40001268:	d503201f 	nop
    4000126c:	d503201f 	nop

0000000040001270 <enable_cntv>:
    40001270:	d503245f 	bti	c
    40001274:	d53be320 	mrs	x0, cntv_ctl_el0
    40001278:	32000000 	orr	w0, w0, #0x1
    4000127c:	d51be320 	msr	cntv_ctl_el0, x0
    40001280:	d65f03c0 	ret
    40001284:	d503201f 	nop
    40001288:	d503201f 	nop
    4000128c:	d503201f 	nop

0000000040001290 <raw_read_cntfrq_el0>:
    40001290:	d503245f 	bti	c
    40001294:	d53be000 	mrs	x0, cntfrq_el0
    40001298:	d65f03c0 	ret
    4000129c:	d503201f 	nop

00000000400012a0 <raw_write_cntfrq_el0>:
    400012a0:	d503245f 	bti	c
    400012a4:	d51be000 	msr	cntfrq_el0, x0
    400012a8:	d65f03c0 	ret
    400012ac:	d503201f 	nop

00000000400012b0 <raw_read_cntvct_el0>:
    400012b0:	d503245f 	bti	c
    400012b4:	d53be040 	mrs	x0, cntvct_el0
    400012b8:	d65f03c0 	ret
    400012bc:	d503201f 	nop

00000000400012c0 <raw_read_cntv_cval_el0>:
    400012c0:	d503245f 	bti	c
    400012c4:	d53be340 	mrs	x0, cntv_cval_el0
    400012c8:	d65f03c0 	ret
    400012cc:	d503201f 	nop

00000000400012d0 <raw_write_cntv_cval_el0>:
    400012d0:	d503245f 	bti	c
    400012d4:	d51be340 	msr	cntv_cval_el0, x0
    400012d8:	d65f03c0 	ret
    400012dc:	00000000 	udf	#0

00000000400012e0 <handle_exception>:
    400012e0:	d503233f 	paciasp
    400012e4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    400012e8:	910003fd 	mov	x29, sp
    400012ec:	f9000bf3 	str	x19, [sp, #16]
    400012f0:	aa0003f3 	mov	x19, x0
    400012f4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400012f8:	9106c000 	add	x0, x0, #0x1b0
    400012fc:	97fffc79 	bl	400004e0 <uart_printf>
    40001300:	f9400261 	ldr	x1, [x19]
    40001304:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001308:	91072000 	add	x0, x0, #0x1c8
    4000130c:	97fffc75 	bl	400004e0 <uart_printf>
    40001310:	a9419263 	ldp	x3, x4, [x19, #24]
    40001314:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001318:	91076000 	add	x0, x0, #0x1d8
    4000131c:	a9408a61 	ldp	x1, x2, [x19, #8]
    40001320:	97fffc70 	bl	400004e0 <uart_printf>
    40001324:	a9439263 	ldp	x3, x4, [x19, #56]
    40001328:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    4000132c:	91082000 	add	x0, x0, #0x208
    40001330:	a9428a61 	ldp	x1, x2, [x19, #40]
    40001334:	97fffc6b 	bl	400004e0 <uart_printf>
    40001338:	a9459263 	ldp	x3, x4, [x19, #88]
    4000133c:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001340:	9108e000 	add	x0, x0, #0x238
    40001344:	a9448a61 	ldp	x1, x2, [x19, #72]
    40001348:	97fffc66 	bl	400004e0 <uart_printf>
    4000134c:	a9479263 	ldp	x3, x4, [x19, #120]
    40001350:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001354:	9109a000 	add	x0, x0, #0x268
    40001358:	a9468a61 	ldp	x1, x2, [x19, #104]
    4000135c:	97fffc61 	bl	400004e0 <uart_printf>
    40001360:	a9499263 	ldp	x3, x4, [x19, #152]
    40001364:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001368:	910a6000 	add	x0, x0, #0x298
    4000136c:	a9488a61 	ldp	x1, x2, [x19, #136]
    40001370:	97fffc5c 	bl	400004e0 <uart_printf>
    40001374:	a94b9263 	ldp	x3, x4, [x19, #184]
    40001378:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    4000137c:	910b2000 	add	x0, x0, #0x2c8
    40001380:	a94a8a61 	ldp	x1, x2, [x19, #168]
    40001384:	97fffc57 	bl	400004e0 <uart_printf>
    40001388:	a94d9263 	ldp	x3, x4, [x19, #216]
    4000138c:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001390:	910be000 	add	x0, x0, #0x2f8
    40001394:	a94c8a61 	ldp	x1, x2, [x19, #200]
    40001398:	97fffc52 	bl	400004e0 <uart_printf>
    4000139c:	a94f9263 	ldp	x3, x4, [x19, #248]
    400013a0:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400013a4:	910ca000 	add	x0, x0, #0x328
    400013a8:	a94e8a61 	ldp	x1, x2, [x19, #232]
    400013ac:	97fffc4d 	bl	400004e0 <uart_printf>
    400013b0:	f9408e63 	ldr	x3, [x19, #280]
    400013b4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400013b8:	910d6000 	add	x0, x0, #0x358
    400013bc:	a9508a61 	ldp	x1, x2, [x19, #264]
    400013c0:	f9400bf3 	ldr	x19, [sp, #16]
    400013c4:	a8c27bfd 	ldp	x29, x30, [sp], #32
    400013c8:	d50323bf 	autiasp
    400013cc:	17fffc45 	b	400004e0 <uart_printf>

00000000400013d0 <irq_handle>:
    400013d0:	d503233f 	paciasp
    400013d4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    400013d8:	910003fd 	mov	x29, sp
    400013dc:	f9000bf3 	str	x19, [sp, #16]
    400013e0:	aa0003f3 	mov	x19, x0
    400013e4:	9100a3e0 	add	x0, sp, #0x28
    400013e8:	9400029e 	bl	40001e60 <psw_disable_and_save_interrupt>
    400013ec:	910093e1 	add	x1, sp, #0x24
    400013f0:	aa1303e0 	mov	x0, x19
    400013f4:	94000103 	bl	40001800 <gic_v3_find_pending_irq>
    400013f8:	350002a0 	cbnz	w0, 4000144c <irq_handle+0x7c>
    400013fc:	b94027e1 	ldr	w1, [sp, #36]
    40001400:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001404:	910e4000 	add	x0, x0, #0x390
    40001408:	97fffc36 	bl	400004e0 <uart_printf>
    4000140c:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001410:	910e8000 	add	x0, x0, #0x3a0
    40001414:	97fffbeb 	bl	400003c0 <uart_puts>
    40001418:	b94027e0 	ldr	w0, [sp, #36]
    4000141c:	94000065 	bl	400015b0 <gicd_disable_int>
    40001420:	b94027e0 	ldr	w0, [sp, #36]
    40001424:	94000093 	bl	40001670 <gic_v3_eoi>
    40001428:	97fffbbe 	bl	40000320 <timer_handler>
    4000142c:	b94027e0 	ldr	w0, [sp, #36]
    40001430:	94000070 	bl	400015f0 <gicd_enable_int>
    40001434:	9100a3e0 	add	x0, sp, #0x28
    40001438:	9400029a 	bl	40001ea0 <psw_restore_interrupt>
    4000143c:	f9400bf3 	ldr	x19, [sp, #16]
    40001440:	a8c37bfd 	ldp	x29, x30, [sp], #48
    40001444:	d50323bf 	autiasp
    40001448:	d65f03c0 	ret
    4000144c:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001450:	910e0000 	add	x0, x0, #0x380
    40001454:	97fffbdb 	bl	400003c0 <uart_puts>
    40001458:	9100a3e0 	add	x0, sp, #0x28
    4000145c:	94000291 	bl	40001ea0 <psw_restore_interrupt>
    40001460:	f9400bf3 	ldr	x19, [sp, #16]
    40001464:	a8c37bfd 	ldp	x29, x30, [sp], #48
    40001468:	d50323bf 	autiasp
    4000146c:	d65f03c0 	ret

0000000040001470 <common_trap_handler>:
    40001470:	d503233f 	paciasp
    40001474:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    40001478:	910003fd 	mov	x29, sp
    4000147c:	39400001 	ldrb	w1, [x0]
    40001480:	7100883f 	cmp	w1, #0x22
    40001484:	54000308 	b.hi	400014e4 <common_trap_handler+0x74>  // b.pmore
    40001488:	d2800022 	mov	x2, #0x1                   	// #1
    4000148c:	320f83e4 	mov	w4, #0x20002               	// #131074
    40001490:	9ac12042 	lsl	x2, x2, x1
    40001494:	f2c000c4 	movk	x4, #0x6, lsl #32
    40001498:	ea04005f 	tst	x2, x4
    4000149c:	540002c1 	b.ne	400014f4 <common_trap_handler+0x84>  // b.any
    400014a0:	320e83e3 	mov	w3, #0x40004               	// #262148
    400014a4:	ea03005f 	tst	x2, x3
    400014a8:	540001e0 	b.eq	400014e4 <common_trap_handler+0x74>  // b.none
    400014ac:	9100f3e1 	add	x1, sp, #0x3c
    400014b0:	940000d4 	bl	40001800 <gic_v3_find_pending_irq>
    400014b4:	35000120 	cbnz	w0, 400014d8 <common_trap_handler+0x68>
    400014b8:	b9403fe1 	ldr	w1, [sp, #60]
    400014bc:	71006c3f 	cmp	w1, #0x1b
    400014c0:	54000700 	b.eq	400015a0 <common_trap_handler+0x130>  // b.none
    400014c4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400014c8:	9111c000 	add	x0, x0, #0x470
    400014cc:	97fffc05 	bl	400004e0 <uart_printf>
    400014d0:	b9403fe0 	ldr	w0, [sp, #60]
    400014d4:	94000067 	bl	40001670 <gic_v3_eoi>
    400014d8:	a8c47bfd 	ldp	x29, x30, [sp], #64
    400014dc:	d50323bf 	autiasp
    400014e0:	d65f03c0 	ret
    400014e4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400014e8:	91122000 	add	x0, x0, #0x488
    400014ec:	97fffbfd 	bl	400004e0 <uart_printf>
    400014f0:	14000000 	b	400014f0 <common_trap_handler+0x80>
    400014f4:	f9400401 	ldr	x1, [x0, #8]
    400014f8:	aa0003e3 	mov	x3, x0
    400014fc:	f9000bf3 	str	x19, [sp, #16]
    40001500:	531a7c22 	lsr	w2, w1, #26
    40001504:	7100545f 	cmp	w2, #0x15
    40001508:	54000260 	b.eq	40001554 <common_trap_handler+0xe4>  // b.none
    4000150c:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001510:	91100000 	add	x0, x0, #0x400
    40001514:	b90023e2 	str	w2, [sp, #32]
    40001518:	f90017e3 	str	x3, [sp, #40]
    4000151c:	97fffbf1 	bl	400004e0 <uart_printf>
    40001520:	f94017e3 	ldr	x3, [sp, #40]
    40001524:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001528:	9110e000 	add	x0, x0, #0x438
    4000152c:	b94023e2 	ldr	w2, [sp, #32]
    40001530:	f9400461 	ldr	x1, [x3, #8]
    40001534:	f90013e3 	str	x3, [sp, #32]
    40001538:	97fffbea 	bl	400004e0 <uart_printf>
    4000153c:	f94013e3 	ldr	x3, [sp, #32]
    40001540:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001544:	91114000 	add	x0, x0, #0x450
    40001548:	f9400c61 	ldr	x1, [x3, #24]
    4000154c:	97fffbe5 	bl	400004e0 <uart_printf>
    40001550:	14000000 	b	40001550 <common_trap_handler+0xe0>
    40001554:	f9401400 	ldr	x0, [x0, #40]
    40001558:	12003c21 	and	w1, w1, #0xffff
    4000155c:	f90013e3 	str	x3, [sp, #32]
    40001560:	aa0003f3 	mov	x19, x0
    40001564:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001568:	910ea000 	add	x0, x0, #0x3a8
    4000156c:	97fffbdd 	bl	400004e0 <uart_printf>
    40001570:	aa1303e1 	mov	x1, x19
    40001574:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001578:	910f8000 	add	x0, x0, #0x3e0
    4000157c:	97fffbd9 	bl	400004e0 <uart_printf>
    40001580:	f94013e3 	ldr	x3, [sp, #32]
    40001584:	f9400bf3 	ldr	x19, [sp, #16]
    40001588:	f9400c60 	ldr	x0, [x3, #24]
    4000158c:	91001000 	add	x0, x0, #0x4
    40001590:	f9000c60 	str	x0, [x3, #24]
    40001594:	a8c47bfd 	ldp	x29, x30, [sp], #64
    40001598:	d50323bf 	autiasp
    4000159c:	d65f03c0 	ret
    400015a0:	97fffb60 	bl	40000320 <timer_handler>
    400015a4:	17ffffcd 	b	400014d8 <common_trap_handler+0x68>
	...

00000000400015b0 <gicd_disable_int>:
    400015b0:	d503245f 	bti	c
    400015b4:	52800c02 	mov	w2, #0x60                  	// #96
    400015b8:	72a04002 	movk	w2, #0x200, lsl #16
    400015bc:	11007c01 	add	w1, w0, #0x1f
    400015c0:	7100001f 	cmp	w0, #0x0
    400015c4:	1a80b021 	csel	w1, w1, w0, lt	// lt = tstop
    400015c8:	0b811441 	add	w1, w2, w1, asr #5
    400015cc:	52800022 	mov	w2, #0x1                   	// #1
    400015d0:	1ac02042 	lsl	w2, w2, w0
    400015d4:	531e7421 	lsl	w1, w1, #2
    400015d8:	93407c21 	sxtw	x1, w1
    400015dc:	b9000022 	str	w2, [x1]
    400015e0:	d65f03c0 	ret
    400015e4:	d503201f 	nop
    400015e8:	d503201f 	nop
    400015ec:	d503201f 	nop

00000000400015f0 <gicd_enable_int>:
    400015f0:	d503245f 	bti	c
    400015f4:	52800802 	mov	w2, #0x40                  	// #64
    400015f8:	72a04002 	movk	w2, #0x200, lsl #16
    400015fc:	11007c01 	add	w1, w0, #0x1f
    40001600:	7100001f 	cmp	w0, #0x0
    40001604:	1a80b021 	csel	w1, w1, w0, lt	// lt = tstop
    40001608:	0b811441 	add	w1, w2, w1, asr #5
    4000160c:	52800022 	mov	w2, #0x1                   	// #1
    40001610:	1ac02042 	lsl	w2, w2, w0
    40001614:	531e7421 	lsl	w1, w1, #2
    40001618:	93407c21 	sxtw	x1, w1
    4000161c:	b9000022 	str	w2, [x1]
    40001620:	d65f03c0 	ret
    40001624:	d503201f 	nop
    40001628:	d503201f 	nop
    4000162c:	d503201f 	nop

0000000040001630 <gicd_clear_pending>:
    40001630:	d503245f 	bti	c
    40001634:	52801402 	mov	w2, #0xa0                  	// #160
    40001638:	72a04002 	movk	w2, #0x200, lsl #16
    4000163c:	11007c01 	add	w1, w0, #0x1f
    40001640:	7100001f 	cmp	w0, #0x0
    40001644:	1a80b021 	csel	w1, w1, w0, lt	// lt = tstop
    40001648:	0b811441 	add	w1, w2, w1, asr #5
    4000164c:	52800022 	mov	w2, #0x1                   	// #1
    40001650:	1ac02042 	lsl	w2, w2, w0
    40001654:	531e7421 	lsl	w1, w1, #2
    40001658:	93407c21 	sxtw	x1, w1
    4000165c:	b9000022 	str	w2, [x1]
    40001660:	d65f03c0 	ret
    40001664:	d503201f 	nop
    40001668:	d503201f 	nop
    4000166c:	d503201f 	nop

0000000040001670 <gic_v3_eoi>:
    40001670:	d503245f 	bti	c
    40001674:	52801402 	mov	w2, #0xa0                  	// #160
    40001678:	72a04002 	movk	w2, #0x200, lsl #16
    4000167c:	11007c01 	add	w1, w0, #0x1f
    40001680:	7100001f 	cmp	w0, #0x0
    40001684:	1a80b021 	csel	w1, w1, w0, lt	// lt = tstop
    40001688:	0b811441 	add	w1, w2, w1, asr #5
    4000168c:	52800022 	mov	w2, #0x1                   	// #1
    40001690:	1ac02042 	lsl	w2, w2, w0
    40001694:	531e7421 	lsl	w1, w1, #2
    40001698:	93407c21 	sxtw	x1, w1
    4000169c:	b9000022 	str	w2, [x1]
    400016a0:	d65f03c0 	ret
    400016a4:	d503201f 	nop
    400016a8:	d503201f 	nop
    400016ac:	d503201f 	nop

00000000400016b0 <gic_v3_initialize>:
    400016b0:	d503233f 	paciasp
    400016b4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400016b8:	9112e000 	add	x0, x0, #0x4b8
    400016bc:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    400016c0:	910003fd 	mov	x29, sp
    400016c4:	97fffb3f 	bl	400003c0 <uart_puts>
    400016c8:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400016cc:	91134000 	add	x0, x0, #0x4d0
    400016d0:	97fffb3c 	bl	400003c0 <uart_puts>
    400016d4:	d2a10000 	mov	x0, #0x8000000             	// #134217728
    400016d8:	12800002 	mov	w2, #0xffffffff            	// #-1
    400016dc:	91110001 	add	x1, x0, #0x440
    400016e0:	b900001f 	str	wzr, [x0]
    400016e4:	b9018002 	str	w2, [x0, #384]
    400016e8:	b9018402 	str	w2, [x0, #388]
    400016ec:	b9028002 	str	w2, [x0, #640]
    400016f0:	b9028402 	str	w2, [x0, #644]
    400016f4:	91100000 	add	x0, x0, #0x400
    400016f8:	b8004402 	str	w2, [x0], #4
    400016fc:	eb01001f 	cmp	x0, x1
    40001700:	54ffffc1 	b.ne	400016f8 <gic_v3_initialize+0x48>  // b.any
    40001704:	910f8001 	add	x1, x0, #0x3e0
    40001708:	3200c3e2 	mov	w2, #0x1010101             	// #16843009
    4000170c:	91100000 	add	x0, x0, #0x400
    40001710:	b8004422 	str	w2, [x1], #4
    40001714:	eb00003f 	cmp	x1, x0
    40001718:	54ffffc1 	b.ne	40001710 <gic_v3_initialize+0x60>  // b.any
    4000171c:	b903c43f 	str	wzr, [x1, #964]
    40001720:	d1210020 	sub	x0, x1, #0x840
    40001724:	b903c83f 	str	wzr, [x1, #968]
    40001728:	b903cc3f 	str	wzr, [x1, #972]
    4000172c:	52800021 	mov	w1, #0x1                   	// #1
    40001730:	b9000001 	str	w1, [x0]
    40001734:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001738:	91138000 	add	x0, x0, #0x4e0
    4000173c:	97fffb21 	bl	400003c0 <uart_puts>
    40001740:	d2a10020 	mov	x0, #0x8010000             	// #134283264
    40001744:	52801fe1 	mov	w1, #0xff                  	// #255
    40001748:	b900001f 	str	wzr, [x0]
    4000174c:	b9000401 	str	w1, [x0, #4]
    40001750:	d2800181 	mov	x1, #0xc                   	// #12
    40001754:	f2a10021 	movk	x1, #0x801, lsl #16
    40001758:	b900081f 	str	wzr, [x0, #8]
    4000175c:	b9400020 	ldr	w0, [x1]
    40001760:	12002400 	and	w0, w0, #0x3ff
    40001764:	710ffc1f 	cmp	w0, #0x3ff
    40001768:	54000140 	b.eq	40001790 <gic_v3_initialize+0xe0>  // b.none
    4000176c:	d503201f 	nop
    40001770:	b9400022 	ldr	w2, [x1]
    40001774:	d2800200 	mov	x0, #0x10                  	// #16
    40001778:	f2a10020 	movk	x0, #0x801, lsl #16
    4000177c:	b9000002 	str	w2, [x0]
    40001780:	b9400020 	ldr	w0, [x1]
    40001784:	12002400 	and	w0, w0, #0x3ff
    40001788:	710ffc1f 	cmp	w0, #0x3ff
    4000178c:	54ffff21 	b.ne	40001770 <gic_v3_initialize+0xc0>  // b.any
    40001790:	d2a10020 	mov	x0, #0x8010000             	// #134283264
    40001794:	52800021 	mov	w1, #0x1                   	// #1
    40001798:	a8c17bfd 	ldp	x29, x30, [sp], #16
    4000179c:	d50323bf 	autiasp
    400017a0:	b9000001 	str	w1, [x0]
    400017a4:	d2818080 	mov	x0, #0xc04                 	// #3076
    400017a8:	f2a10000 	movk	x0, #0x800, lsl #16
    400017ac:	b9400001 	ldr	w1, [x0]
    400017b0:	d11fb002 	sub	x2, x0, #0x7ec
    400017b4:	12087421 	and	w1, w1, #0xff3fffff
    400017b8:	32090021 	orr	w1, w1, #0x800000
    400017bc:	b9000001 	str	w1, [x0]
    400017c0:	b9400041 	ldr	w1, [x2]
    400017c4:	12005c21 	and	w1, w1, #0xffffff
    400017c8:	b9000041 	str	w1, [x2]
    400017cc:	d10fb002 	sub	x2, x0, #0x3ec
    400017d0:	b9400041 	ldr	w1, [x2]
    400017d4:	12005c21 	and	w1, w1, #0xffffff
    400017d8:	32080021 	orr	w1, w1, #0x1000000
    400017dc:	b9000041 	str	w1, [x2]
    400017e0:	d1261002 	sub	x2, x0, #0x984
    400017e4:	52a10001 	mov	w1, #0x8000000             	// #134217728
    400017e8:	d12c1000 	sub	x0, x0, #0xb04
    400017ec:	b9000041 	str	w1, [x2]
    400017f0:	b9000001 	str	w1, [x0]
    400017f4:	d65f03c0 	ret
    400017f8:	d503201f 	nop
    400017fc:	d503201f 	nop

0000000040001800 <gic_v3_find_pending_irq>:
    40001800:	d503245f 	bti	c
    40001804:	52801005 	mov	w5, #0x80                  	// #128
    40001808:	72a04005 	movk	w5, #0x200, lsl #16
    4000180c:	52800002 	mov	w2, #0x0                   	// #0
    40001810:	52800024 	mov	w4, #0x1                   	// #1
    40001814:	14000004 	b	40001824 <gic_v3_find_pending_irq+0x24>
    40001818:	11000442 	add	w2, w2, #0x1
    4000181c:	7101005f 	cmp	w2, #0x40
    40001820:	54000160 	b.eq	4000184c <gic_v3_find_pending_irq+0x4c>  // b.none
    40001824:	0b8214a0 	add	w0, w5, w2, asr #5
    40001828:	1ac22083 	lsl	w3, w4, w2
    4000182c:	531e7400 	lsl	w0, w0, #2
    40001830:	93407c00 	sxtw	x0, w0
    40001834:	b9400000 	ldr	w0, [x0]
    40001838:	6a00007f 	tst	w3, w0
    4000183c:	54fffee0 	b.eq	40001818 <gic_v3_find_pending_irq+0x18>  // b.none
    40001840:	52800000 	mov	w0, #0x0                   	// #0
    40001844:	b9000022 	str	w2, [x1]
    40001848:	d65f03c0 	ret
    4000184c:	52800020 	mov	w0, #0x1                   	// #1
    40001850:	d65f03c0 	ret
	...

0000000040001860 <irq_handler_c>:
    40001860:	d503245f 	bti	c
    40001864:	d2800182 	mov	x2, #0xc                   	// #12
    40001868:	f2a10022 	movk	x2, #0x801, lsl #16
    4000186c:	b9400041 	ldr	w1, [x2]
    40001870:	12002420 	and	w0, w1, #0x3ff
    40001874:	510ff803 	sub	w3, w0, #0x3fe
    40001878:	7100047f 	cmp	w3, #0x1
    4000187c:	540000e9 	b.ls	40001898 <irq_handler_c+0x38>  // b.plast
    40001880:	7100781f 	cmp	w0, #0x1e
    40001884:	540000e0 	b.eq	400018a0 <irq_handler_c+0x40>  // b.none
    40001888:	d2800200 	mov	x0, #0x10                  	// #16
    4000188c:	f2a10020 	movk	x0, #0x801, lsl #16
    40001890:	b9000001 	str	w1, [x0]
    40001894:	d65f03c0 	ret
    40001898:	b9000441 	str	w1, [x2, #4]
    4000189c:	d65f03c0 	ret
    400018a0:	d503233f 	paciasp
    400018a4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400018a8:	9113c000 	add	x0, x0, #0x4f0
    400018ac:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    400018b0:	910003fd 	mov	x29, sp
    400018b4:	b9001fe1 	str	w1, [sp, #28]
    400018b8:	97fffac2 	bl	400003c0 <uart_puts>
    400018bc:	d53be000 	mrs	x0, cntfrq_el0
    400018c0:	b202e7e2 	mov	x2, #0xcccccccccccccccc    	// #-3689348814741910324
    400018c4:	f29999a2 	movk	x2, #0xcccd
    400018c8:	9bc27c00 	umulh	x0, x0, x2
    400018cc:	d343fc00 	lsr	x0, x0, #3
    400018d0:	d51be200 	msr	cntp_tval_el0, x0
    400018d4:	52800020 	mov	w0, #0x1                   	// #1
    400018d8:	d51be220 	msr	cntp_ctl_el0, x0
    400018dc:	b9401fe1 	ldr	w1, [sp, #28]
    400018e0:	d2800200 	mov	x0, #0x10                  	// #16
    400018e4:	f2a10020 	movk	x0, #0x801, lsl #16
    400018e8:	b9000001 	str	w1, [x0]
    400018ec:	a8c27bfd 	ldp	x29, x30, [sp], #32
    400018f0:	d50323bf 	autiasp
    400018f4:	d65f03c0 	ret
	...

0000000040001900 <cmd_mkfs>:
    40001900:	d503233f 	paciasp
    40001904:	d11043ff 	sub	sp, sp, #0x410
    40001908:	a9007bfd 	stp	x29, x30, [sp]
    4000190c:	910003fd 	mov	x29, sp
    40001910:	97fffc28 	bl	400009b0 <mkfs>
    40001914:	d2808002 	mov	x2, #0x400                 	// #1024
    40001918:	52800001 	mov	w1, #0x0                   	// #0
    4000191c:	910043e0 	add	x0, sp, #0x10
    40001920:	9400049c 	bl	40002b90 <memset>
    40001924:	910043e1 	add	x1, sp, #0x10
    40001928:	d2800020 	mov	x0, #0x1                   	// #1
    4000192c:	97fffc01 	bl	40000930 <blk_read>
    40001930:	794043e1 	ldrh	w1, [sp, #32]
    40001934:	52826fe0 	mov	w0, #0x137f                	// #4991
    40001938:	6b00003f 	cmp	w1, w0
    4000193c:	540000a0 	b.eq	40001950 <cmd_mkfs+0x50>  // b.none
    40001940:	a9407bfd 	ldp	x29, x30, [sp]
    40001944:	911043ff 	add	sp, sp, #0x410
    40001948:	d50323bf 	autiasp
    4000194c:	d65f03c0 	ret
    40001950:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001954:	91140000 	add	x0, x0, #0x500
    40001958:	97fffae2 	bl	400004e0 <uart_printf>
    4000195c:	a9407bfd 	ldp	x29, x30, [sp]
    40001960:	911043ff 	add	sp, sp, #0x410
    40001964:	d50323bf 	autiasp
    40001968:	d65f03c0 	ret
    4000196c:	d503201f 	nop

0000000040001970 <test_inode>:
    40001970:	d503233f 	paciasp
    40001974:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    40001978:	910003fd 	mov	x29, sp
    4000197c:	52800020 	mov	w0, #0x1                   	// #1
    40001980:	a90153f3 	stp	x19, x20, [sp, #16]
    40001984:	b0008f34 	adrp	x20, 411e6000 <irq_stack+0x3c0>
    40001988:	91310293 	add	x19, x20, #0xc40
    4000198c:	aa1303e1 	mov	x1, x19
    40001990:	97fffd8c 	bl	40000fc0 <read_inode>
    40001994:	79588281 	ldrh	w1, [x20, #3136]
    40001998:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    4000199c:	9114e000 	add	x0, x0, #0x538
    400019a0:	97fffad0 	bl	400004e0 <uart_printf>
    400019a4:	b9400661 	ldr	w1, [x19, #4]
    400019a8:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400019ac:	91158000 	add	x0, x0, #0x560
    400019b0:	97fffacc 	bl	400004e0 <uart_printf>
    400019b4:	52801000 	mov	w0, #0x80                  	// #128
    400019b8:	aa1303e1 	mov	x1, x19
    400019bc:	b9000660 	str	w0, [x19, #4]
    400019c0:	52800020 	mov	w0, #0x1                   	// #1
    400019c4:	97fffd97 	bl	40001020 <write_inode>
    400019c8:	52800020 	mov	w0, #0x1                   	// #1
    400019cc:	910083e1 	add	x1, sp, #0x20
    400019d0:	97fffd7c 	bl	40000fc0 <read_inode>
    400019d4:	b94027e0 	ldr	w0, [sp, #36]
    400019d8:	7102001f 	cmp	w0, #0x80
    400019dc:	54000100 	b.eq	400019fc <test_inode+0x8c>  // b.none
    400019e0:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    400019e4:	91174000 	add	x0, x0, #0x5d0
    400019e8:	97fffa76 	bl	400003c0 <uart_puts>
    400019ec:	a94153f3 	ldp	x19, x20, [sp, #16]
    400019f0:	a8c47bfd 	ldp	x29, x30, [sp], #64
    400019f4:	d50323bf 	autiasp
    400019f8:	d65f03c0 	ret
    400019fc:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001a00:	91160000 	add	x0, x0, #0x580
    40001a04:	97fffa6f 	bl	400003c0 <uart_puts>
    40001a08:	a94153f3 	ldp	x19, x20, [sp, #16]
    40001a0c:	a8c47bfd 	ldp	x29, x30, [sp], #64
    40001a10:	d50323bf 	autiasp
    40001a14:	d65f03c0 	ret
    40001a18:	d503201f 	nop
    40001a1c:	d503201f 	nop

0000000040001a20 <cmd_echo>:
    40001a20:	d503245f 	bti	c
    40001a24:	aa0003e1 	mov	x1, x0
    40001a28:	d503233f 	paciasp
    40001a2c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40001a30:	910003fd 	mov	x29, sp
    40001a34:	91001000 	add	x0, x0, #0x4
    40001a38:	39401021 	ldrb	w1, [x1, #4]
    40001a3c:	7100803f 	cmp	w1, #0x20
    40001a40:	540000a1 	b.ne	40001a54 <cmd_echo+0x34>  // b.any
    40001a44:	d503201f 	nop
    40001a48:	38401c01 	ldrb	w1, [x0, #1]!
    40001a4c:	7100803f 	cmp	w1, #0x20
    40001a50:	54ffffc0 	b.eq	40001a48 <cmd_echo+0x28>  // b.none
    40001a54:	97fffa5b 	bl	400003c0 <uart_puts>
    40001a58:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40001a5c:	52800140 	mov	w0, #0xa                   	// #10
    40001a60:	d50323bf 	autiasp
    40001a64:	17fffa53 	b	400003b0 <uart_putc>
    40001a68:	d503201f 	nop
    40001a6c:	d503201f 	nop

0000000040001a70 <cmd_alloc_inode>:
    40001a70:	d503233f 	paciasp
    40001a74:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40001a78:	910003fd 	mov	x29, sp
    40001a7c:	97fffc55 	bl	40000bd0 <alloc_inode>
    40001a80:	12003c00 	and	w0, w0, #0xffff
    40001a84:	7100081f 	cmp	w0, #0x2
    40001a88:	54000080 	b.eq	40001a98 <cmd_alloc_inode+0x28>  // b.none
    40001a8c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40001a90:	d50323bf 	autiasp
    40001a94:	d65f03c0 	ret
    40001a98:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40001a9c:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001aa0:	91186000 	add	x0, x0, #0x618
    40001aa4:	d50323bf 	autiasp
    40001aa8:	17fffa46 	b	400003c0 <uart_puts>
    40001aac:	d503201f 	nop

0000000040001ab0 <exception_svc>:
    40001ab0:	d503245f 	bti	c
    40001ab4:	d41bd5a1 	svc	#0xdead
    40001ab8:	d65f03c0 	ret
    40001abc:	d503201f 	nop

0000000040001ac0 <exception_svc_test>:
    40001ac0:	d503233f 	paciasp
    40001ac4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001ac8:	9118e000 	add	x0, x0, #0x638
    40001acc:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40001ad0:	910003fd 	mov	x29, sp
    40001ad4:	97fffa3b 	bl	400003c0 <uart_puts>
    40001ad8:	d41bd5a1 	svc	#0xdead
    40001adc:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001ae0:	91196000 	add	x0, x0, #0x658
    40001ae4:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40001ae8:	d50323bf 	autiasp
    40001aec:	17fffa35 	b	400003c0 <uart_puts>

0000000040001af0 <kmain>:
    40001af0:	d503233f 	paciasp
    40001af4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001af8:	9119e000 	add	x0, x0, #0x678
    40001afc:	a9a57bfd 	stp	x29, x30, [sp, #-432]!
    40001b00:	910003fd 	mov	x29, sp
    40001b04:	a90153f3 	stp	x19, x20, [sp, #16]
    40001b08:	90000034 	adrp	x20, 40005000 <tanf+0x30>
    40001b0c:	911ae294 	add	x20, x20, #0x6b8
    40001b10:	90000033 	adrp	x19, 40005000 <tanf+0x30>
    40001b14:	911b0273 	add	x19, x19, #0x6c0
    40001b18:	a9025bf5 	stp	x21, x22, [sp, #32]
    40001b1c:	90000035 	adrp	x21, 40005000 <tanf+0x30>
    40001b20:	911b22b5 	add	x21, x21, #0x6c8
    40001b24:	90000036 	adrp	x22, 40005000 <tanf+0x30>
    40001b28:	911b42d6 	add	x22, x22, #0x6d0
    40001b2c:	a90363f7 	stp	x23, x24, [sp, #48]
    40001b30:	90000037 	adrp	x23, 40005000 <tanf+0x30>
    40001b34:	911b82f7 	add	x23, x23, #0x6e0
    40001b38:	90000038 	adrp	x24, 40005000 <tanf+0x30>
    40001b3c:	911bc318 	add	x24, x24, #0x6f0
    40001b40:	a9046bf9 	stp	x25, x26, [sp, #64]
    40001b44:	90000039 	adrp	x25, 40005000 <tanf+0x30>
    40001b48:	911be339 	add	x25, x25, #0x6f8
    40001b4c:	9000003a 	adrp	x26, 40005000 <tanf+0x30>
    40001b50:	911c035a 	add	x26, x26, #0x700
    40001b54:	97fffa1b 	bl	400003c0 <uart_puts>
    40001b58:	d0000000 	adrp	x0, 40003000 <vectors>
    40001b5c:	91000000 	add	x0, x0, #0x0
    40001b60:	97fffdb4 	bl	40001230 <raw_write_vbar_el1>
    40001b64:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001b68:	911a4000 	add	x0, x0, #0x690
    40001b6c:	97fffa15 	bl	400003c0 <uart_puts>
    40001b70:	97fff9fc 	bl	40000360 <timer_test>
    40001b74:	b0008f20 	adrp	x0, 411e6000 <irq_stack+0x3c0>
    40001b78:	91318000 	add	x0, x0, #0xc60
    40001b7c:	94000419 	bl	40002be0 <init_mmu>
    40001b80:	97fff920 	bl	40000000 <ramfb_init>
    40001b84:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001b88:	911c2000 	add	x0, x0, #0x708
    40001b8c:	f9002fe0 	str	x0, [sp, #88]
    40001b90:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001b94:	911c4000 	add	x0, x0, #0x710
    40001b98:	f90033e0 	str	x0, [sp, #96]
    40001b9c:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001ba0:	911ca000 	add	x0, x0, #0x728
    40001ba4:	f90037e0 	str	x0, [sp, #104]
    40001ba8:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001bac:	911cc000 	add	x0, x0, #0x730
    40001bb0:	f9003be0 	str	x0, [sp, #112]
    40001bb4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001bb8:	911ce000 	add	x0, x0, #0x738
    40001bbc:	f9003fe0 	str	x0, [sp, #120]
    40001bc0:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001bc4:	911d2000 	add	x0, x0, #0x748
    40001bc8:	f90043e0 	str	x0, [sp, #128]
    40001bcc:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001bd0:	911d4000 	add	x0, x0, #0x750
    40001bd4:	f90047e0 	str	x0, [sp, #136]
    40001bd8:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001bdc:	911d8000 	add	x0, x0, #0x760
    40001be0:	f9004be0 	str	x0, [sp, #144]
    40001be4:	90000020 	adrp	x0, 40005000 <tanf+0x30>
    40001be8:	911dc000 	add	x0, x0, #0x770
    40001bec:	f9004fe0 	str	x0, [sp, #152]
    40001bf0:	aa1403e0 	mov	x0, x20
    40001bf4:	97fff9f3 	bl	400003c0 <uart_puts>
    40001bf8:	52802001 	mov	w1, #0x100                 	// #256
    40001bfc:	9102c3e0 	add	x0, sp, #0xb0
    40001c00:	97fffabc 	bl	400006f0 <read_line>
    40001c04:	528000a2 	mov	w2, #0x5                   	// #5
    40001c08:	aa1303e1 	mov	x1, x19
    40001c0c:	9102c3e0 	add	x0, sp, #0xb0
    40001c10:	97fffafc 	bl	40000800 <strncmp>
    40001c14:	35000300 	cbnz	w0, 40001c74 <kmain+0x184>
    40001c18:	528007c1 	mov	w1, #0x3e                  	// #62
    40001c1c:	9102c3e0 	add	x0, sp, #0xb0
    40001c20:	97fffb0c 	bl	40000850 <strchr>
    40001c24:	aa0003e2 	mov	x2, x0
    40001c28:	b4000420 	cbz	x0, 40001cac <kmain+0x1bc>
    40001c2c:	3900001f 	strb	wzr, [x0]
    40001c30:	3942d7e0 	ldrb	w0, [sp, #181]
    40001c34:	7100801f 	cmp	w0, #0x20
    40001c38:	9102d7e0 	add	x0, sp, #0xb5
    40001c3c:	54000081 	b.ne	40001c4c <kmain+0x15c>  // b.any
    40001c40:	38401c01 	ldrb	w1, [x0, #1]!
    40001c44:	7100803f 	cmp	w1, #0x20
    40001c48:	54ffffc0 	b.eq	40001c40 <kmain+0x150>  // b.none
    40001c4c:	91000441 	add	x1, x2, #0x1
    40001c50:	39400442 	ldrb	w2, [x2, #1]
    40001c54:	7100805f 	cmp	w2, #0x20
    40001c58:	540000a1 	b.ne	40001c6c <kmain+0x17c>  // b.any
    40001c5c:	d503201f 	nop
    40001c60:	38401c22 	ldrb	w2, [x1, #1]!
    40001c64:	7100805f 	cmp	w2, #0x20
    40001c68:	54ffffc0 	b.eq	40001c60 <kmain+0x170>  // b.none
    40001c6c:	9400025d 	bl	400025e0 <cmd_echo_to_file>
    40001c70:	17ffffe0 	b	40001bf0 <kmain+0x100>
    40001c74:	aa1503e1 	mov	x1, x21
    40001c78:	9102c3e0 	add	x0, sp, #0xb0
    40001c7c:	97fffacd 	bl	400007b0 <strcmp>
    40001c80:	35000060 	cbnz	w0, 40001c8c <kmain+0x19c>
    40001c84:	94000187 	bl	400022a0 <cmd_ls>
    40001c88:	17ffffda 	b	40001bf0 <kmain+0x100>
    40001c8c:	52800142 	mov	w2, #0xa                   	// #10
    40001c90:	aa1603e1 	mov	x1, x22
    40001c94:	9102c3e0 	add	x0, sp, #0xb0
    40001c98:	97fffada 	bl	40000800 <strncmp>
    40001c9c:	35000200 	cbnz	w0, 40001cdc <kmain+0x1ec>
    40001ca0:	9102ebe0 	add	x0, sp, #0xba
    40001ca4:	940001b7 	bl	40002380 <cmd_create_f>
    40001ca8:	17ffffd2 	b	40001bf0 <kmain+0x100>
    40001cac:	3942d3e1 	ldrb	w1, [sp, #180]
    40001cb0:	9102d3e0 	add	x0, sp, #0xb4
    40001cb4:	7100803f 	cmp	w1, #0x20
    40001cb8:	540000a1 	b.ne	40001ccc <kmain+0x1dc>  // b.any
    40001cbc:	d503201f 	nop
    40001cc0:	38401c01 	ldrb	w1, [x0, #1]!
    40001cc4:	7100803f 	cmp	w1, #0x20
    40001cc8:	54ffffc0 	b.eq	40001cc0 <kmain+0x1d0>  // b.none
    40001ccc:	97fff9bd 	bl	400003c0 <uart_puts>
    40001cd0:	52800140 	mov	w0, #0xa                   	// #10
    40001cd4:	97fff9b7 	bl	400003b0 <uart_putc>
    40001cd8:	17ffffc6 	b	40001bf0 <kmain+0x100>
    40001cdc:	52800142 	mov	w2, #0xa                   	// #10
    40001ce0:	aa1703e1 	mov	x1, x23
    40001ce4:	9102c3e0 	add	x0, sp, #0xb0
    40001ce8:	97fffac6 	bl	40000800 <strncmp>
    40001cec:	35000080 	cbnz	w0, 40001cfc <kmain+0x20c>
    40001cf0:	9102ebe0 	add	x0, sp, #0xba
    40001cf4:	940001cf 	bl	40002430 <cmd_create_d>
    40001cf8:	17ffffbe 	b	40001bf0 <kmain+0x100>
    40001cfc:	528000a2 	mov	w2, #0x5                   	// #5
    40001d00:	aa1803e1 	mov	x1, x24
    40001d04:	9102c3e0 	add	x0, sp, #0xb0
    40001d08:	97fffabe 	bl	40000800 <strncmp>
    40001d0c:	35000080 	cbnz	w0, 40001d1c <kmain+0x22c>
    40001d10:	9102d7e0 	add	x0, sp, #0xb5
    40001d14:	940001f3 	bl	400024e0 <cmd_show>
    40001d18:	17ffffb6 	b	40001bf0 <kmain+0x100>
    40001d1c:	52800062 	mov	w2, #0x3                   	// #3
    40001d20:	aa1903e1 	mov	x1, x25
    40001d24:	9102c3e0 	add	x0, sp, #0xb0
    40001d28:	97fffab6 	bl	40000800 <strncmp>
    40001d2c:	34000260 	cbz	w0, 40001d78 <kmain+0x288>
    40001d30:	52800062 	mov	w2, #0x3                   	// #3
    40001d34:	aa1a03e1 	mov	x1, x26
    40001d38:	9102c3e0 	add	x0, sp, #0xb0
    40001d3c:	97fffab1 	bl	40000800 <strncmp>
    40001d40:	340002e0 	cbz	w0, 40001d9c <kmain+0x2ac>
    40001d44:	f9402fe1 	ldr	x1, [sp, #88]
    40001d48:	52800062 	mov	w2, #0x3                   	// #3
    40001d4c:	9102c3e0 	add	x0, sp, #0xb0
    40001d50:	97fffaac 	bl	40000800 <strncmp>
    40001d54:	35000360 	cbnz	w0, 40001dc0 <kmain+0x2d0>
    40001d58:	9102a3e2 	add	x2, sp, #0xa8
    40001d5c:	910283e1 	add	x1, sp, #0xa0
    40001d60:	9102cfe0 	add	x0, sp, #0xb3
    40001d64:	97fffac7 	bl	40000880 <parse_two_args>
    40001d68:	34000420 	cbz	w0, 40001dec <kmain+0x2fc>
    40001d6c:	a94a07e0 	ldp	x0, x1, [sp, #160]
    40001d70:	94000274 	bl	40002740 <cmd_mv>
    40001d74:	17ffff9f 	b	40001bf0 <kmain+0x100>
    40001d78:	3942cfe0 	ldrb	w0, [sp, #179]
    40001d7c:	7100801f 	cmp	w0, #0x20
    40001d80:	9102cfe0 	add	x0, sp, #0xb3
    40001d84:	54000081 	b.ne	40001d94 <kmain+0x2a4>  // b.any
    40001d88:	38401c01 	ldrb	w1, [x0, #1]!
    40001d8c:	7100803f 	cmp	w1, #0x20
    40001d90:	54ffffc0 	b.eq	40001d88 <kmain+0x298>  // b.none
    40001d94:	9400024b 	bl	400026c0 <cmd_cd>
    40001d98:	17ffff96 	b	40001bf0 <kmain+0x100>
    40001d9c:	3942cfe0 	ldrb	w0, [sp, #179]
    40001da0:	7100801f 	cmp	w0, #0x20
    40001da4:	9102cfe0 	add	x0, sp, #0xb3
    40001da8:	54000081 	b.ne	40001db8 <kmain+0x2c8>  // b.any
    40001dac:	38401c01 	ldrb	w1, [x0, #1]!
    40001db0:	7100803f 	cmp	w1, #0x20
    40001db4:	54ffffc0 	b.eq	40001dac <kmain+0x2bc>  // b.none
    40001db8:	940002b6 	bl	40002890 <cmd_rm>
    40001dbc:	17ffff8d 	b	40001bf0 <kmain+0x100>
    40001dc0:	f94037e1 	ldr	x1, [sp, #104]
    40001dc4:	9102c3e0 	add	x0, sp, #0xb0
    40001dc8:	97fffa7a 	bl	400007b0 <strcmp>
    40001dcc:	34000160 	cbz	w0, 40001df8 <kmain+0x308>
    40001dd0:	f9403be1 	ldr	x1, [sp, #112]
    40001dd4:	9102c3e0 	add	x0, sp, #0xb0
    40001dd8:	97fffa76 	bl	400007b0 <strcmp>
    40001ddc:	35000120 	cbnz	w0, 40001e00 <kmain+0x310>
    40001de0:	f9403fe0 	ldr	x0, [sp, #120]
    40001de4:	97fff977 	bl	400003c0 <uart_puts>
    40001de8:	17ffff82 	b	40001bf0 <kmain+0x100>
    40001dec:	f94033e0 	ldr	x0, [sp, #96]
    40001df0:	97fff974 	bl	400003c0 <uart_puts>
    40001df4:	17ffff7f 	b	40001bf0 <kmain+0x100>
    40001df8:	97fffec2 	bl	40001900 <cmd_mkfs>
    40001dfc:	17ffff7d 	b	40001bf0 <kmain+0x100>
    40001e00:	f94043e1 	ldr	x1, [sp, #128]
    40001e04:	9102c3e0 	add	x0, sp, #0xb0
    40001e08:	97fffa6a 	bl	400007b0 <strcmp>
    40001e0c:	340000e0 	cbz	w0, 40001e28 <kmain+0x338>
    40001e10:	f94047e1 	ldr	x1, [sp, #136]
    40001e14:	9102c3e0 	add	x0, sp, #0xb0
    40001e18:	97fffa66 	bl	400007b0 <strcmp>
    40001e1c:	350000a0 	cbnz	w0, 40001e30 <kmain+0x340>
    40001e20:	97ffff14 	bl	40001a70 <cmd_alloc_inode>
    40001e24:	17ffff73 	b	40001bf0 <kmain+0x100>
    40001e28:	9400097e 	bl	40004420 <start_raytracer>
    40001e2c:	17ffff71 	b	40001bf0 <kmain+0x100>
    40001e30:	f9404be1 	ldr	x1, [sp, #144]
    40001e34:	9102c3e0 	add	x0, sp, #0xb0
    40001e38:	97fffa5e 	bl	400007b0 <strcmp>
    40001e3c:	340000c0 	cbz	w0, 40001e54 <kmain+0x364>
    40001e40:	3942c3e0 	ldrb	w0, [sp, #176]
    40001e44:	34ffed60 	cbz	w0, 40001bf0 <kmain+0x100>
    40001e48:	f9404fe0 	ldr	x0, [sp, #152]
    40001e4c:	97fff95d 	bl	400003c0 <uart_puts>
    40001e50:	17ffff68 	b	40001bf0 <kmain+0x100>
    40001e54:	97fffec7 	bl	40001970 <test_inode>
    40001e58:	17ffff66 	b	40001bf0 <kmain+0x100>
    40001e5c:	00000000 	udf	#0

0000000040001e60 <psw_disable_and_save_interrupt>:
    40001e60:	d503233f 	paciasp
    40001e64:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    40001e68:	910003fd 	mov	x29, sp
    40001e6c:	a90153f3 	stp	x19, x20, [sp, #16]
    40001e70:	aa0003f3 	mov	x19, x0
    40001e74:	97fffcaf 	bl	40001130 <raw_read_daif>
    40001e78:	2a0003f4 	mov	w20, w0
    40001e7c:	97fffccd 	bl	400011b0 <disable_irq>
    40001e80:	f9000274 	str	x20, [x19]
    40001e84:	a94153f3 	ldp	x19, x20, [sp, #16]
    40001e88:	a8c27bfd 	ldp	x29, x30, [sp], #32
    40001e8c:	d50323bf 	autiasp
    40001e90:	d65f03c0 	ret
    40001e94:	d503201f 	nop
    40001e98:	d503201f 	nop
    40001e9c:	d503201f 	nop

0000000040001ea0 <psw_restore_interrupt>:
    40001ea0:	d503245f 	bti	c
    40001ea4:	b9400000 	ldr	w0, [x0]
    40001ea8:	17fffca6 	b	40001140 <raw_write_daif>
    40001eac:	00000000 	udf	#0

0000000040001eb0 <dummy_user_app>:
    40001eb0:	d503245f 	bti	c
    40001eb4:	90000021 	adrp	x1, 40005000 <tanf+0x30>
    40001eb8:	911e2021 	add	x1, x1, #0x788
    40001ebc:	aa0103e0 	mov	x0, x1
    40001ec0:	d41bd5a1 	svc	#0xdead
    40001ec4:	14000000 	b	40001ec4 <dummy_user_app+0x14>
    40001ec8:	d503201f 	nop
    40001ecc:	d503201f 	nop

0000000040001ed0 <dir_add_entry>:
    40001ed0:	d503233f 	paciasp
    40001ed4:	d11143ff 	sub	sp, sp, #0x450
    40001ed8:	a9007bfd 	stp	x29, x30, [sp]
    40001edc:	910003fd 	mov	x29, sp
    40001ee0:	a90153f3 	stp	x19, x20, [sp, #16]
    40001ee4:	aa0003f4 	mov	x20, x0
    40001ee8:	a90363f7 	stp	x23, x24, [sp, #48]
    40001eec:	aa0203f7 	mov	x23, x2
    40001ef0:	2a0303f8 	mov	w24, w3
    40001ef4:	a9046bf9 	stp	x25, x26, [sp, #64]
    40001ef8:	2a0103fa 	mov	w26, w1
    40001efc:	b9400400 	ldr	w0, [x0, #4]
    40001f00:	6b402bff 	cmp	wzr, w0, lsr #10
    40001f04:	540007c0 	b.eq	40001ffc <dir_add_entry+0x12c>  // b.none
    40001f08:	52800019 	mov	w25, #0x0                   	// #0
    40001f0c:	a9025bf5 	stp	x21, x22, [sp, #32]
    40001f10:	910143f6 	add	x22, sp, #0x50
    40001f14:	52800002 	mov	w2, #0x0                   	// #0
    40001f18:	2a1903e1 	mov	w1, w25
    40001f1c:	aa1403e0 	mov	x0, x20
    40001f20:	aa1603f3 	mov	x19, x22
    40001f24:	97fffc5f 	bl	400010a0 <bmap>
    40001f28:	92403c15 	and	x21, x0, #0xffff
    40001f2c:	aa1603e1 	mov	x1, x22
    40001f30:	aa1503e0 	mov	x0, x21
    40001f34:	97fffa7f 	bl	40000930 <blk_read>
    40001f38:	14000005 	b	40001f4c <dir_add_entry+0x7c>
    40001f3c:	91004273 	add	x19, x19, #0x10
    40001f40:	911143e0 	add	x0, sp, #0x450
    40001f44:	eb00027f 	cmp	x19, x0
    40001f48:	54000480 	b.eq	40001fd8 <dir_add_entry+0x108>  // b.none
    40001f4c:	79400262 	ldrh	w2, [x19]
    40001f50:	35ffff62 	cbnz	w2, 40001f3c <dir_add_entry+0x6c>
    40001f54:	aa1303f4 	mov	x20, x19
    40001f58:	aa1703e0 	mov	x0, x23
    40001f5c:	78002698 	strh	w24, [x20], #2
    40001f60:	97fff9cc 	bl	40000690 <strlen>
    40001f64:	f100381f 	cmp	x0, #0xe
    40001f68:	d28001c3 	mov	x3, #0xe                   	// #14
    40001f6c:	9a839003 	csel	x3, x0, x3, ls	// ls = plast
    40001f70:	d2800001 	mov	x1, #0x0                   	// #0
    40001f74:	b4000100 	cbz	x0, 40001f94 <dir_add_entry+0xc4>
    40001f78:	38616ae2 	ldrb	w2, [x23, x1]
    40001f7c:	38216a82 	strb	w2, [x20, x1]
    40001f80:	91000421 	add	x1, x1, #0x1
    40001f84:	eb01007f 	cmp	x3, x1
    40001f88:	54ffff88 	b.hi	40001f78 <dir_add_entry+0xa8>  // b.pmore
    40001f8c:	f100341f 	cmp	x0, #0xd
    40001f90:	540000e8 	b.hi	40001fac <dir_add_entry+0xdc>  // b.pmore
    40001f94:	8b030281 	add	x1, x20, x3
    40001f98:	91004273 	add	x19, x19, #0x10
    40001f9c:	d503201f 	nop
    40001fa0:	3800143f 	strb	wzr, [x1], #1
    40001fa4:	eb01027f 	cmp	x19, x1
    40001fa8:	54ffffc1 	b.ne	40001fa0 <dir_add_entry+0xd0>  // b.any
    40001fac:	aa1603e1 	mov	x1, x22
    40001fb0:	aa1503e0 	mov	x0, x21
    40001fb4:	97fffa6f 	bl	40000970 <blk_write>
    40001fb8:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40001fbc:	a9407bfd 	ldp	x29, x30, [sp]
    40001fc0:	a94153f3 	ldp	x19, x20, [sp, #16]
    40001fc4:	a94363f7 	ldp	x23, x24, [sp, #48]
    40001fc8:	a9446bf9 	ldp	x25, x26, [sp, #64]
    40001fcc:	911143ff 	add	sp, sp, #0x450
    40001fd0:	d50323bf 	autiasp
    40001fd4:	d65f03c0 	ret
    40001fd8:	b9400680 	ldr	w0, [x20, #4]
    40001fdc:	11000721 	add	w1, w25, #0x1
    40001fe0:	12003c39 	and	w25, w1, #0xffff
    40001fe4:	530a7c00 	lsr	w0, w0, #10
    40001fe8:	6b21201f 	cmp	w0, w1, uxth
    40001fec:	54fff948 	b.hi	40001f14 <dir_add_entry+0x44>  // b.pmore
    40001ff0:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40001ff4:	2a0003e1 	mov	w1, w0
    40001ff8:	14000002 	b	40002000 <dir_add_entry+0x130>
    40001ffc:	52800001 	mov	w1, #0x0                   	// #0
    40002000:	52800022 	mov	w2, #0x1                   	// #1
    40002004:	aa1403e0 	mov	x0, x20
    40002008:	97fffc26 	bl	400010a0 <bmap>
    4000200c:	72003c13 	ands	w19, w0, #0xffff
    40002010:	54fffd60 	b.eq	40001fbc <dir_add_entry+0xec>  // b.none
    40002014:	a9025bf5 	stp	x21, x22, [sp, #32]
    40002018:	910143f6 	add	x22, sp, #0x50
    4000201c:	d2808002 	mov	x2, #0x400                 	// #1024
    40002020:	52800001 	mov	w1, #0x0                   	// #0
    40002024:	aa1603e0 	mov	x0, x22
    40002028:	940002da 	bl	40002b90 <memset>
    4000202c:	aa1703e0 	mov	x0, x23
    40002030:	7900a3f8 	strh	w24, [sp, #80]
    40002034:	97fff997 	bl	40000690 <strlen>
    40002038:	b4000180 	cbz	x0, 40002068 <dir_add_entry+0x198>
    4000203c:	f100381f 	cmp	x0, #0xe
    40002040:	d28001c1 	mov	x1, #0xe                   	// #14
    40002044:	9a819003 	csel	x3, x0, x1, ls	// ls = plast
    40002048:	d2800000 	mov	x0, #0x0                   	// #0
    4000204c:	d503201f 	nop
    40002050:	38606ae2 	ldrb	w2, [x23, x0]
    40002054:	8b0002c1 	add	x1, x22, x0
    40002058:	91000400 	add	x0, x0, #0x1
    4000205c:	39000822 	strb	w2, [x1, #2]
    40002060:	eb00007f 	cmp	x3, x0
    40002064:	54ffff68 	b.hi	40002050 <dir_add_entry+0x180>  // b.pmore
    40002068:	aa1603e1 	mov	x1, x22
    4000206c:	2a1303e0 	mov	w0, w19
    40002070:	97fffa40 	bl	40000970 <blk_write>
    40002074:	b9400680 	ldr	w0, [x20, #4]
    40002078:	aa1403e1 	mov	x1, x20
    4000207c:	11100000 	add	w0, w0, #0x400
    40002080:	b9000680 	str	w0, [x20, #4]
    40002084:	2a1a03e0 	mov	w0, w26
    40002088:	97fffbe6 	bl	40001020 <write_inode>
    4000208c:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40002090:	17ffffcb 	b	40001fbc <dir_add_entry+0xec>
    40002094:	d503201f 	nop
    40002098:	d503201f 	nop
    4000209c:	d503201f 	nop

00000000400020a0 <namei>:
    400020a0:	d503233f 	paciasp
    400020a4:	d11143ff 	sub	sp, sp, #0x450
    400020a8:	9100c3e1 	add	x1, sp, #0x30
    400020ac:	a9007bfd 	stp	x29, x30, [sp]
    400020b0:	910003fd 	mov	x29, sp
    400020b4:	a90153f3 	stp	x19, x20, [sp, #16]
    400020b8:	aa0003f4 	mov	x20, x0
    400020bc:	90000020 	adrp	x0, 40006000 <_etext+0xf68>
    400020c0:	794eb000 	ldrh	w0, [x0, #1880]
    400020c4:	97fffbbf 	bl	40000fc0 <read_inode>
    400020c8:	b94037e0 	ldr	w0, [sp, #52]
    400020cc:	6b402bff 	cmp	wzr, w0, lsr #10
    400020d0:	54000480 	b.eq	40002160 <namei+0xc0>  // b.none
    400020d4:	f90013f5 	str	x21, [sp, #32]
    400020d8:	52800015 	mov	w21, #0x0                   	// #0
    400020dc:	52800002 	mov	w2, #0x0                   	// #0
    400020e0:	2a1503e1 	mov	w1, w21
    400020e4:	9100c3e0 	add	x0, sp, #0x30
    400020e8:	910143f3 	add	x19, sp, #0x50
    400020ec:	97fffbed 	bl	400010a0 <bmap>
    400020f0:	910143e1 	add	x1, sp, #0x50
    400020f4:	92403c00 	and	x0, x0, #0xffff
    400020f8:	97fffa0e 	bl	40000930 <blk_read>
    400020fc:	14000005 	b	40002110 <namei+0x70>
    40002100:	91004273 	add	x19, x19, #0x10
    40002104:	911143e0 	add	x0, sp, #0x450
    40002108:	eb00027f 	cmp	x19, x0
    4000210c:	540001c0 	b.eq	40002144 <namei+0xa4>  // b.none
    40002110:	79400260 	ldrh	w0, [x19]
    40002114:	34ffff60 	cbz	w0, 40002100 <namei+0x60>
    40002118:	91000a61 	add	x1, x19, #0x2
    4000211c:	aa1403e0 	mov	x0, x20
    40002120:	97fff9a4 	bl	400007b0 <strcmp>
    40002124:	35fffee0 	cbnz	w0, 40002100 <namei+0x60>
    40002128:	f94013f5 	ldr	x21, [sp, #32]
    4000212c:	79400260 	ldrh	w0, [x19]
    40002130:	a9407bfd 	ldp	x29, x30, [sp]
    40002134:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002138:	911143ff 	add	sp, sp, #0x450
    4000213c:	d50323bf 	autiasp
    40002140:	d65f03c0 	ret
    40002144:	b94037e0 	ldr	w0, [sp, #52]
    40002148:	110006a1 	add	w1, w21, #0x1
    4000214c:	12003c35 	and	w21, w1, #0xffff
    40002150:	530a7c00 	lsr	w0, w0, #10
    40002154:	6b21201f 	cmp	w0, w1, uxth
    40002158:	54fffc28 	b.hi	400020dc <namei+0x3c>  // b.pmore
    4000215c:	f94013f5 	ldr	x21, [sp, #32]
    40002160:	52800000 	mov	w0, #0x0                   	// #0
    40002164:	17fffff3 	b	40002130 <namei+0x90>
    40002168:	d503201f 	nop
    4000216c:	d503201f 	nop

0000000040002170 <file_write>:
    40002170:	d503233f 	paciasp
    40002174:	d111c3ff 	sub	sp, sp, #0x470
    40002178:	a9007bfd 	stp	x29, x30, [sp]
    4000217c:	910003fd 	mov	x29, sp
    40002180:	a90153f3 	stp	x19, x20, [sp, #16]
    40002184:	a9025bf5 	stp	x21, x22, [sp, #32]
    40002188:	aa0003f6 	mov	x22, x0
    4000218c:	a90363f7 	stp	x23, x24, [sp, #48]
    40002190:	b9400415 	ldr	w21, [x0, #4]
    40002194:	0b0202a0 	add	w0, w21, w2
    40002198:	530a7eb7 	lsr	w23, w21, #10
    4000219c:	51000414 	sub	w20, w0, #0x1
    400021a0:	530a7e94 	lsr	w20, w20, #10
    400021a4:	b9006fe0 	str	w0, [sp, #108]
    400021a8:	6b1402ff 	cmp	w23, w20
    400021ac:	54000628 	b.hi	40002270 <file_write+0x100>  // b.pmore
    400021b0:	12002400 	and	w0, w0, #0x3ff
    400021b4:	52800013 	mov	w19, #0x0                   	// #0
    400021b8:	a9046bf9 	stp	x25, x26, [sp, #64]
    400021bc:	120026b5 	and	w21, w21, #0x3ff
    400021c0:	2a1703fa 	mov	w26, w23
    400021c4:	52808018 	mov	w24, #0x400                 	// #1024
    400021c8:	a90573fb 	stp	x27, x28, [sp, #80]
    400021cc:	aa0103fc 	mov	x28, x1
    400021d0:	b9006be0 	str	w0, [sp, #104]
    400021d4:	d503201f 	nop
    400021d8:	52800022 	mov	w2, #0x1                   	// #1
    400021dc:	2a1a03e1 	mov	w1, w26
    400021e0:	aa1603e0 	mov	x0, x22
    400021e4:	97fffbaf 	bl	400010a0 <bmap>
    400021e8:	92403c19 	and	x25, x0, #0xffff
    400021ec:	9101c3e1 	add	x1, sp, #0x70
    400021f0:	aa1903e0 	mov	x0, x25
    400021f4:	97fff9cf 	bl	40000930 <blk_read>
    400021f8:	6b1a02ff 	cmp	w23, w26
    400021fc:	1a9f02a5 	csel	w5, w21, wzr, eq	// eq = none
    40002200:	4b05031b 	sub	w27, w24, w5
    40002204:	6b1a029f 	cmp	w20, w26
    40002208:	54000260 	b.eq	40002254 <file_write+0xe4>  // b.none
    4000220c:	0b13037b 	add	w27, w27, w19
    40002210:	2a1303e2 	mov	w2, w19
    40002214:	4b1300a5 	sub	w5, w5, w19
    40002218:	38624b84 	ldrb	w4, [x28, w2, uxtw]
    4000221c:	0b0200a3 	add	w3, w5, w2
    40002220:	9101c3e0 	add	x0, sp, #0x70
    40002224:	11000442 	add	w2, w2, #0x1
    40002228:	38234804 	strb	w4, [x0, w3, uxtw]
    4000222c:	6b02037f 	cmp	w27, w2
    40002230:	54ffff41 	b.ne	40002218 <file_write+0xa8>  // b.any
    40002234:	aa0003e1 	mov	x1, x0
    40002238:	aa1903e0 	mov	x0, x25
    4000223c:	97fff9cd 	bl	40000970 <blk_write>
    40002240:	6b1a029f 	cmp	w20, w26
    40002244:	54000100 	b.eq	40002264 <file_write+0xf4>  // b.none
    40002248:	1100075a 	add	w26, w26, #0x1
    4000224c:	2a1b03f3 	mov	w19, w27
    40002250:	17ffffe2 	b	400021d8 <file_write+0x68>
    40002254:	b9406be0 	ldr	w0, [sp, #104]
    40002258:	6b05001b 	subs	w27, w0, w5
    4000225c:	1a98137b 	csel	w27, w27, w24, ne	// ne = any
    40002260:	17ffffeb 	b	4000220c <file_write+0x9c>
    40002264:	a9446bf9 	ldp	x25, x26, [sp, #64]
    40002268:	a94573fb 	ldp	x27, x28, [sp, #80]
    4000226c:	b94006d5 	ldr	w21, [x22, #4]
    40002270:	b9406fe0 	ldr	w0, [sp, #108]
    40002274:	6b15001f 	cmp	w0, w21
    40002278:	54000049 	b.ls	40002280 <file_write+0x110>  // b.plast
    4000227c:	b90006c0 	str	w0, [x22, #4]
    40002280:	a9407bfd 	ldp	x29, x30, [sp]
    40002284:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002288:	a9425bf5 	ldp	x21, x22, [sp, #32]
    4000228c:	a94363f7 	ldp	x23, x24, [sp, #48]
    40002290:	9111c3ff 	add	sp, sp, #0x470
    40002294:	d50323bf 	autiasp
    40002298:	d65f03c0 	ret
    4000229c:	d503201f 	nop

00000000400022a0 <cmd_ls>:
    400022a0:	d503233f 	paciasp
    400022a4:	d11143ff 	sub	sp, sp, #0x450
    400022a8:	90000020 	adrp	x0, 40006000 <_etext+0xf68>
    400022ac:	9100c3e1 	add	x1, sp, #0x30
    400022b0:	a9007bfd 	stp	x29, x30, [sp]
    400022b4:	910003fd 	mov	x29, sp
    400022b8:	794eb000 	ldrh	w0, [x0, #1880]
    400022bc:	97fffb41 	bl	40000fc0 <read_inode>
    400022c0:	b94037e0 	ldr	w0, [sp, #52]
    400022c4:	6b402bff 	cmp	wzr, w0, lsr #10
    400022c8:	54000480 	b.eq	40002358 <cmd_ls+0xb8>  // b.none
    400022cc:	a90153f3 	stp	x19, x20, [sp, #16]
    400022d0:	91114bf4 	add	x20, sp, #0x452
    400022d4:	a9025bf5 	stp	x21, x22, [sp, #32]
    400022d8:	f0000015 	adrp	x21, 40005000 <tanf+0x30>
    400022dc:	911ec2b5 	add	x21, x21, #0x7b0
    400022e0:	52800016 	mov	w22, #0x0                   	// #0
    400022e4:	d503201f 	nop
    400022e8:	52800002 	mov	w2, #0x0                   	// #0
    400022ec:	2a1603e1 	mov	w1, w22
    400022f0:	9100c3e0 	add	x0, sp, #0x30
    400022f4:	97fffb6b 	bl	400010a0 <bmap>
    400022f8:	72003c00 	ands	w0, w0, #0xffff
    400022fc:	540002a0 	b.eq	40002350 <cmd_ls+0xb0>  // b.none
    40002300:	910143e1 	add	x1, sp, #0x50
    40002304:	2a0003e0 	mov	w0, w0
    40002308:	91014bf3 	add	x19, sp, #0x52
    4000230c:	97fff989 	bl	40000930 <blk_read>
    40002310:	14000004 	b	40002320 <cmd_ls+0x80>
    40002314:	91004273 	add	x19, x19, #0x10
    40002318:	eb14027f 	cmp	x19, x20
    4000231c:	54000120 	b.eq	40002340 <cmd_ls+0xa0>  // b.none
    40002320:	785fe260 	ldurh	w0, [x19, #-2]
    40002324:	34ffff80 	cbz	w0, 40002314 <cmd_ls+0x74>
    40002328:	aa1303e1 	mov	x1, x19
    4000232c:	aa1503e0 	mov	x0, x21
    40002330:	91004273 	add	x19, x19, #0x10
    40002334:	97fff86b 	bl	400004e0 <uart_printf>
    40002338:	eb14027f 	cmp	x19, x20
    4000233c:	54ffff21 	b.ne	40002320 <cmd_ls+0x80>  // b.any
    40002340:	b94037e0 	ldr	w0, [sp, #52]
    40002344:	110006d6 	add	w22, w22, #0x1
    40002348:	6b402adf 	cmp	w22, w0, lsr #10
    4000234c:	54fffce3 	b.cc	400022e8 <cmd_ls+0x48>  // b.lo, b.ul, b.last
    40002350:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002354:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40002358:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    4000235c:	910e8000 	add	x0, x0, #0x3a0
    40002360:	97fff818 	bl	400003c0 <uart_puts>
    40002364:	a9407bfd 	ldp	x29, x30, [sp]
    40002368:	911143ff 	add	sp, sp, #0x450
    4000236c:	d50323bf 	autiasp
    40002370:	d65f03c0 	ret
    40002374:	d503201f 	nop
    40002378:	d503201f 	nop
    4000237c:	d503201f 	nop

0000000040002380 <cmd_create_f>:
    40002380:	d503233f 	paciasp
    40002384:	a9b97bfd 	stp	x29, x30, [sp, #-112]!
    40002388:	910003fd 	mov	x29, sp
    4000238c:	a90153f3 	stp	x19, x20, [sp, #16]
    40002390:	aa0003f4 	mov	x20, x0
    40002394:	f90013f5 	str	x21, [sp, #32]
    40002398:	90000035 	adrp	x21, 40006000 <_etext+0xf68>
    4000239c:	97fffa0d 	bl	40000bd0 <alloc_inode>
    400023a0:	2a0003f3 	mov	w19, w0
    400023a4:	d28003c2 	mov	x2, #0x1e                  	// #30
    400023a8:	52800001 	mov	w1, #0x0                   	// #0
    400023ac:	9100cbe0 	add	x0, sp, #0x32
    400023b0:	940001f8 	bl	40002b90 <memset>
    400023b4:	128fcb60 	mov	w0, #0xffff81a4            	// #-32348
    400023b8:	9100c3e1 	add	x1, sp, #0x30
    400023bc:	790063e0 	strh	w0, [sp, #48]
    400023c0:	52800020 	mov	w0, #0x1                   	// #1
    400023c4:	3900f7e0 	strb	w0, [sp, #61]
    400023c8:	2a1303e0 	mov	w0, w19
    400023cc:	97fffb15 	bl	40001020 <write_inode>
    400023d0:	794eb2a0 	ldrh	w0, [x21, #1880]
    400023d4:	910143e1 	add	x1, sp, #0x50
    400023d8:	97fffafa 	bl	40000fc0 <read_inode>
    400023dc:	794eb2a1 	ldrh	w1, [x21, #1880]
    400023e0:	2a1303e3 	mov	w3, w19
    400023e4:	aa1403e2 	mov	x2, x20
    400023e8:	910143e0 	add	x0, sp, #0x50
    400023ec:	97fffeb9 	bl	40001ed0 <dir_add_entry>
    400023f0:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    400023f4:	911ee000 	add	x0, x0, #0x7b8
    400023f8:	97fff7f2 	bl	400003c0 <uart_puts>
    400023fc:	aa1403e0 	mov	x0, x20
    40002400:	97fff7f0 	bl	400003c0 <uart_puts>
    40002404:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002408:	910e8000 	add	x0, x0, #0x3a0
    4000240c:	97fff7ed 	bl	400003c0 <uart_puts>
    40002410:	f94013f5 	ldr	x21, [sp, #32]
    40002414:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002418:	a8c77bfd 	ldp	x29, x30, [sp], #112
    4000241c:	d50323bf 	autiasp
    40002420:	d65f03c0 	ret
    40002424:	d503201f 	nop
    40002428:	d503201f 	nop
    4000242c:	d503201f 	nop

0000000040002430 <cmd_create_d>:
    40002430:	d503233f 	paciasp
    40002434:	a9b97bfd 	stp	x29, x30, [sp, #-112]!
    40002438:	910003fd 	mov	x29, sp
    4000243c:	a90153f3 	stp	x19, x20, [sp, #16]
    40002440:	aa0003f4 	mov	x20, x0
    40002444:	f90013f5 	str	x21, [sp, #32]
    40002448:	90000035 	adrp	x21, 40006000 <_etext+0xf68>
    4000244c:	97fff9e1 	bl	40000bd0 <alloc_inode>
    40002450:	2a0003f3 	mov	w19, w0
    40002454:	d28003c2 	mov	x2, #0x1e                  	// #30
    40002458:	52800001 	mov	w1, #0x0                   	// #0
    4000245c:	9100cbe0 	add	x0, sp, #0x32
    40002460:	940001cc 	bl	40002b90 <memset>
    40002464:	52883da0 	mov	w0, #0x41ed                	// #16877
    40002468:	9100c3e1 	add	x1, sp, #0x30
    4000246c:	790063e0 	strh	w0, [sp, #48]
    40002470:	52800020 	mov	w0, #0x1                   	// #1
    40002474:	3900f7e0 	strb	w0, [sp, #61]
    40002478:	2a1303e0 	mov	w0, w19
    4000247c:	97fffae9 	bl	40001020 <write_inode>
    40002480:	794eb2a0 	ldrh	w0, [x21, #1880]
    40002484:	910143e1 	add	x1, sp, #0x50
    40002488:	97ffface 	bl	40000fc0 <read_inode>
    4000248c:	794eb2a1 	ldrh	w1, [x21, #1880]
    40002490:	2a1303e3 	mov	w3, w19
    40002494:	aa1403e2 	mov	x2, x20
    40002498:	910143e0 	add	x0, sp, #0x50
    4000249c:	97fffe8d 	bl	40001ed0 <dir_add_entry>
    400024a0:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    400024a4:	911f2000 	add	x0, x0, #0x7c8
    400024a8:	97fff7c6 	bl	400003c0 <uart_puts>
    400024ac:	aa1403e0 	mov	x0, x20
    400024b0:	97fff7c4 	bl	400003c0 <uart_puts>
    400024b4:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    400024b8:	910e8000 	add	x0, x0, #0x3a0
    400024bc:	97fff7c1 	bl	400003c0 <uart_puts>
    400024c0:	f94013f5 	ldr	x21, [sp, #32]
    400024c4:	a94153f3 	ldp	x19, x20, [sp, #16]
    400024c8:	a8c77bfd 	ldp	x29, x30, [sp], #112
    400024cc:	d50323bf 	autiasp
    400024d0:	d65f03c0 	ret
    400024d4:	d503201f 	nop
    400024d8:	d503201f 	nop
    400024dc:	d503201f 	nop

00000000400024e0 <cmd_show>:
    400024e0:	d503233f 	paciasp
    400024e4:	d11183ff 	sub	sp, sp, #0x460
    400024e8:	a9007bfd 	stp	x29, x30, [sp]
    400024ec:	910003fd 	mov	x29, sp
    400024f0:	97fffeec 	bl	400020a0 <namei>
    400024f4:	72003c00 	ands	w0, w0, #0xffff
    400024f8:	54000620 	b.eq	400025bc <cmd_show+0xdc>  // b.none
    400024fc:	910103e1 	add	x1, sp, #0x40
    40002500:	a9025bf5 	stp	x21, x22, [sp, #32]
    40002504:	52800016 	mov	w22, #0x0                   	// #0
    40002508:	f9001bf7 	str	x23, [sp, #48]
    4000250c:	52808017 	mov	w23, #0x400                 	// #1024
    40002510:	97fffaac 	bl	40000fc0 <read_inode>
    40002514:	b94047e0 	ldr	w0, [sp, #68]
    40002518:	340003c0 	cbz	w0, 40002590 <cmd_show+0xb0>
    4000251c:	a90153f3 	stp	x19, x20, [sp, #16]
    40002520:	52800002 	mov	w2, #0x0                   	// #0
    40002524:	d34a66c1 	ubfx	x1, x22, #10, #16
    40002528:	910103e0 	add	x0, sp, #0x40
    4000252c:	97fffadd 	bl	400010a0 <bmap>
    40002530:	72003c00 	ands	w0, w0, #0xffff
    40002534:	540002c0 	b.eq	4000258c <cmd_show+0xac>  // b.none
    40002538:	2a0003e0 	mov	w0, w0
    4000253c:	910183e1 	add	x1, sp, #0x60
    40002540:	97fff8fc 	bl	40000930 <blk_read>
    40002544:	b94047e0 	ldr	w0, [sp, #68]
    40002548:	4b160015 	sub	w21, w0, w22
    4000254c:	711002bf 	cmp	w21, #0x400
    40002550:	1a9792b5 	csel	w21, w21, w23, ls	// ls = plast
    40002554:	6b16001f 	cmp	w0, w22
    40002558:	540002e0 	b.eq	400025b4 <cmd_show+0xd4>  // b.none
    4000255c:	910183f4 	add	x20, sp, #0x60
    40002560:	52800013 	mov	w19, #0x0                   	// #0
    40002564:	d503201f 	nop
    40002568:	38401680 	ldrb	w0, [x20], #1
    4000256c:	11000673 	add	w19, w19, #0x1
    40002570:	97fff790 	bl	400003b0 <uart_putc>
    40002574:	6b1302bf 	cmp	w21, w19
    40002578:	54ffff88 	b.hi	40002568 <cmd_show+0x88>  // b.pmore
    4000257c:	b94047e0 	ldr	w0, [sp, #68]
    40002580:	0b1502d6 	add	w22, w22, w21
    40002584:	6b16001f 	cmp	w0, w22
    40002588:	54fffcc8 	b.hi	40002520 <cmd_show+0x40>  // b.pmore
    4000258c:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002590:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002594:	910e8000 	add	x0, x0, #0x3a0
    40002598:	97fff78a 	bl	400003c0 <uart_puts>
    4000259c:	f9401bf7 	ldr	x23, [sp, #48]
    400025a0:	a9407bfd 	ldp	x29, x30, [sp]
    400025a4:	a9425bf5 	ldp	x21, x22, [sp, #32]
    400025a8:	911183ff 	add	sp, sp, #0x460
    400025ac:	d50323bf 	autiasp
    400025b0:	d65f03c0 	ret
    400025b4:	2a1603e0 	mov	w0, w22
    400025b8:	17fffff2 	b	40002580 <cmd_show+0xa0>
    400025bc:	a9407bfd 	ldp	x29, x30, [sp]
    400025c0:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    400025c4:	911f8000 	add	x0, x0, #0x7e0
    400025c8:	911183ff 	add	sp, sp, #0x460
    400025cc:	d50323bf 	autiasp
    400025d0:	17fff77c 	b	400003c0 <uart_puts>
    400025d4:	d503201f 	nop
    400025d8:	d503201f 	nop
    400025dc:	d503201f 	nop

00000000400025e0 <cmd_echo_to_file>:
    400025e0:	d503233f 	paciasp
    400025e4:	a9b97bfd 	stp	x29, x30, [sp, #-112]!
    400025e8:	910003fd 	mov	x29, sp
    400025ec:	a90153f3 	stp	x19, x20, [sp, #16]
    400025f0:	aa0003f4 	mov	x20, x0
    400025f4:	aa0103e0 	mov	x0, x1
    400025f8:	f90013f5 	str	x21, [sp, #32]
    400025fc:	aa0103f5 	mov	x21, x1
    40002600:	97fffea8 	bl	400020a0 <namei>
    40002604:	72003c13 	ands	w19, w0, #0xffff
    40002608:	540002a0 	b.eq	4000265c <cmd_echo_to_file+0x7c>  // b.none
    4000260c:	910143e1 	add	x1, sp, #0x50
    40002610:	2a1303e0 	mov	w0, w19
    40002614:	97fffa6b 	bl	40000fc0 <read_inode>
    40002618:	aa1403e0 	mov	x0, x20
    4000261c:	97fff81d 	bl	40000690 <strlen>
    40002620:	2a0003e2 	mov	w2, w0
    40002624:	aa1403e1 	mov	x1, x20
    40002628:	910143e0 	add	x0, sp, #0x50
    4000262c:	97fffed1 	bl	40002170 <file_write>
    40002630:	910143e1 	add	x1, sp, #0x50
    40002634:	2a1303e0 	mov	w0, w19
    40002638:	97fffa7a 	bl	40001020 <write_inode>
    4000263c:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002640:	911fe000 	add	x0, x0, #0x7f8
    40002644:	97fff75f 	bl	400003c0 <uart_puts>
    40002648:	f94013f5 	ldr	x21, [sp, #32]
    4000264c:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002650:	a8c77bfd 	ldp	x29, x30, [sp], #112
    40002654:	d50323bf 	autiasp
    40002658:	d65f03c0 	ret
    4000265c:	97fff95d 	bl	40000bd0 <alloc_inode>
    40002660:	2a0003f3 	mov	w19, w0
    40002664:	d28003c2 	mov	x2, #0x1e                  	// #30
    40002668:	52800001 	mov	w1, #0x0                   	// #0
    4000266c:	9100cbe0 	add	x0, sp, #0x32
    40002670:	94000148 	bl	40002b90 <memset>
    40002674:	128fcb60 	mov	w0, #0xffff81a4            	// #-32348
    40002678:	9100c3e1 	add	x1, sp, #0x30
    4000267c:	790063e0 	strh	w0, [sp, #48]
    40002680:	52800020 	mov	w0, #0x1                   	// #1
    40002684:	3900f7e0 	strb	w0, [sp, #61]
    40002688:	2a1303e0 	mov	w0, w19
    4000268c:	97fffa65 	bl	40001020 <write_inode>
    40002690:	910143e1 	add	x1, sp, #0x50
    40002694:	52800020 	mov	w0, #0x1                   	// #1
    40002698:	97fffa4a 	bl	40000fc0 <read_inode>
    4000269c:	2a1303e3 	mov	w3, w19
    400026a0:	aa1503e2 	mov	x2, x21
    400026a4:	52800021 	mov	w1, #0x1                   	// #1
    400026a8:	910143e0 	add	x0, sp, #0x50
    400026ac:	97fffe09 	bl	40001ed0 <dir_add_entry>
    400026b0:	17ffffd7 	b	4000260c <cmd_echo_to_file+0x2c>
    400026b4:	d503201f 	nop
    400026b8:	d503201f 	nop
    400026bc:	d503201f 	nop

00000000400026c0 <cmd_cd>:
    400026c0:	d503233f 	paciasp
    400026c4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    400026c8:	910003fd 	mov	x29, sp
    400026cc:	97fffe75 	bl	400020a0 <namei>
    400026d0:	72003c02 	ands	w2, w0, #0xffff
    400026d4:	540002c0 	b.eq	4000272c <cmd_cd+0x6c>  // b.none
    400026d8:	2a0203e0 	mov	w0, w2
    400026dc:	910083e1 	add	x1, sp, #0x20
    400026e0:	b9001fe2 	str	w2, [sp, #28]
    400026e4:	97fffa37 	bl	40000fc0 <read_inode>
    400026e8:	794043e0 	ldrh	w0, [sp, #32]
    400026ec:	b9401fe2 	ldr	w2, [sp, #28]
    400026f0:	36700120 	tbz	w0, #14, 40002714 <cmd_cd+0x54>
    400026f4:	90000020 	adrp	x0, 40006000 <_etext+0xf68>
    400026f8:	790eb002 	strh	w2, [x0, #1880]
    400026fc:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002700:	9120e000 	add	x0, x0, #0x838
    40002704:	97fff72f 	bl	400003c0 <uart_puts>
    40002708:	a8c47bfd 	ldp	x29, x30, [sp], #64
    4000270c:	d50323bf 	autiasp
    40002710:	d65f03c0 	ret
    40002714:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002718:	91208000 	add	x0, x0, #0x820
    4000271c:	97fff729 	bl	400003c0 <uart_puts>
    40002720:	a8c47bfd 	ldp	x29, x30, [sp], #64
    40002724:	d50323bf 	autiasp
    40002728:	d65f03c0 	ret
    4000272c:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002730:	91202000 	add	x0, x0, #0x808
    40002734:	a8c47bfd 	ldp	x29, x30, [sp], #64
    40002738:	d50323bf 	autiasp
    4000273c:	17fff721 	b	400003c0 <uart_puts>

0000000040002740 <cmd_mv>:
    40002740:	d503233f 	paciasp
    40002744:	d11183ff 	sub	sp, sp, #0x460
    40002748:	a9007bfd 	stp	x29, x30, [sp]
    4000274c:	910003fd 	mov	x29, sp
    40002750:	a90153f3 	stp	x19, x20, [sp, #16]
    40002754:	a9025bf5 	stp	x21, x22, [sp, #32]
    40002758:	aa0003f6 	mov	x22, x0
    4000275c:	aa0103f5 	mov	x21, x1
    40002760:	97fffe50 	bl	400020a0 <namei>
    40002764:	72003c14 	ands	w20, w0, #0xffff
    40002768:	54000820 	b.eq	4000286c <cmd_mv+0x12c>  // b.none
    4000276c:	90000033 	adrp	x19, 40006000 <_etext+0xf68>
    40002770:	910103e1 	add	x1, sp, #0x40
    40002774:	794eb260 	ldrh	w0, [x19, #1880]
    40002778:	97fffa12 	bl	40000fc0 <read_inode>
    4000277c:	794eb261 	ldrh	w1, [x19, #1880]
    40002780:	2a1403e3 	mov	w3, w20
    40002784:	aa1503e2 	mov	x2, x21
    40002788:	910103e0 	add	x0, sp, #0x40
    4000278c:	97fffdd1 	bl	40001ed0 <dir_add_entry>
    40002790:	794eb260 	ldrh	w0, [x19, #1880]
    40002794:	910103e1 	add	x1, sp, #0x40
    40002798:	97fffa0a 	bl	40000fc0 <read_inode>
    4000279c:	b94047e0 	ldr	w0, [sp, #68]
    400027a0:	6b402bff 	cmp	wzr, w0, lsr #10
    400027a4:	54000480 	b.eq	40002834 <cmd_mv+0xf4>  // b.none
    400027a8:	a90363f7 	stp	x23, x24, [sp, #48]
    400027ac:	52800018 	mov	w24, #0x0                   	// #0
    400027b0:	52800002 	mov	w2, #0x0                   	// #0
    400027b4:	2a1803e1 	mov	w1, w24
    400027b8:	910103e0 	add	x0, sp, #0x40
    400027bc:	910183f3 	add	x19, sp, #0x60
    400027c0:	97fffa38 	bl	400010a0 <bmap>
    400027c4:	92403c17 	and	x23, x0, #0xffff
    400027c8:	910183e1 	add	x1, sp, #0x60
    400027cc:	aa1703e0 	mov	x0, x23
    400027d0:	97fff858 	bl	40000930 <blk_read>
    400027d4:	14000005 	b	400027e8 <cmd_mv+0xa8>
    400027d8:	91004273 	add	x19, x19, #0x10
    400027dc:	911183e0 	add	x0, sp, #0x460
    400027e0:	eb00027f 	cmp	x19, x0
    400027e4:	54000340 	b.eq	4000284c <cmd_mv+0x10c>  // b.none
    400027e8:	79400260 	ldrh	w0, [x19]
    400027ec:	6b14001f 	cmp	w0, w20
    400027f0:	54ffff41 	b.ne	400027d8 <cmd_mv+0x98>  // b.any
    400027f4:	aa1603e1 	mov	x1, x22
    400027f8:	91000a60 	add	x0, x19, #0x2
    400027fc:	97fff7ed 	bl	400007b0 <strcmp>
    40002800:	35fffec0 	cbnz	w0, 400027d8 <cmd_mv+0x98>
    40002804:	d28001c2 	mov	x2, #0xe                   	// #14
    40002808:	52800001 	mov	w1, #0x0                   	// #0
    4000280c:	7900027f 	strh	wzr, [x19]
    40002810:	91000a60 	add	x0, x19, #0x2
    40002814:	940000df 	bl	40002b90 <memset>
    40002818:	aa1703e0 	mov	x0, x23
    4000281c:	910183e1 	add	x1, sp, #0x60
    40002820:	97fff854 	bl	40000970 <blk_write>
    40002824:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002828:	9121a000 	add	x0, x0, #0x868
    4000282c:	97fff6e5 	bl	400003c0 <uart_puts>
    40002830:	a94363f7 	ldp	x23, x24, [sp, #48]
    40002834:	a9407bfd 	ldp	x29, x30, [sp]
    40002838:	a94153f3 	ldp	x19, x20, [sp, #16]
    4000283c:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40002840:	911183ff 	add	sp, sp, #0x460
    40002844:	d50323bf 	autiasp
    40002848:	d65f03c0 	ret
    4000284c:	b94047e0 	ldr	w0, [sp, #68]
    40002850:	11000701 	add	w1, w24, #0x1
    40002854:	12003c38 	and	w24, w1, #0xffff
    40002858:	530a7c00 	lsr	w0, w0, #10
    4000285c:	6b21201f 	cmp	w0, w1, uxth
    40002860:	54fffa88 	b.hi	400027b0 <cmd_mv+0x70>  // b.pmore
    40002864:	a94363f7 	ldp	x23, x24, [sp, #48]
    40002868:	17fffff3 	b	40002834 <cmd_mv+0xf4>
    4000286c:	a9407bfd 	ldp	x29, x30, [sp]
    40002870:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002874:	91214000 	add	x0, x0, #0x850
    40002878:	a94153f3 	ldp	x19, x20, [sp, #16]
    4000287c:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40002880:	911183ff 	add	sp, sp, #0x460
    40002884:	d50323bf 	autiasp
    40002888:	17fff6ce 	b	400003c0 <uart_puts>
    4000288c:	d503201f 	nop

0000000040002890 <cmd_rm>:
    40002890:	d503233f 	paciasp
    40002894:	d11203ff 	sub	sp, sp, #0x480
    40002898:	a9007bfd 	stp	x29, x30, [sp]
    4000289c:	910003fd 	mov	x29, sp
    400028a0:	a90153f3 	stp	x19, x20, [sp, #16]
    400028a4:	a9025bf5 	stp	x21, x22, [sp, #32]
    400028a8:	aa0003f6 	mov	x22, x0
    400028ac:	97fffdfd 	bl	400020a0 <namei>
    400028b0:	72003c14 	ands	w20, w0, #0xffff
    400028b4:	54000a20 	b.eq	400029f8 <cmd_rm+0x168>  // b.none
    400028b8:	2a1403e0 	mov	w0, w20
    400028bc:	910103e1 	add	x1, sp, #0x40
    400028c0:	97fff9c0 	bl	40000fc0 <read_inode>
    400028c4:	b94047e0 	ldr	w0, [sp, #68]
    400028c8:	34000240 	cbz	w0, 40002910 <cmd_rm+0x80>
    400028cc:	52800013 	mov	w19, #0x0                   	// #0
    400028d0:	14000005 	b	400028e4 <cmd_rm+0x54>
    400028d4:	b94047e0 	ldr	w0, [sp, #68]
    400028d8:	11100273 	add	w19, w19, #0x400
    400028dc:	6b13001f 	cmp	w0, w19
    400028e0:	54000189 	b.ls	40002910 <cmd_rm+0x80>  // b.plast
    400028e4:	52800002 	mov	w2, #0x0                   	// #0
    400028e8:	d34a6661 	ubfx	x1, x19, #10, #16
    400028ec:	910103e0 	add	x0, sp, #0x40
    400028f0:	97fff9ec 	bl	400010a0 <bmap>
    400028f4:	72003c00 	ands	w0, w0, #0xffff
    400028f8:	54fffee0 	b.eq	400028d4 <cmd_rm+0x44>  // b.none
    400028fc:	97fff95d 	bl	40000e70 <free_zone>
    40002900:	b94047e0 	ldr	w0, [sp, #68]
    40002904:	11100273 	add	w19, w19, #0x400
    40002908:	6b13001f 	cmp	w0, w19
    4000290c:	54fffec8 	b.hi	400028e4 <cmd_rm+0x54>  // b.pmore
    40002910:	2a1403e0 	mov	w0, w20
    40002914:	97fff98b 	bl	40000f40 <free_inode>
    40002918:	90000020 	adrp	x0, 40006000 <_etext+0xf68>
    4000291c:	910183e1 	add	x1, sp, #0x60
    40002920:	794eb000 	ldrh	w0, [x0, #1880]
    40002924:	97fff9a7 	bl	40000fc0 <read_inode>
    40002928:	b94067e0 	ldr	w0, [sp, #100]
    4000292c:	6b402bff 	cmp	wzr, w0, lsr #10
    40002930:	54000480 	b.eq	400029c0 <cmd_rm+0x130>  // b.none
    40002934:	a90363f7 	stp	x23, x24, [sp, #48]
    40002938:	52800018 	mov	w24, #0x0                   	// #0
    4000293c:	52800002 	mov	w2, #0x0                   	// #0
    40002940:	2a1803e1 	mov	w1, w24
    40002944:	910183e0 	add	x0, sp, #0x60
    40002948:	910203f3 	add	x19, sp, #0x80
    4000294c:	97fff9d5 	bl	400010a0 <bmap>
    40002950:	92403c17 	and	x23, x0, #0xffff
    40002954:	910203e1 	add	x1, sp, #0x80
    40002958:	aa1703e0 	mov	x0, x23
    4000295c:	97fff7f5 	bl	40000930 <blk_read>
    40002960:	14000005 	b	40002974 <cmd_rm+0xe4>
    40002964:	91004273 	add	x19, x19, #0x10
    40002968:	911203e0 	add	x0, sp, #0x480
    4000296c:	eb00027f 	cmp	x19, x0
    40002970:	54000340 	b.eq	400029d8 <cmd_rm+0x148>  // b.none
    40002974:	79400260 	ldrh	w0, [x19]
    40002978:	6b14001f 	cmp	w0, w20
    4000297c:	54ffff41 	b.ne	40002964 <cmd_rm+0xd4>  // b.any
    40002980:	aa1603e1 	mov	x1, x22
    40002984:	91000a60 	add	x0, x19, #0x2
    40002988:	97fff78a 	bl	400007b0 <strcmp>
    4000298c:	35fffec0 	cbnz	w0, 40002964 <cmd_rm+0xd4>
    40002990:	d28001c2 	mov	x2, #0xe                   	// #14
    40002994:	52800001 	mov	w1, #0x0                   	// #0
    40002998:	7900027f 	strh	wzr, [x19]
    4000299c:	91000a60 	add	x0, x19, #0x2
    400029a0:	9400007c 	bl	40002b90 <memset>
    400029a4:	aa1703e0 	mov	x0, x23
    400029a8:	910203e1 	add	x1, sp, #0x80
    400029ac:	97fff7f1 	bl	40000970 <blk_write>
    400029b0:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    400029b4:	9121c000 	add	x0, x0, #0x870
    400029b8:	97fff682 	bl	400003c0 <uart_puts>
    400029bc:	a94363f7 	ldp	x23, x24, [sp, #48]
    400029c0:	a9407bfd 	ldp	x29, x30, [sp]
    400029c4:	a94153f3 	ldp	x19, x20, [sp, #16]
    400029c8:	a9425bf5 	ldp	x21, x22, [sp, #32]
    400029cc:	911203ff 	add	sp, sp, #0x480
    400029d0:	d50323bf 	autiasp
    400029d4:	d65f03c0 	ret
    400029d8:	b94067e0 	ldr	w0, [sp, #100]
    400029dc:	11000701 	add	w1, w24, #0x1
    400029e0:	12003c38 	and	w24, w1, #0xffff
    400029e4:	530a7c00 	lsr	w0, w0, #10
    400029e8:	6b21201f 	cmp	w0, w1, uxth
    400029ec:	54fffa88 	b.hi	4000293c <cmd_rm+0xac>  // b.pmore
    400029f0:	a94363f7 	ldp	x23, x24, [sp, #48]
    400029f4:	17fffff3 	b	400029c0 <cmd_rm+0x130>
    400029f8:	a9407bfd 	ldp	x29, x30, [sp]
    400029fc:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002a00:	911f8000 	add	x0, x0, #0x7e0
    40002a04:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002a08:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40002a0c:	911203ff 	add	sp, sp, #0x480
    40002a10:	d50323bf 	autiasp
    40002a14:	17fff66b 	b	400003c0 <uart_puts>
    40002a18:	d503201f 	nop
    40002a1c:	d503201f 	nop

0000000040002a20 <cmd_run_test>:
    40002a20:	d503233f 	paciasp
    40002a24:	f0000000 	adrp	x0, 40005000 <tanf+0x30>
    40002a28:	91220000 	add	x0, x0, #0x880
    40002a2c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40002a30:	910003fd 	mov	x29, sp
    40002a34:	97fff663 	bl	400003c0 <uart_puts>
    40002a38:	d2820000 	mov	x0, #0x1000                	// #4096
    40002a3c:	94000009 	bl	40002a60 <kmalloc>
    40002a40:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40002a44:	91400401 	add	x1, x0, #0x1, lsl #12
    40002a48:	f0ffffe0 	adrp	x0, 40001000 <read_inode+0x40>
    40002a4c:	913ac000 	add	x0, x0, #0xeb0
    40002a50:	d50323bf 	autiasp
    40002a54:	140000b1 	b	40002d18 <drop_to_el0>
	...

0000000040002a60 <kmalloc>:
    40002a60:	d503245f 	bti	c
    40002a64:	90000023 	adrp	x3, 40006000 <_etext+0xf68>
    40002a68:	91001c01 	add	x1, x0, #0x7
    40002a6c:	f943b060 	ldr	x0, [x3, #1888]
    40002a70:	927df021 	and	x1, x1, #0xfffffffffffffff8
    40002a74:	d007ffe2 	adrp	x2, 50000000 <_heap_max>
    40002a78:	91000042 	add	x2, x2, #0x0
    40002a7c:	8b010001 	add	x1, x0, x1
    40002a80:	eb02003f 	cmp	x1, x2
    40002a84:	54000068 	b.hi	40002a90 <kmalloc+0x30>  // b.pmore
    40002a88:	f903b061 	str	x1, [x3, #1888]
    40002a8c:	d65f03c0 	ret
    40002a90:	d2800000 	mov	x0, #0x0                   	// #0
    40002a94:	d65f03c0 	ret
    40002a98:	d503201f 	nop
    40002a9c:	d503201f 	nop

0000000040002aa0 <flip_bit>:
    40002aa0:	d503245f 	bti	c
    40002aa4:	90008f83 	adrp	x3, 411f2000 <_heap_start>
    40002aa8:	91000063 	add	x3, x3, #0x0
    40002aac:	cb030021 	sub	x1, x1, x3
    40002ab0:	cb030042 	sub	x2, x2, x3
    40002ab4:	d34cfc21 	lsr	x1, x1, #12
    40002ab8:	d34cfc45 	lsr	x5, x2, #12
    40002abc:	eb05003f 	cmp	x1, x5
    40002ac0:	54000162 	b.cs	40002aec <flip_bit+0x4c>  // b.hs, b.nlast
    40002ac4:	52800026 	mov	w6, #0x1                   	// #1
    40002ac8:	d343fc24 	lsr	x4, x1, #3
    40002acc:	92400823 	and	x3, x1, #0x7
    40002ad0:	38646802 	ldrb	w2, [x0, x4]
    40002ad4:	1ac320c3 	lsl	w3, w6, w3
    40002ad8:	91000421 	add	x1, x1, #0x1
    40002adc:	0a230042 	bic	w2, w2, w3
    40002ae0:	38246802 	strb	w2, [x0, x4]
    40002ae4:	eb0100bf 	cmp	x5, x1
    40002ae8:	54ffff01 	b.ne	40002ac8 <flip_bit+0x28>  // b.any
    40002aec:	d65f03c0 	ret

0000000040002af0 <free_bit>:
    40002af0:	d503245f 	bti	c
    40002af4:	90008f82 	adrp	x2, 411f2000 <_heap_start>
    40002af8:	91000042 	add	x2, x2, #0x0
    40002afc:	cb020021 	sub	x1, x1, x2
    40002b00:	52800022 	mov	w2, #0x1                   	// #1
    40002b04:	d34ffc23 	lsr	x3, x1, #15
    40002b08:	d34c3821 	ubfx	x1, x1, #12, #3
    40002b0c:	1ac12042 	lsl	w2, w2, w1
    40002b10:	38636801 	ldrb	w1, [x0, x3]
    40002b14:	0a220021 	bic	w1, w1, w2
    40002b18:	38236801 	strb	w1, [x0, x3]
    40002b1c:	d65f03c0 	ret

0000000040002b20 <allocate_page>:
    40002b20:	d503245f 	bti	c
    40002b24:	b40002c1 	cbz	x1, 40002b7c <allocate_page+0x5c>
    40002b28:	d2800002 	mov	x2, #0x0                   	// #0
    40002b2c:	14000005 	b	40002b40 <allocate_page+0x20>
    40002b30:	91000442 	add	x2, x2, #0x1
    40002b34:	91002000 	add	x0, x0, #0x8
    40002b38:	eb02003f 	cmp	x1, x2
    40002b3c:	54000200 	b.eq	40002b7c <allocate_page+0x5c>  // b.none
    40002b40:	f9400003 	ldr	x3, [x0]
    40002b44:	b100047f 	cmn	x3, #0x1
    40002b48:	54ffff40 	b.eq	40002b30 <allocate_page+0x10>  // b.none
    40002b4c:	aa2303e4 	mvn	x4, x3
    40002b50:	d2800021 	mov	x1, #0x1                   	// #1
    40002b54:	dac00084 	rbit	x4, x4
    40002b58:	dac01084 	clz	x4, x4
    40002b5c:	9ac42021 	lsl	x1, x1, x4
    40002b60:	aa030021 	orr	x1, x1, x3
    40002b64:	f9000001 	str	x1, [x0]
    40002b68:	8b021880 	add	x0, x4, x2, lsl #6
    40002b6c:	90008f81 	adrp	x1, 411f2000 <_heap_start>
    40002b70:	91000021 	add	x1, x1, #0x0
    40002b74:	8b003020 	add	x0, x1, x0, lsl #12
    40002b78:	d65f03c0 	ret
    40002b7c:	d2800000 	mov	x0, #0x0                   	// #0
    40002b80:	d65f03c0 	ret
    40002b84:	d503201f 	nop
    40002b88:	d503201f 	nop
    40002b8c:	d503201f 	nop

0000000040002b90 <memset>:
    40002b90:	d503245f 	bti	c
    40002b94:	8b020004 	add	x4, x0, x2
    40002b98:	aa0003e3 	mov	x3, x0
    40002b9c:	b4000082 	cbz	x2, 40002bac <memset+0x1c>
    40002ba0:	38001461 	strb	w1, [x3], #1
    40002ba4:	eb03009f 	cmp	x4, x3
    40002ba8:	54ffffc1 	b.ne	40002ba0 <memset+0x10>  // b.any
    40002bac:	d65f03c0 	ret

0000000040002bb0 <clean_cache_provider>:
    40002bb0:	d503245f 	bti	c
    40002bb4:	8b010001 	add	x1, x0, x1
    40002bb8:	927ae400 	and	x0, x0, #0xffffffffffffffc0
    40002bbc:	eb00003f 	cmp	x1, x0
    40002bc0:	540000c9 	b.ls	40002bd8 <clean_cache_provider+0x28>  // b.plast
    40002bc4:	d503201f 	nop
    40002bc8:	d50b7a20 	dc	cvac, x0
    40002bcc:	91010000 	add	x0, x0, #0x40
    40002bd0:	eb00003f 	cmp	x1, x0
    40002bd4:	54ffffa8 	b.hi	40002bc8 <clean_cache_provider+0x18>  // b.pmore
    40002bd8:	d5033f9f 	dsb	sy
    40002bdc:	d65f03c0 	ret

0000000040002be0 <init_mmu>:
    40002be0:	d503233f 	paciasp
    40002be4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    40002be8:	910003fd 	mov	x29, sp
    40002bec:	d2808001 	mov	x1, #0x400                 	// #1024
    40002bf0:	a9025bf5 	stp	x21, x22, [sp, #32]
    40002bf4:	d0008f36 	adrp	x22, 411e8000 <pmm_bitmap+0x13a0>
    40002bf8:	aa0003f5 	mov	x21, x0
    40002bfc:	a90153f3 	stp	x19, x20, [sp, #16]
    40002c00:	97ffffc8 	bl	40002b20 <allocate_page>
    40002c04:	d2808001 	mov	x1, #0x400                 	// #1024
    40002c08:	f90632c0 	str	x0, [x22, #3168]
    40002c0c:	aa1503e0 	mov	x0, x21
    40002c10:	97ffffc4 	bl	40002b20 <allocate_page>
    40002c14:	d2808001 	mov	x1, #0x400                 	// #1024
    40002c18:	aa0003f4 	mov	x20, x0
    40002c1c:	aa1503e0 	mov	x0, x21
    40002c20:	97ffffc0 	bl	40002b20 <allocate_page>
    40002c24:	d2808001 	mov	x1, #0x400                 	// #1024
    40002c28:	aa0003f3 	mov	x19, x0
    40002c2c:	aa1503e0 	mov	x0, x21
    40002c30:	97ffffbc 	bl	40002b20 <allocate_page>
    40002c34:	f94632c2 	ldr	x2, [x22, #3168]
    40002c38:	d2800001 	mov	x1, #0x0                   	// #0
    40002c3c:	d503201f 	nop
    40002c40:	f821685f 	str	xzr, [x2, x1]
    40002c44:	f8216a9f 	str	xzr, [x20, x1]
    40002c48:	f8216a7f 	str	xzr, [x19, x1]
    40002c4c:	f821681f 	str	xzr, [x0, x1]
    40002c50:	91002021 	add	x1, x1, #0x8
    40002c54:	f140043f 	cmp	x1, #0x1, lsl #12
    40002c58:	54ffff41 	b.ne	40002c40 <init_mmu+0x60>  // b.any
    40002c5c:	b2400681 	orr	x1, x20, #0x3
    40002c60:	b2400403 	orr	x3, x0, #0x3
    40002c64:	d2a04004 	mov	x4, #0x2000000             	// #33554432
    40002c68:	f9000041 	str	x1, [x2]
    40002c6c:	aa0003e1 	mov	x1, x0
    40002c70:	b2400660 	orr	x0, x19, #0x3
    40002c74:	91080262 	add	x2, x19, #0x200
    40002c78:	a9000e80 	stp	x0, x3, [x20]
    40002c7c:	d2800000 	mov	x0, #0x0                   	// #0
    40002c80:	d2a04803 	mov	x3, #0x2400000             	// #37748736
    40002c84:	14000002 	b	40002c8c <init_mmu+0xac>
    40002c88:	91002042 	add	x2, x2, #0x8
    40002c8c:	eb04001f 	cmp	x0, x4
    40002c90:	540002a9 	b.ls	40002ce4 <init_mmu+0x104>  // b.plast
    40002c94:	91480000 	add	x0, x0, #0x200, lsl #12
    40002c98:	eb03001f 	cmp	x0, x3
    40002c9c:	54ffff61 	b.ne	40002c88 <init_mmu+0xa8>  // b.any
    40002ca0:	d280e0a0 	mov	x0, #0x705                 	// #1797
    40002ca4:	f2a38000 	movk	x0, #0x1c00, lsl #16
    40002ca8:	5280e024 	mov	w4, #0x701                 	// #1793
    40002cac:	52aa0003 	mov	w3, #0x50000000            	// #1342177280
    40002cb0:	f9038260 	str	x0, [x19, #1792]
    40002cb4:	52a80000 	mov	w0, #0x40000000            	// #1073741824
    40002cb8:	2a040002 	orr	w2, w0, w4
    40002cbc:	11480000 	add	w0, w0, #0x200, lsl #12
    40002cc0:	f8008422 	str	x2, [x1], #8
    40002cc4:	6b03001f 	cmp	w0, w3
    40002cc8:	54ffff81 	b.ne	40002cb8 <init_mmu+0xd8>  // b.any
    40002ccc:	d5033f9f 	dsb	sy
    40002cd0:	a94153f3 	ldp	x19, x20, [sp, #16]
    40002cd4:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40002cd8:	a8c37bfd 	ldp	x29, x30, [sp], #48
    40002cdc:	d50323bf 	autiasp
    40002ce0:	140005b6 	b	400043b8 <enable_mmu>
    40002ce4:	52a10005 	mov	w5, #0x8000000             	// #134217728
    40002ce8:	5280e0a6 	mov	w6, #0x705                 	// #1797
    40002cec:	0b050005 	add	w5, w0, w5
    40002cf0:	91480000 	add	x0, x0, #0x200, lsl #12
    40002cf4:	2a0600a5 	orr	w5, w5, w6
    40002cf8:	f8008445 	str	x5, [x2], #8
    40002cfc:	17ffffe4 	b	40002c8c <init_mmu+0xac>

0000000040002d00 <_start>:
    40002d00:	58000080 	ldr	x0, 40002d10 <hang+0x4>
    40002d04:	9100001f 	mov	sp, x0
    40002d08:	97fffb7a 	bl	40001af0 <kmain>

0000000040002d0c <hang>:
    40002d0c:	14000000 	b	40002d0c <hang>
    40002d10:	411f1000 	.word	0x411f1000
    40002d14:	00000000 	.word	0x00000000

0000000040002d18 <drop_to_el0>:
    40002d18:	d5184020 	msr	elr_el1, x0
    40002d1c:	d5184101 	msr	sp_el0, x1
    40002d20:	d2800002 	mov	x2, #0x0                   	// #0
    40002d24:	d5184002 	msr	spsr_el1, x2
    40002d28:	d69f03e0 	eret
	...

0000000040003000 <vectors>:
    40003000:	140001e1 	b	40003784 <_curr_el_sp0_sync>
    40003004:	d503201f 	nop
    40003008:	d503201f 	nop
    4000300c:	d503201f 	nop
    40003010:	d503201f 	nop
    40003014:	d503201f 	nop
    40003018:	d503201f 	nop
    4000301c:	d503201f 	nop
    40003020:	d503201f 	nop
    40003024:	d503201f 	nop
    40003028:	d503201f 	nop
    4000302c:	d503201f 	nop
    40003030:	d503201f 	nop
    40003034:	d503201f 	nop
    40003038:	d503201f 	nop
    4000303c:	d503201f 	nop
    40003040:	d503201f 	nop
    40003044:	d503201f 	nop
    40003048:	d503201f 	nop
    4000304c:	d503201f 	nop
    40003050:	d503201f 	nop
    40003054:	d503201f 	nop
    40003058:	d503201f 	nop
    4000305c:	d503201f 	nop
    40003060:	d503201f 	nop
    40003064:	d503201f 	nop
    40003068:	d503201f 	nop
    4000306c:	d503201f 	nop
    40003070:	d503201f 	nop
    40003074:	d503201f 	nop
    40003078:	d503201f 	nop
    4000307c:	d503201f 	nop
    40003080:	140001f2 	b	40003848 <_curr_el_sp0_irq>
    40003084:	d503201f 	nop
    40003088:	d503201f 	nop
    4000308c:	d503201f 	nop
    40003090:	d503201f 	nop
    40003094:	d503201f 	nop
    40003098:	d503201f 	nop
    4000309c:	d503201f 	nop
    400030a0:	d503201f 	nop
    400030a4:	d503201f 	nop
    400030a8:	d503201f 	nop
    400030ac:	d503201f 	nop
    400030b0:	d503201f 	nop
    400030b4:	d503201f 	nop
    400030b8:	d503201f 	nop
    400030bc:	d503201f 	nop
    400030c0:	d503201f 	nop
    400030c4:	d503201f 	nop
    400030c8:	d503201f 	nop
    400030cc:	d503201f 	nop
    400030d0:	d503201f 	nop
    400030d4:	d503201f 	nop
    400030d8:	d503201f 	nop
    400030dc:	d503201f 	nop
    400030e0:	d503201f 	nop
    400030e4:	d503201f 	nop
    400030e8:	d503201f 	nop
    400030ec:	d503201f 	nop
    400030f0:	d503201f 	nop
    400030f4:	d503201f 	nop
    400030f8:	d503201f 	nop
    400030fc:	d503201f 	nop
    40003100:	14000203 	b	4000390c <_curr_el_sp0_fiq>
    40003104:	d503201f 	nop
    40003108:	d503201f 	nop
    4000310c:	d503201f 	nop
    40003110:	d503201f 	nop
    40003114:	d503201f 	nop
    40003118:	d503201f 	nop
    4000311c:	d503201f 	nop
    40003120:	d503201f 	nop
    40003124:	d503201f 	nop
    40003128:	d503201f 	nop
    4000312c:	d503201f 	nop
    40003130:	d503201f 	nop
    40003134:	d503201f 	nop
    40003138:	d503201f 	nop
    4000313c:	d503201f 	nop
    40003140:	d503201f 	nop
    40003144:	d503201f 	nop
    40003148:	d503201f 	nop
    4000314c:	d503201f 	nop
    40003150:	d503201f 	nop
    40003154:	d503201f 	nop
    40003158:	d503201f 	nop
    4000315c:	d503201f 	nop
    40003160:	d503201f 	nop
    40003164:	d503201f 	nop
    40003168:	d503201f 	nop
    4000316c:	d503201f 	nop
    40003170:	d503201f 	nop
    40003174:	d503201f 	nop
    40003178:	d503201f 	nop
    4000317c:	d503201f 	nop
    40003180:	14000214 	b	400039d0 <_curr_el_sp0_serror>
    40003184:	d503201f 	nop
    40003188:	d503201f 	nop
    4000318c:	d503201f 	nop
    40003190:	d503201f 	nop
    40003194:	d503201f 	nop
    40003198:	d503201f 	nop
    4000319c:	d503201f 	nop
    400031a0:	d503201f 	nop
    400031a4:	d503201f 	nop
    400031a8:	d503201f 	nop
    400031ac:	d503201f 	nop
    400031b0:	d503201f 	nop
    400031b4:	d503201f 	nop
    400031b8:	d503201f 	nop
    400031bc:	d503201f 	nop
    400031c0:	d503201f 	nop
    400031c4:	d503201f 	nop
    400031c8:	d503201f 	nop
    400031cc:	d503201f 	nop
    400031d0:	d503201f 	nop
    400031d4:	d503201f 	nop
    400031d8:	d503201f 	nop
    400031dc:	d503201f 	nop
    400031e0:	d503201f 	nop
    400031e4:	d503201f 	nop
    400031e8:	d503201f 	nop
    400031ec:	d503201f 	nop
    400031f0:	d503201f 	nop
    400031f4:	d503201f 	nop
    400031f8:	d503201f 	nop
    400031fc:	d503201f 	nop
    40003200:	14000225 	b	40003a94 <_curr_el_spx_sync>
    40003204:	d503201f 	nop
    40003208:	d503201f 	nop
    4000320c:	d503201f 	nop
    40003210:	d503201f 	nop
    40003214:	d503201f 	nop
    40003218:	d503201f 	nop
    4000321c:	d503201f 	nop
    40003220:	d503201f 	nop
    40003224:	d503201f 	nop
    40003228:	d503201f 	nop
    4000322c:	d503201f 	nop
    40003230:	d503201f 	nop
    40003234:	d503201f 	nop
    40003238:	d503201f 	nop
    4000323c:	d503201f 	nop
    40003240:	d503201f 	nop
    40003244:	d503201f 	nop
    40003248:	d503201f 	nop
    4000324c:	d503201f 	nop
    40003250:	d503201f 	nop
    40003254:	d503201f 	nop
    40003258:	d503201f 	nop
    4000325c:	d503201f 	nop
    40003260:	d503201f 	nop
    40003264:	d503201f 	nop
    40003268:	d503201f 	nop
    4000326c:	d503201f 	nop
    40003270:	d503201f 	nop
    40003274:	d503201f 	nop
    40003278:	d503201f 	nop
    4000327c:	d503201f 	nop
    40003280:	14000235 	b	40003b54 <_curr_el_spx_irq>
    40003284:	d503201f 	nop
    40003288:	d503201f 	nop
    4000328c:	d503201f 	nop
    40003290:	d503201f 	nop
    40003294:	d503201f 	nop
    40003298:	d503201f 	nop
    4000329c:	d503201f 	nop
    400032a0:	d503201f 	nop
    400032a4:	d503201f 	nop
    400032a8:	d503201f 	nop
    400032ac:	d503201f 	nop
    400032b0:	d503201f 	nop
    400032b4:	d503201f 	nop
    400032b8:	d503201f 	nop
    400032bc:	d503201f 	nop
    400032c0:	d503201f 	nop
    400032c4:	d503201f 	nop
    400032c8:	d503201f 	nop
    400032cc:	d503201f 	nop
    400032d0:	d503201f 	nop
    400032d4:	d503201f 	nop
    400032d8:	d503201f 	nop
    400032dc:	d503201f 	nop
    400032e0:	d503201f 	nop
    400032e4:	d503201f 	nop
    400032e8:	d503201f 	nop
    400032ec:	d503201f 	nop
    400032f0:	d503201f 	nop
    400032f4:	d503201f 	nop
    400032f8:	d503201f 	nop
    400032fc:	d503201f 	nop
    40003300:	14000245 	b	40003c14 <_curr_el_spx_fiq>
    40003304:	d503201f 	nop
    40003308:	d503201f 	nop
    4000330c:	d503201f 	nop
    40003310:	d503201f 	nop
    40003314:	d503201f 	nop
    40003318:	d503201f 	nop
    4000331c:	d503201f 	nop
    40003320:	d503201f 	nop
    40003324:	d503201f 	nop
    40003328:	d503201f 	nop
    4000332c:	d503201f 	nop
    40003330:	d503201f 	nop
    40003334:	d503201f 	nop
    40003338:	d503201f 	nop
    4000333c:	d503201f 	nop
    40003340:	d503201f 	nop
    40003344:	d503201f 	nop
    40003348:	d503201f 	nop
    4000334c:	d503201f 	nop
    40003350:	d503201f 	nop
    40003354:	d503201f 	nop
    40003358:	d503201f 	nop
    4000335c:	d503201f 	nop
    40003360:	d503201f 	nop
    40003364:	d503201f 	nop
    40003368:	d503201f 	nop
    4000336c:	d503201f 	nop
    40003370:	d503201f 	nop
    40003374:	d503201f 	nop
    40003378:	d503201f 	nop
    4000337c:	d503201f 	nop
    40003380:	14000255 	b	40003cd4 <_curr_el_spx_serror>
    40003384:	d503201f 	nop
    40003388:	d503201f 	nop
    4000338c:	d503201f 	nop
    40003390:	d503201f 	nop
    40003394:	d503201f 	nop
    40003398:	d503201f 	nop
    4000339c:	d503201f 	nop
    400033a0:	d503201f 	nop
    400033a4:	d503201f 	nop
    400033a8:	d503201f 	nop
    400033ac:	d503201f 	nop
    400033b0:	d503201f 	nop
    400033b4:	d503201f 	nop
    400033b8:	d503201f 	nop
    400033bc:	d503201f 	nop
    400033c0:	d503201f 	nop
    400033c4:	d503201f 	nop
    400033c8:	d503201f 	nop
    400033cc:	d503201f 	nop
    400033d0:	d503201f 	nop
    400033d4:	d503201f 	nop
    400033d8:	d503201f 	nop
    400033dc:	d503201f 	nop
    400033e0:	d503201f 	nop
    400033e4:	d503201f 	nop
    400033e8:	d503201f 	nop
    400033ec:	d503201f 	nop
    400033f0:	d503201f 	nop
    400033f4:	d503201f 	nop
    400033f8:	d503201f 	nop
    400033fc:	d503201f 	nop
    40003400:	14000265 	b	40003d94 <_lower_el_aarch64_sync>
    40003404:	d503201f 	nop
    40003408:	d503201f 	nop
    4000340c:	d503201f 	nop
    40003410:	d503201f 	nop
    40003414:	d503201f 	nop
    40003418:	d503201f 	nop
    4000341c:	d503201f 	nop
    40003420:	d503201f 	nop
    40003424:	d503201f 	nop
    40003428:	d503201f 	nop
    4000342c:	d503201f 	nop
    40003430:	d503201f 	nop
    40003434:	d503201f 	nop
    40003438:	d503201f 	nop
    4000343c:	d503201f 	nop
    40003440:	d503201f 	nop
    40003444:	d503201f 	nop
    40003448:	d503201f 	nop
    4000344c:	d503201f 	nop
    40003450:	d503201f 	nop
    40003454:	d503201f 	nop
    40003458:	d503201f 	nop
    4000345c:	d503201f 	nop
    40003460:	d503201f 	nop
    40003464:	d503201f 	nop
    40003468:	d503201f 	nop
    4000346c:	d503201f 	nop
    40003470:	d503201f 	nop
    40003474:	d503201f 	nop
    40003478:	d503201f 	nop
    4000347c:	d503201f 	nop
    40003480:	14000276 	b	40003e58 <_lower_el_aarch64_irq>
    40003484:	d503201f 	nop
    40003488:	d503201f 	nop
    4000348c:	d503201f 	nop
    40003490:	d503201f 	nop
    40003494:	d503201f 	nop
    40003498:	d503201f 	nop
    4000349c:	d503201f 	nop
    400034a0:	d503201f 	nop
    400034a4:	d503201f 	nop
    400034a8:	d503201f 	nop
    400034ac:	d503201f 	nop
    400034b0:	d503201f 	nop
    400034b4:	d503201f 	nop
    400034b8:	d503201f 	nop
    400034bc:	d503201f 	nop
    400034c0:	d503201f 	nop
    400034c4:	d503201f 	nop
    400034c8:	d503201f 	nop
    400034cc:	d503201f 	nop
    400034d0:	d503201f 	nop
    400034d4:	d503201f 	nop
    400034d8:	d503201f 	nop
    400034dc:	d503201f 	nop
    400034e0:	d503201f 	nop
    400034e4:	d503201f 	nop
    400034e8:	d503201f 	nop
    400034ec:	d503201f 	nop
    400034f0:	d503201f 	nop
    400034f4:	d503201f 	nop
    400034f8:	d503201f 	nop
    400034fc:	d503201f 	nop
    40003500:	14000287 	b	40003f1c <_lower_el_aarch64_fiq>
    40003504:	d503201f 	nop
    40003508:	d503201f 	nop
    4000350c:	d503201f 	nop
    40003510:	d503201f 	nop
    40003514:	d503201f 	nop
    40003518:	d503201f 	nop
    4000351c:	d503201f 	nop
    40003520:	d503201f 	nop
    40003524:	d503201f 	nop
    40003528:	d503201f 	nop
    4000352c:	d503201f 	nop
    40003530:	d503201f 	nop
    40003534:	d503201f 	nop
    40003538:	d503201f 	nop
    4000353c:	d503201f 	nop
    40003540:	d503201f 	nop
    40003544:	d503201f 	nop
    40003548:	d503201f 	nop
    4000354c:	d503201f 	nop
    40003550:	d503201f 	nop
    40003554:	d503201f 	nop
    40003558:	d503201f 	nop
    4000355c:	d503201f 	nop
    40003560:	d503201f 	nop
    40003564:	d503201f 	nop
    40003568:	d503201f 	nop
    4000356c:	d503201f 	nop
    40003570:	d503201f 	nop
    40003574:	d503201f 	nop
    40003578:	d503201f 	nop
    4000357c:	d503201f 	nop
    40003580:	14000298 	b	40003fe0 <_lower_el_aarch64_serror>
    40003584:	d503201f 	nop
    40003588:	d503201f 	nop
    4000358c:	d503201f 	nop
    40003590:	d503201f 	nop
    40003594:	d503201f 	nop
    40003598:	d503201f 	nop
    4000359c:	d503201f 	nop
    400035a0:	d503201f 	nop
    400035a4:	d503201f 	nop
    400035a8:	d503201f 	nop
    400035ac:	d503201f 	nop
    400035b0:	d503201f 	nop
    400035b4:	d503201f 	nop
    400035b8:	d503201f 	nop
    400035bc:	d503201f 	nop
    400035c0:	d503201f 	nop
    400035c4:	d503201f 	nop
    400035c8:	d503201f 	nop
    400035cc:	d503201f 	nop
    400035d0:	d503201f 	nop
    400035d4:	d503201f 	nop
    400035d8:	d503201f 	nop
    400035dc:	d503201f 	nop
    400035e0:	d503201f 	nop
    400035e4:	d503201f 	nop
    400035e8:	d503201f 	nop
    400035ec:	d503201f 	nop
    400035f0:	d503201f 	nop
    400035f4:	d503201f 	nop
    400035f8:	d503201f 	nop
    400035fc:	d503201f 	nop
    40003600:	140002a9 	b	400040a4 <_lower_el_aarch32_sync>
    40003604:	d503201f 	nop
    40003608:	d503201f 	nop
    4000360c:	d503201f 	nop
    40003610:	d503201f 	nop
    40003614:	d503201f 	nop
    40003618:	d503201f 	nop
    4000361c:	d503201f 	nop
    40003620:	d503201f 	nop
    40003624:	d503201f 	nop
    40003628:	d503201f 	nop
    4000362c:	d503201f 	nop
    40003630:	d503201f 	nop
    40003634:	d503201f 	nop
    40003638:	d503201f 	nop
    4000363c:	d503201f 	nop
    40003640:	d503201f 	nop
    40003644:	d503201f 	nop
    40003648:	d503201f 	nop
    4000364c:	d503201f 	nop
    40003650:	d503201f 	nop
    40003654:	d503201f 	nop
    40003658:	d503201f 	nop
    4000365c:	d503201f 	nop
    40003660:	d503201f 	nop
    40003664:	d503201f 	nop
    40003668:	d503201f 	nop
    4000366c:	d503201f 	nop
    40003670:	d503201f 	nop
    40003674:	d503201f 	nop
    40003678:	d503201f 	nop
    4000367c:	d503201f 	nop
    40003680:	140002ba 	b	40004168 <_lower_el_aarch32_irq>
    40003684:	d503201f 	nop
    40003688:	d503201f 	nop
    4000368c:	d503201f 	nop
    40003690:	d503201f 	nop
    40003694:	d503201f 	nop
    40003698:	d503201f 	nop
    4000369c:	d503201f 	nop
    400036a0:	d503201f 	nop
    400036a4:	d503201f 	nop
    400036a8:	d503201f 	nop
    400036ac:	d503201f 	nop
    400036b0:	d503201f 	nop
    400036b4:	d503201f 	nop
    400036b8:	d503201f 	nop
    400036bc:	d503201f 	nop
    400036c0:	d503201f 	nop
    400036c4:	d503201f 	nop
    400036c8:	d503201f 	nop
    400036cc:	d503201f 	nop
    400036d0:	d503201f 	nop
    400036d4:	d503201f 	nop
    400036d8:	d503201f 	nop
    400036dc:	d503201f 	nop
    400036e0:	d503201f 	nop
    400036e4:	d503201f 	nop
    400036e8:	d503201f 	nop
    400036ec:	d503201f 	nop
    400036f0:	d503201f 	nop
    400036f4:	d503201f 	nop
    400036f8:	d503201f 	nop
    400036fc:	d503201f 	nop
    40003700:	140002cb 	b	4000422c <_lower_el_aarch32_fiq>
    40003704:	d503201f 	nop
    40003708:	d503201f 	nop
    4000370c:	d503201f 	nop
    40003710:	d503201f 	nop
    40003714:	d503201f 	nop
    40003718:	d503201f 	nop
    4000371c:	d503201f 	nop
    40003720:	d503201f 	nop
    40003724:	d503201f 	nop
    40003728:	d503201f 	nop
    4000372c:	d503201f 	nop
    40003730:	d503201f 	nop
    40003734:	d503201f 	nop
    40003738:	d503201f 	nop
    4000373c:	d503201f 	nop
    40003740:	d503201f 	nop
    40003744:	d503201f 	nop
    40003748:	d503201f 	nop
    4000374c:	d503201f 	nop
    40003750:	d503201f 	nop
    40003754:	d503201f 	nop
    40003758:	d503201f 	nop
    4000375c:	d503201f 	nop
    40003760:	d503201f 	nop
    40003764:	d503201f 	nop
    40003768:	d503201f 	nop
    4000376c:	d503201f 	nop
    40003770:	d503201f 	nop
    40003774:	d503201f 	nop
    40003778:	d503201f 	nop
    4000377c:	d503201f 	nop
    40003780:	140002dc 	b	400042f0 <_lower_el_aarch32_serror>

0000000040003784 <_curr_el_sp0_sync>:
    40003784:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003788:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    4000378c:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003790:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003794:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003798:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    4000379c:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    400037a0:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    400037a4:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    400037a8:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    400037ac:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    400037b0:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    400037b4:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    400037b8:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    400037bc:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    400037c0:	d5384015 	mrs	x21, spsr_el1
    400037c4:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    400037c8:	d5384035 	mrs	x21, elr_el1
    400037cc:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    400037d0:	d2800035 	mov	x21, #0x1                   	// #1
    400037d4:	d5385216 	mrs	x22, esr_el1
    400037d8:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    400037dc:	d5384115 	mrs	x21, sp_el0
    400037e0:	f9000bf5 	str	x21, [sp, #16]
    400037e4:	910003e0 	mov	x0, sp
    400037e8:	97fff722 	bl	40001470 <common_trap_handler>
    400037ec:	f9400bf5 	ldr	x21, [sp, #16]
    400037f0:	d5184115 	msr	sp_el0, x21
    400037f4:	910043ff 	add	sp, sp, #0x10
    400037f8:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400037fc:	d5184036 	msr	elr_el1, x22
    40003800:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003804:	d5184015 	msr	spsr_el1, x21
    40003808:	a8c10be1 	ldp	x1, x2, [sp], #16
    4000380c:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003810:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003814:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003818:	a8c12be9 	ldp	x9, x10, [sp], #16
    4000381c:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003820:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003824:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003828:	a8c14bf1 	ldp	x17, x18, [sp], #16
    4000382c:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003830:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003834:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003838:	a8c16bf9 	ldp	x25, x26, [sp], #16
    4000383c:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003840:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003844:	d69f03e0 	eret

0000000040003848 <_curr_el_sp0_irq>:
    40003848:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    4000384c:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003850:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003854:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003858:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    4000385c:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003860:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003864:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003868:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    4000386c:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003870:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003874:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003878:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    4000387c:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003880:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003884:	d5384015 	mrs	x21, spsr_el1
    40003888:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    4000388c:	d5384035 	mrs	x21, elr_el1
    40003890:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003894:	d2800055 	mov	x21, #0x2                   	// #2
    40003898:	d5385216 	mrs	x22, esr_el1
    4000389c:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    400038a0:	d5384115 	mrs	x21, sp_el0
    400038a4:	f9000bf5 	str	x21, [sp, #16]
    400038a8:	910003e0 	mov	x0, sp
    400038ac:	97fff6f1 	bl	40001470 <common_trap_handler>
    400038b0:	f9400bf5 	ldr	x21, [sp, #16]
    400038b4:	d5184115 	msr	sp_el0, x21
    400038b8:	910043ff 	add	sp, sp, #0x10
    400038bc:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400038c0:	d5184036 	msr	elr_el1, x22
    400038c4:	a8c103f5 	ldp	x21, x0, [sp], #16
    400038c8:	d5184015 	msr	spsr_el1, x21
    400038cc:	a8c10be1 	ldp	x1, x2, [sp], #16
    400038d0:	a8c113e3 	ldp	x3, x4, [sp], #16
    400038d4:	a8c11be5 	ldp	x5, x6, [sp], #16
    400038d8:	a8c123e7 	ldp	x7, x8, [sp], #16
    400038dc:	a8c12be9 	ldp	x9, x10, [sp], #16
    400038e0:	a8c133eb 	ldp	x11, x12, [sp], #16
    400038e4:	a8c13bed 	ldp	x13, x14, [sp], #16
    400038e8:	a8c143ef 	ldp	x15, x16, [sp], #16
    400038ec:	a8c14bf1 	ldp	x17, x18, [sp], #16
    400038f0:	a8c153f3 	ldp	x19, x20, [sp], #16
    400038f4:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400038f8:	a8c163f7 	ldp	x23, x24, [sp], #16
    400038fc:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003900:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003904:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003908:	d69f03e0 	eret

000000004000390c <_curr_el_sp0_fiq>:
    4000390c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003910:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003914:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003918:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    4000391c:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003920:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003924:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003928:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    4000392c:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003930:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003934:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003938:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    4000393c:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003940:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003944:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003948:	d5384015 	mrs	x21, spsr_el1
    4000394c:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003950:	d5384035 	mrs	x21, elr_el1
    40003954:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003958:	d2800075 	mov	x21, #0x3                   	// #3
    4000395c:	d5385216 	mrs	x22, esr_el1
    40003960:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003964:	d5384115 	mrs	x21, sp_el0
    40003968:	f9000bf5 	str	x21, [sp, #16]
    4000396c:	910003e0 	mov	x0, sp
    40003970:	97fff6c0 	bl	40001470 <common_trap_handler>
    40003974:	f9400bf5 	ldr	x21, [sp, #16]
    40003978:	d5184115 	msr	sp_el0, x21
    4000397c:	910043ff 	add	sp, sp, #0x10
    40003980:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003984:	d5184036 	msr	elr_el1, x22
    40003988:	a8c103f5 	ldp	x21, x0, [sp], #16
    4000398c:	d5184015 	msr	spsr_el1, x21
    40003990:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003994:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003998:	a8c11be5 	ldp	x5, x6, [sp], #16
    4000399c:	a8c123e7 	ldp	x7, x8, [sp], #16
    400039a0:	a8c12be9 	ldp	x9, x10, [sp], #16
    400039a4:	a8c133eb 	ldp	x11, x12, [sp], #16
    400039a8:	a8c13bed 	ldp	x13, x14, [sp], #16
    400039ac:	a8c143ef 	ldp	x15, x16, [sp], #16
    400039b0:	a8c14bf1 	ldp	x17, x18, [sp], #16
    400039b4:	a8c153f3 	ldp	x19, x20, [sp], #16
    400039b8:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400039bc:	a8c163f7 	ldp	x23, x24, [sp], #16
    400039c0:	a8c16bf9 	ldp	x25, x26, [sp], #16
    400039c4:	a8c173fb 	ldp	x27, x28, [sp], #16
    400039c8:	a8c17bfd 	ldp	x29, x30, [sp], #16
    400039cc:	d69f03e0 	eret

00000000400039d0 <_curr_el_sp0_serror>:
    400039d0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    400039d4:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    400039d8:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    400039dc:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    400039e0:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    400039e4:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    400039e8:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    400039ec:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    400039f0:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    400039f4:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    400039f8:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    400039fc:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003a00:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003a04:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003a08:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003a0c:	d5384015 	mrs	x21, spsr_el1
    40003a10:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003a14:	d5384035 	mrs	x21, elr_el1
    40003a18:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003a1c:	d2800095 	mov	x21, #0x4                   	// #4
    40003a20:	d5385216 	mrs	x22, esr_el1
    40003a24:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003a28:	d5384115 	mrs	x21, sp_el0
    40003a2c:	f9000bf5 	str	x21, [sp, #16]
    40003a30:	910003e0 	mov	x0, sp
    40003a34:	97fff68f 	bl	40001470 <common_trap_handler>
    40003a38:	f9400bf5 	ldr	x21, [sp, #16]
    40003a3c:	d5184115 	msr	sp_el0, x21
    40003a40:	910043ff 	add	sp, sp, #0x10
    40003a44:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003a48:	d5184036 	msr	elr_el1, x22
    40003a4c:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003a50:	d5184015 	msr	spsr_el1, x21
    40003a54:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003a58:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003a5c:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003a60:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003a64:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003a68:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003a6c:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003a70:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003a74:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003a78:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003a7c:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003a80:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003a84:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003a88:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003a8c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003a90:	d69f03e0 	eret

0000000040003a94 <_curr_el_spx_sync>:
    40003a94:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003a98:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003a9c:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003aa0:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003aa4:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003aa8:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003aac:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003ab0:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003ab4:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003ab8:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003abc:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003ac0:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003ac4:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003ac8:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003acc:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003ad0:	d5384015 	mrs	x21, spsr_el1
    40003ad4:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003ad8:	d5384035 	mrs	x21, elr_el1
    40003adc:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003ae0:	d2800235 	mov	x21, #0x11                  	// #17
    40003ae4:	d5385216 	mrs	x22, esr_el1
    40003ae8:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003aec:	910003f5 	mov	x21, sp
    40003af0:	910482b5 	add	x21, x21, #0x120
    40003af4:	f9000bf5 	str	x21, [sp, #16]
    40003af8:	910003e0 	mov	x0, sp
    40003afc:	97fff65d 	bl	40001470 <common_trap_handler>
    40003b00:	910043ff 	add	sp, sp, #0x10
    40003b04:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003b08:	d5184036 	msr	elr_el1, x22
    40003b0c:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003b10:	d5184015 	msr	spsr_el1, x21
    40003b14:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003b18:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003b1c:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003b20:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003b24:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003b28:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003b2c:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003b30:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003b34:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003b38:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003b3c:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003b40:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003b44:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003b48:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003b4c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003b50:	d69f03e0 	eret

0000000040003b54 <_curr_el_spx_irq>:
    40003b54:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003b58:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003b5c:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003b60:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003b64:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003b68:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003b6c:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003b70:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003b74:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003b78:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003b7c:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003b80:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003b84:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003b88:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003b8c:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003b90:	d5384015 	mrs	x21, spsr_el1
    40003b94:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003b98:	d5384035 	mrs	x21, elr_el1
    40003b9c:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003ba0:	d2800255 	mov	x21, #0x12                  	// #18
    40003ba4:	d5385216 	mrs	x22, esr_el1
    40003ba8:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003bac:	910003f5 	mov	x21, sp
    40003bb0:	910482b5 	add	x21, x21, #0x120
    40003bb4:	f9000bf5 	str	x21, [sp, #16]
    40003bb8:	910003e0 	mov	x0, sp
    40003bbc:	97fff62d 	bl	40001470 <common_trap_handler>
    40003bc0:	910043ff 	add	sp, sp, #0x10
    40003bc4:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003bc8:	d5184036 	msr	elr_el1, x22
    40003bcc:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003bd0:	d5184015 	msr	spsr_el1, x21
    40003bd4:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003bd8:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003bdc:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003be0:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003be4:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003be8:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003bec:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003bf0:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003bf4:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003bf8:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003bfc:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003c00:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003c04:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003c08:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003c0c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003c10:	d69f03e0 	eret

0000000040003c14 <_curr_el_spx_fiq>:
    40003c14:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003c18:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003c1c:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003c20:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003c24:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003c28:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003c2c:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003c30:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003c34:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003c38:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003c3c:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003c40:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003c44:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003c48:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003c4c:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003c50:	d5384015 	mrs	x21, spsr_el1
    40003c54:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003c58:	d5384035 	mrs	x21, elr_el1
    40003c5c:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003c60:	d2800275 	mov	x21, #0x13                  	// #19
    40003c64:	d5385216 	mrs	x22, esr_el1
    40003c68:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003c6c:	910003f5 	mov	x21, sp
    40003c70:	910482b5 	add	x21, x21, #0x120
    40003c74:	f9000bf5 	str	x21, [sp, #16]
    40003c78:	910003e0 	mov	x0, sp
    40003c7c:	97fff5fd 	bl	40001470 <common_trap_handler>
    40003c80:	910043ff 	add	sp, sp, #0x10
    40003c84:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003c88:	d5184036 	msr	elr_el1, x22
    40003c8c:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003c90:	d5184015 	msr	spsr_el1, x21
    40003c94:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003c98:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003c9c:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003ca0:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003ca4:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003ca8:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003cac:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003cb0:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003cb4:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003cb8:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003cbc:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003cc0:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003cc4:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003cc8:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003ccc:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003cd0:	d69f03e0 	eret

0000000040003cd4 <_curr_el_spx_serror>:
    40003cd4:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003cd8:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003cdc:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003ce0:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003ce4:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003ce8:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003cec:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003cf0:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003cf4:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003cf8:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003cfc:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003d00:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003d04:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003d08:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003d0c:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003d10:	d5384015 	mrs	x21, spsr_el1
    40003d14:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003d18:	d5384035 	mrs	x21, elr_el1
    40003d1c:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003d20:	d2800295 	mov	x21, #0x14                  	// #20
    40003d24:	d5385216 	mrs	x22, esr_el1
    40003d28:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003d2c:	910003f5 	mov	x21, sp
    40003d30:	910482b5 	add	x21, x21, #0x120
    40003d34:	f9000bf5 	str	x21, [sp, #16]
    40003d38:	910003e0 	mov	x0, sp
    40003d3c:	97fff5cd 	bl	40001470 <common_trap_handler>
    40003d40:	910043ff 	add	sp, sp, #0x10
    40003d44:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003d48:	d5184036 	msr	elr_el1, x22
    40003d4c:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003d50:	d5184015 	msr	spsr_el1, x21
    40003d54:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003d58:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003d5c:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003d60:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003d64:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003d68:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003d6c:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003d70:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003d74:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003d78:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003d7c:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003d80:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003d84:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003d88:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003d8c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003d90:	d69f03e0 	eret

0000000040003d94 <_lower_el_aarch64_sync>:
    40003d94:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003d98:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003d9c:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003da0:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003da4:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003da8:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003dac:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003db0:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003db4:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003db8:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003dbc:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003dc0:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003dc4:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003dc8:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003dcc:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003dd0:	d5384015 	mrs	x21, spsr_el1
    40003dd4:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003dd8:	d5384035 	mrs	x21, elr_el1
    40003ddc:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003de0:	d2800435 	mov	x21, #0x21                  	// #33
    40003de4:	d5385216 	mrs	x22, esr_el1
    40003de8:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003dec:	d5384115 	mrs	x21, sp_el0
    40003df0:	f9000bf5 	str	x21, [sp, #16]
    40003df4:	910003e0 	mov	x0, sp
    40003df8:	97fff59e 	bl	40001470 <common_trap_handler>
    40003dfc:	f9400bf5 	ldr	x21, [sp, #16]
    40003e00:	d5184115 	msr	sp_el0, x21
    40003e04:	910043ff 	add	sp, sp, #0x10
    40003e08:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003e0c:	d5184036 	msr	elr_el1, x22
    40003e10:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003e14:	d5184015 	msr	spsr_el1, x21
    40003e18:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003e1c:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003e20:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003e24:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003e28:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003e2c:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003e30:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003e34:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003e38:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003e3c:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003e40:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003e44:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003e48:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003e4c:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003e50:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003e54:	d69f03e0 	eret

0000000040003e58 <_lower_el_aarch64_irq>:
    40003e58:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003e5c:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003e60:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003e64:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003e68:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003e6c:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003e70:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003e74:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003e78:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003e7c:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003e80:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003e84:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003e88:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003e8c:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003e90:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003e94:	d5384015 	mrs	x21, spsr_el1
    40003e98:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003e9c:	d5384035 	mrs	x21, elr_el1
    40003ea0:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003ea4:	d2800455 	mov	x21, #0x22                  	// #34
    40003ea8:	d5385216 	mrs	x22, esr_el1
    40003eac:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003eb0:	d5384115 	mrs	x21, sp_el0
    40003eb4:	f9000bf5 	str	x21, [sp, #16]
    40003eb8:	910003e0 	mov	x0, sp
    40003ebc:	97fff56d 	bl	40001470 <common_trap_handler>
    40003ec0:	f9400bf5 	ldr	x21, [sp, #16]
    40003ec4:	d5184115 	msr	sp_el0, x21
    40003ec8:	910043ff 	add	sp, sp, #0x10
    40003ecc:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003ed0:	d5184036 	msr	elr_el1, x22
    40003ed4:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003ed8:	d5184015 	msr	spsr_el1, x21
    40003edc:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003ee0:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003ee4:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003ee8:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003eec:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003ef0:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003ef4:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003ef8:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003efc:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003f00:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003f04:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003f08:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003f0c:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003f10:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003f14:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003f18:	d69f03e0 	eret

0000000040003f1c <_lower_el_aarch64_fiq>:
    40003f1c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003f20:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003f24:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003f28:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003f2c:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003f30:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003f34:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003f38:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40003f3c:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40003f40:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40003f44:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40003f48:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40003f4c:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40003f50:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40003f54:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40003f58:	d5384015 	mrs	x21, spsr_el1
    40003f5c:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40003f60:	d5384035 	mrs	x21, elr_el1
    40003f64:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40003f68:	d2800475 	mov	x21, #0x23                  	// #35
    40003f6c:	d5385216 	mrs	x22, esr_el1
    40003f70:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003f74:	d5384115 	mrs	x21, sp_el0
    40003f78:	f9000bf5 	str	x21, [sp, #16]
    40003f7c:	910003e0 	mov	x0, sp
    40003f80:	97fff53c 	bl	40001470 <common_trap_handler>
    40003f84:	f9400bf5 	ldr	x21, [sp, #16]
    40003f88:	d5184115 	msr	sp_el0, x21
    40003f8c:	910043ff 	add	sp, sp, #0x10
    40003f90:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003f94:	d5184036 	msr	elr_el1, x22
    40003f98:	a8c103f5 	ldp	x21, x0, [sp], #16
    40003f9c:	d5184015 	msr	spsr_el1, x21
    40003fa0:	a8c10be1 	ldp	x1, x2, [sp], #16
    40003fa4:	a8c113e3 	ldp	x3, x4, [sp], #16
    40003fa8:	a8c11be5 	ldp	x5, x6, [sp], #16
    40003fac:	a8c123e7 	ldp	x7, x8, [sp], #16
    40003fb0:	a8c12be9 	ldp	x9, x10, [sp], #16
    40003fb4:	a8c133eb 	ldp	x11, x12, [sp], #16
    40003fb8:	a8c13bed 	ldp	x13, x14, [sp], #16
    40003fbc:	a8c143ef 	ldp	x15, x16, [sp], #16
    40003fc0:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40003fc4:	a8c153f3 	ldp	x19, x20, [sp], #16
    40003fc8:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40003fcc:	a8c163f7 	ldp	x23, x24, [sp], #16
    40003fd0:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40003fd4:	a8c173fb 	ldp	x27, x28, [sp], #16
    40003fd8:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40003fdc:	d69f03e0 	eret

0000000040003fe0 <_lower_el_aarch64_serror>:
    40003fe0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40003fe4:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40003fe8:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40003fec:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40003ff0:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40003ff4:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40003ff8:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40003ffc:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40004000:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40004004:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40004008:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    4000400c:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40004010:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40004014:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40004018:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    4000401c:	d5384015 	mrs	x21, spsr_el1
    40004020:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40004024:	d5384035 	mrs	x21, elr_el1
    40004028:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    4000402c:	d2800495 	mov	x21, #0x24                  	// #36
    40004030:	d5385216 	mrs	x22, esr_el1
    40004034:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40004038:	d5384115 	mrs	x21, sp_el0
    4000403c:	f9000bf5 	str	x21, [sp, #16]
    40004040:	910003e0 	mov	x0, sp
    40004044:	97fff50b 	bl	40001470 <common_trap_handler>
    40004048:	f9400bf5 	ldr	x21, [sp, #16]
    4000404c:	d5184115 	msr	sp_el0, x21
    40004050:	910043ff 	add	sp, sp, #0x10
    40004054:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40004058:	d5184036 	msr	elr_el1, x22
    4000405c:	a8c103f5 	ldp	x21, x0, [sp], #16
    40004060:	d5184015 	msr	spsr_el1, x21
    40004064:	a8c10be1 	ldp	x1, x2, [sp], #16
    40004068:	a8c113e3 	ldp	x3, x4, [sp], #16
    4000406c:	a8c11be5 	ldp	x5, x6, [sp], #16
    40004070:	a8c123e7 	ldp	x7, x8, [sp], #16
    40004074:	a8c12be9 	ldp	x9, x10, [sp], #16
    40004078:	a8c133eb 	ldp	x11, x12, [sp], #16
    4000407c:	a8c13bed 	ldp	x13, x14, [sp], #16
    40004080:	a8c143ef 	ldp	x15, x16, [sp], #16
    40004084:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40004088:	a8c153f3 	ldp	x19, x20, [sp], #16
    4000408c:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40004090:	a8c163f7 	ldp	x23, x24, [sp], #16
    40004094:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40004098:	a8c173fb 	ldp	x27, x28, [sp], #16
    4000409c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    400040a0:	d69f03e0 	eret

00000000400040a4 <_lower_el_aarch32_sync>:
    400040a4:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    400040a8:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    400040ac:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    400040b0:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    400040b4:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    400040b8:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    400040bc:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    400040c0:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    400040c4:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    400040c8:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    400040cc:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    400040d0:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    400040d4:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    400040d8:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    400040dc:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    400040e0:	d5384015 	mrs	x21, spsr_el1
    400040e4:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    400040e8:	d5384035 	mrs	x21, elr_el1
    400040ec:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    400040f0:	d2800635 	mov	x21, #0x31                  	// #49
    400040f4:	d5385216 	mrs	x22, esr_el1
    400040f8:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    400040fc:	d5384115 	mrs	x21, sp_el0
    40004100:	f9000bf5 	str	x21, [sp, #16]
    40004104:	910003e0 	mov	x0, sp
    40004108:	97fff4da 	bl	40001470 <common_trap_handler>
    4000410c:	f9400bf5 	ldr	x21, [sp, #16]
    40004110:	d5184115 	msr	sp_el0, x21
    40004114:	910043ff 	add	sp, sp, #0x10
    40004118:	a8c15bf5 	ldp	x21, x22, [sp], #16
    4000411c:	d5184036 	msr	elr_el1, x22
    40004120:	a8c103f5 	ldp	x21, x0, [sp], #16
    40004124:	d5184015 	msr	spsr_el1, x21
    40004128:	a8c10be1 	ldp	x1, x2, [sp], #16
    4000412c:	a8c113e3 	ldp	x3, x4, [sp], #16
    40004130:	a8c11be5 	ldp	x5, x6, [sp], #16
    40004134:	a8c123e7 	ldp	x7, x8, [sp], #16
    40004138:	a8c12be9 	ldp	x9, x10, [sp], #16
    4000413c:	a8c133eb 	ldp	x11, x12, [sp], #16
    40004140:	a8c13bed 	ldp	x13, x14, [sp], #16
    40004144:	a8c143ef 	ldp	x15, x16, [sp], #16
    40004148:	a8c14bf1 	ldp	x17, x18, [sp], #16
    4000414c:	a8c153f3 	ldp	x19, x20, [sp], #16
    40004150:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40004154:	a8c163f7 	ldp	x23, x24, [sp], #16
    40004158:	a8c16bf9 	ldp	x25, x26, [sp], #16
    4000415c:	a8c173fb 	ldp	x27, x28, [sp], #16
    40004160:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40004164:	d69f03e0 	eret

0000000040004168 <_lower_el_aarch32_irq>:
    40004168:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    4000416c:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40004170:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40004174:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40004178:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    4000417c:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40004180:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40004184:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40004188:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    4000418c:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40004190:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40004194:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40004198:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    4000419c:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    400041a0:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    400041a4:	d5384015 	mrs	x21, spsr_el1
    400041a8:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    400041ac:	d5384035 	mrs	x21, elr_el1
    400041b0:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    400041b4:	d2800655 	mov	x21, #0x32                  	// #50
    400041b8:	d5385216 	mrs	x22, esr_el1
    400041bc:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    400041c0:	d5384115 	mrs	x21, sp_el0
    400041c4:	f9000bf5 	str	x21, [sp, #16]
    400041c8:	910003e0 	mov	x0, sp
    400041cc:	97fff4a9 	bl	40001470 <common_trap_handler>
    400041d0:	f9400bf5 	ldr	x21, [sp, #16]
    400041d4:	d5184115 	msr	sp_el0, x21
    400041d8:	910043ff 	add	sp, sp, #0x10
    400041dc:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400041e0:	d5184036 	msr	elr_el1, x22
    400041e4:	a8c103f5 	ldp	x21, x0, [sp], #16
    400041e8:	d5184015 	msr	spsr_el1, x21
    400041ec:	a8c10be1 	ldp	x1, x2, [sp], #16
    400041f0:	a8c113e3 	ldp	x3, x4, [sp], #16
    400041f4:	a8c11be5 	ldp	x5, x6, [sp], #16
    400041f8:	a8c123e7 	ldp	x7, x8, [sp], #16
    400041fc:	a8c12be9 	ldp	x9, x10, [sp], #16
    40004200:	a8c133eb 	ldp	x11, x12, [sp], #16
    40004204:	a8c13bed 	ldp	x13, x14, [sp], #16
    40004208:	a8c143ef 	ldp	x15, x16, [sp], #16
    4000420c:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40004210:	a8c153f3 	ldp	x19, x20, [sp], #16
    40004214:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40004218:	a8c163f7 	ldp	x23, x24, [sp], #16
    4000421c:	a8c16bf9 	ldp	x25, x26, [sp], #16
    40004220:	a8c173fb 	ldp	x27, x28, [sp], #16
    40004224:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40004228:	d69f03e0 	eret

000000004000422c <_lower_el_aarch32_fiq>:
    4000422c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40004230:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    40004234:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    40004238:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    4000423c:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40004240:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40004244:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    40004248:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    4000424c:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40004250:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40004254:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    40004258:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    4000425c:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40004260:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40004264:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    40004268:	d5384015 	mrs	x21, spsr_el1
    4000426c:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40004270:	d5384035 	mrs	x21, elr_el1
    40004274:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    40004278:	d2800675 	mov	x21, #0x33                  	// #51
    4000427c:	d5385216 	mrs	x22, esr_el1
    40004280:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40004284:	d5384115 	mrs	x21, sp_el0
    40004288:	f9000bf5 	str	x21, [sp, #16]
    4000428c:	910003e0 	mov	x0, sp
    40004290:	97fff478 	bl	40001470 <common_trap_handler>
    40004294:	f9400bf5 	ldr	x21, [sp, #16]
    40004298:	d5184115 	msr	sp_el0, x21
    4000429c:	910043ff 	add	sp, sp, #0x10
    400042a0:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400042a4:	d5184036 	msr	elr_el1, x22
    400042a8:	a8c103f5 	ldp	x21, x0, [sp], #16
    400042ac:	d5184015 	msr	spsr_el1, x21
    400042b0:	a8c10be1 	ldp	x1, x2, [sp], #16
    400042b4:	a8c113e3 	ldp	x3, x4, [sp], #16
    400042b8:	a8c11be5 	ldp	x5, x6, [sp], #16
    400042bc:	a8c123e7 	ldp	x7, x8, [sp], #16
    400042c0:	a8c12be9 	ldp	x9, x10, [sp], #16
    400042c4:	a8c133eb 	ldp	x11, x12, [sp], #16
    400042c8:	a8c13bed 	ldp	x13, x14, [sp], #16
    400042cc:	a8c143ef 	ldp	x15, x16, [sp], #16
    400042d0:	a8c14bf1 	ldp	x17, x18, [sp], #16
    400042d4:	a8c153f3 	ldp	x19, x20, [sp], #16
    400042d8:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400042dc:	a8c163f7 	ldp	x23, x24, [sp], #16
    400042e0:	a8c16bf9 	ldp	x25, x26, [sp], #16
    400042e4:	a8c173fb 	ldp	x27, x28, [sp], #16
    400042e8:	a8c17bfd 	ldp	x29, x30, [sp], #16
    400042ec:	d69f03e0 	eret

00000000400042f0 <_lower_el_aarch32_serror>:
    400042f0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    400042f4:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
    400042f8:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
    400042fc:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
    40004300:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40004304:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
    40004308:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
    4000430c:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
    40004310:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
    40004314:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
    40004318:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
    4000431c:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
    40004320:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
    40004324:	a9bf13e3 	stp	x3, x4, [sp, #-16]!
    40004328:	a9bf0be1 	stp	x1, x2, [sp, #-16]!
    4000432c:	d5384015 	mrs	x21, spsr_el1
    40004330:	a9bf03f5 	stp	x21, x0, [sp, #-16]!
    40004334:	d5384035 	mrs	x21, elr_el1
    40004338:	a9bf57ff 	stp	xzr, x21, [sp, #-16]!
    4000433c:	d2800695 	mov	x21, #0x34                  	// #52
    40004340:	d5385216 	mrs	x22, esr_el1
    40004344:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
    40004348:	d5384115 	mrs	x21, sp_el0
    4000434c:	f9000bf5 	str	x21, [sp, #16]
    40004350:	910003e0 	mov	x0, sp
    40004354:	97fff447 	bl	40001470 <common_trap_handler>
    40004358:	f9400bf5 	ldr	x21, [sp, #16]
    4000435c:	d5184115 	msr	sp_el0, x21
    40004360:	910043ff 	add	sp, sp, #0x10
    40004364:	a8c15bf5 	ldp	x21, x22, [sp], #16
    40004368:	d5184036 	msr	elr_el1, x22
    4000436c:	a8c103f5 	ldp	x21, x0, [sp], #16
    40004370:	d5184015 	msr	spsr_el1, x21
    40004374:	a8c10be1 	ldp	x1, x2, [sp], #16
    40004378:	a8c113e3 	ldp	x3, x4, [sp], #16
    4000437c:	a8c11be5 	ldp	x5, x6, [sp], #16
    40004380:	a8c123e7 	ldp	x7, x8, [sp], #16
    40004384:	a8c12be9 	ldp	x9, x10, [sp], #16
    40004388:	a8c133eb 	ldp	x11, x12, [sp], #16
    4000438c:	a8c13bed 	ldp	x13, x14, [sp], #16
    40004390:	a8c143ef 	ldp	x15, x16, [sp], #16
    40004394:	a8c14bf1 	ldp	x17, x18, [sp], #16
    40004398:	a8c153f3 	ldp	x19, x20, [sp], #16
    4000439c:	a8c15bf5 	ldp	x21, x22, [sp], #16
    400043a0:	a8c163f7 	ldp	x23, x24, [sp], #16
    400043a4:	a8c16bf9 	ldp	x25, x26, [sp], #16
    400043a8:	a8c173fb 	ldp	x27, x28, [sp], #16
    400043ac:	a8c17bfd 	ldp	x29, x30, [sp], #16
    400043b0:	d69f03e0 	eret
    400043b4:	00000000 	udf	#0

00000000400043b8 <enable_mmu>:
    400043b8:	58000281 	ldr	x1, 40004408 <enable_mmu+0x50>
    400043bc:	d518a201 	msr	mair_el1, x1
    400043c0:	58000280 	ldr	x0, 40004410 <enable_mmu+0x58>
    400043c4:	d5182040 	msr	tcr_el1, x0
    400043c8:	58000282 	ldr	x2, 40004418 <enable_mmu+0x60>
    400043cc:	f9400042 	ldr	x2, [x2]
    400043d0:	d5182002 	msr	ttbr0_el1, x2
    400043d4:	d5381003 	mrs	x3, sctlr_el1
    400043d8:	b2400063 	orr	x3, x3, #0x1
    400043dc:	b27e0063 	orr	x3, x3, #0x4
    400043e0:	b2740063 	orr	x3, x3, #0x1000
    400043e4:	d5181003 	msr	sctlr_el1, x3
    400043e8:	d5033f9f 	dsb	sy
    400043ec:	d5033fdf 	isb
    400043f0:	d5033f9f 	dsb	sy
    400043f4:	d508871f 	tlbi	vmalle1
    400043f8:	d5033f9f 	dsb	sy
    400043fc:	d5033fdf 	isb
    40004400:	d65f03c0 	ret
    40004404:	00000000 	udf	#0
    40004408:	0044ff00 	.word	0x0044ff00
    4000440c:	00000000 	.word	0x00000000
    40004410:	00003510 	.word	0x00003510
    40004414:	00000002 	.word	0x00000002
    40004418:	411e8c60 	.word	0x411e8c60
    4000441c:	00000000 	.word	0x00000000

0000000040004420 <start_raytracer>:
    40004420:	d503233f 	paciasp
    40004424:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    40004428:	910003fd 	mov	x29, sp
    4000442c:	a90153f3 	stp	x19, x20, [sp, #16]
    40004430:	a9025bf5 	stp	x21, x22, [sp, #32]
    40004434:	9447b2f3 	bl	411f1000 <enable_fpu>
    40004438:	b0000000 	adrp	x0, 40005000 <tanf+0x30>
    4000443c:	9122e000 	add	x0, x0, #0x8b8
    40004440:	97ffefe0 	bl	400003c0 <uart_puts>
    40004444:	97ffefb3 	bl	40000310 <ramfb_get_buffer>
    40004448:	aa0003f6 	mov	x22, x0
    4000444c:	d2800300 	mov	x0, #0x18                  	// #24
    40004450:	94000300 	bl	40005050 <_Znwm>
    40004454:	b21f03e1 	mov	x1, #0x200000002           	// #8589934594
    40004458:	aa0003f5 	mov	x21, x0
    4000445c:	d2800400 	mov	x0, #0x20                  	// #32
    40004460:	f9000aa1 	str	x1, [x21, #16]
    40004464:	940002ff 	bl	40005060 <_Znam>
    40004468:	aa0003f3 	mov	x19, x0
    4000446c:	d2800500 	mov	x0, #0x28                  	// #40
    40004470:	f90002b3 	str	x19, [x21]
    40004474:	940002fb 	bl	40005060 <_Znam>
    40004478:	aa0003e1 	mov	x1, x0
    4000447c:	d2a7f002 	mov	x2, #0x3f800000            	// #1065353216
    40004480:	d28cccc0 	mov	x0, #0x6666                	// #26214
    40004484:	f2a7e4c0 	movk	x0, #0x3f26, lsl #16
    40004488:	f2d33342 	movk	x2, #0x999a, lsl #32
    4000448c:	f2e7c322 	movk	x2, #0x3e19, lsl #48
    40004490:	f2dae140 	movk	x0, #0xd70a, lsl #32
    40004494:	f2e79460 	movk	x0, #0x3ca3, lsl #48
    40004498:	d2900005 	mov	x5, #0x8000                	// #32768
    4000449c:	f2b85925 	movk	x5, #0xc2c9, lsl #16
    400044a0:	a9000262 	stp	x2, x0, [x19]
    400044a4:	d2b80400 	mov	x0, #0xc0200000            	// #3223322624
    400044a8:	f2f80405 	movk	x5, #0xc020, lsl #48
    400044ac:	f2e7e800 	movk	x0, #0x3f40, lsl #48
    400044b0:	d2933343 	mov	x3, #0x999a                	// #39322
    400044b4:	f2a7c323 	movk	x3, #0x3e19, lsl #16
    400044b8:	d2933344 	mov	x4, #0x999a                	// #39322
    400044bc:	f2a7eb24 	movk	x4, #0x3f59, lsl #16
    400044c0:	a900003f 	stp	xzr, x0, [x1]
    400044c4:	f2e7d003 	movk	x3, #0x3e80, lsl #48
    400044c8:	f2c66664 	movk	x4, #0x3333, lsl #32
    400044cc:	f2e7e664 	movk	x4, #0x3f33, lsl #48
    400044d0:	d2a85902 	mov	x2, #0x42c80000            	// #1120403456
    400044d4:	d2800900 	mov	x0, #0x48                  	// #72
    400044d8:	f90006a1 	str	x1, [x21, #8]
    400044dc:	f2c00022 	movk	x2, #0x1, lsl #32
    400044e0:	a901143f 	stp	xzr, x5, [x1, #16]
    400044e4:	a9011263 	stp	x3, x4, [x19, #16]
    400044e8:	f9001022 	str	x2, [x1, #32]
    400044ec:	940002d9 	bl	40005050 <_Znwm>
    400044f0:	5281fb61 	mov	w1, #0xfdb                 	// #4059
    400044f4:	72a7d921 	movk	w1, #0x3ec9, lsl #16
    400044f8:	d2a84682 	mov	x2, #0x42340000            	// #1110704128
    400044fc:	aa0003f3 	mov	x19, x0
    40004500:	1e270020 	fmov	s0, w1
    40004504:	d2804b00 	mov	x0, #0x258                 	// #600
    40004508:	d2a81803 	mov	x3, #0x40c00000            	// #1086324736
    4000450c:	d2f7f001 	mov	x1, #0xbf80000000000000    	// #-4647714815446351872
    40004510:	f2c06402 	movk	x2, #0x320, lsl #32
    40004514:	a9037e7f 	stp	xzr, xzr, [x19, #48]
    40004518:	a9000e7f 	stp	xzr, x3, [x19]
    4000451c:	a9010a61 	stp	x1, x2, [x19, #16]
    40004520:	a9027e60 	stp	x0, xzr, [x19, #32]
    40004524:	f900227f 	str	xzr, [x19, #64]
    40004528:	940002aa 	bl	40004fd0 <tanf>
    4000452c:	2d41da77 	ldp	s23, s22, [x19, #12]
    40004530:	0f000418 	movi	v24.2s, #0x0
    40004534:	52955560 	mov	w0, #0xaaab                	// #43691
    40004538:	72a7f540 	movk	w0, #0x3faa, lsl #16
    4000453c:	1e20281e 	fadd	s30, s0, s0
    40004540:	bd401675 	ldr	s21, [x19, #20]
    40004544:	1e27001d 	fmov	s29, w0
    40004548:	1e380aff 	fmul	s31, s23, s24
    4000454c:	1f18deda 	fmsub	s26, s22, s24, s23
    40004550:	1f38d6db 	fnmsub	s27, s22, s24, s21
    40004554:	1f38febf 	fnmsub	s31, s21, s24, s31
    40004558:	1e3d0bdd 	fmul	s29, s30, s29
    4000455c:	1e3f0bfc 	fmul	s28, s31, s31
    40004560:	1f1b737c 	fmadd	s28, s27, s27, s28
    40004564:	1f1a735c 	fmadd	s28, s26, s26, s28
    40004568:	1e21c39c 	fsqrt	s28, s28
    4000456c:	1e382390 	fcmpe	s28, s24
    40004570:	540000ec 	b.gt	4000458c <start_raytracer+0x16c>
    40004574:	1e20431a 	fmov	s26, s24
    40004578:	1e20431f 	fmov	s31, s24
    4000457c:	1e20431b 	fmov	s27, s24
    40004580:	1e20431c 	fmov	s28, s24
    40004584:	1e204319 	fmov	s25, s24
    40004588:	14000019 	b	400045ec <start_raytracer+0x1cc>
    4000458c:	1e2e1013 	fmov	s19, #1.000000000000000000e+00
    40004590:	1e3c1a7c 	fdiv	s28, s19, s28
    40004594:	1e3c0b7b 	fmul	s27, s27, s28
    40004598:	1e3c0b5a 	fmul	s26, s26, s28
    4000459c:	1e3c0bff 	fmul	s31, s31, s28
    400045a0:	1e3b0abc 	fmul	s28, s21, s27
    400045a4:	1e3a0ad9 	fmul	s25, s22, s26
    400045a8:	1e3f0af2 	fmul	s18, s23, s31
    400045ac:	1f3af2fc 	fnmsub	s28, s23, s26, s28
    400045b0:	1f3fe6b9 	fnmsub	s25, s21, s31, s25
    400045b4:	1f3bcad2 	fnmsub	s18, s22, s27, s18
    400045b8:	1e3c0b94 	fmul	s20, s28, s28
    400045bc:	1f195334 	fmadd	s20, s25, s25, s20
    400045c0:	1f125254 	fmadd	s20, s18, s18, s20
    400045c4:	1e21c294 	fsqrt	s20, s20
    400045c8:	1e202298 	fcmpe	s20, #0.0
    400045cc:	5400008c 	b.gt	400045dc <start_raytracer+0x1bc>
    400045d0:	1e20431c 	fmov	s28, s24
    400045d4:	1e204319 	fmov	s25, s24
    400045d8:	14000005 	b	400045ec <start_raytracer+0x1cc>
    400045dc:	1e341a78 	fdiv	s24, s19, s20
    400045e0:	1e380b39 	fmul	s25, s25, s24
    400045e4:	1e380b9c 	fmul	s28, s28, s24
    400045e8:	1e380a58 	fmul	s24, s18, s24
    400045ec:	1e3b0bbb 	fmul	s27, s29, s27
    400045f0:	1e3f0bbf 	fmul	s31, s29, s31
    400045f4:	2d404e72 	ldp	s18, s19, [x19]
    400045f8:	1e3a0bbd 	fmul	s29, s29, s26
    400045fc:	1e390bda 	fmul	s26, s30, s25
    40004600:	d2800400 	mov	x0, #0x20                  	// #32
    40004604:	bd400a79 	ldr	s25, [x19, #8]
    40004608:	1e2c1014 	fmov	s20, #5.000000000000000000e-01
    4000460c:	1e3e0b9c 	fmul	s28, s28, s30
    40004610:	1e380bde 	fmul	s30, s30, s24
    40004614:	1f14cb72 	fmsub	s18, s27, s20, s18
    40004618:	1f14cff8 	fmsub	s24, s31, s20, s19
    4000461c:	2d06f67f 	stp	s31, s29, [x19, #52]
    40004620:	1f14e7bf 	fmsub	s31, s29, s20, s25
    40004624:	2d07f27a 	stp	s26, s28, [x19, #60]
    40004628:	bd00467e 	str	s30, [x19, #68]
    4000462c:	1f14cb5a 	fmsub	s26, s26, s20, s18
    40004630:	1f14e380 	fmsub	s0, s28, s20, s24
    40004634:	1f14ffdf 	fmsub	s31, s30, s20, s31
    40004638:	1e3a2af7 	fadd	s23, s23, s26
    4000463c:	1e202ad6 	fadd	s22, s22, s0
    40004640:	1e352bff 	fadd	s31, s31, s21
    40004644:	2d04da77 	stp	s23, s22, [x19, #36]
    40004648:	2d05ee7f 	stp	s31, s27, [x19, #44]
    4000464c:	94000281 	bl	40005050 <_Znwm>
    40004650:	52981bc3 	mov	w3, #0xc0de                	// #49374
    40004654:	72a266e3 	movk	w3, #0x1337, lsl #16
    40004658:	a9017c1f 	stp	xzr, xzr, [x0, #16]
    4000465c:	52804b02 	mov	w2, #0x258                 	// #600
    40004660:	52806401 	mov	w1, #0x320                 	// #800
    40004664:	aa0003f4 	mov	x20, x0
    40004668:	a9007c1f 	stp	xzr, xzr, [x0]
    4000466c:	b9001803 	str	w3, [x0, #24]
    40004670:	9400000c 	bl	400046a0 <_ZN8Renderer4InitEjj>
    40004674:	b0000000 	adrp	x0, 40005000 <tanf+0x30>
    40004678:	91238000 	add	x0, x0, #0x8e0
    4000467c:	97ffef51 	bl	400003c0 <uart_puts>
    40004680:	aa1603e3 	mov	x3, x22
    40004684:	aa1503e2 	mov	x2, x21
    40004688:	aa1303e1 	mov	x1, x19
    4000468c:	aa1403e0 	mov	x0, x20
    40004690:	94000188 	bl	40004cb0 <_ZN8Renderer6renderERK6CameraRK5ScenePj>
    40004694:	17fffffb 	b	40004680 <start_raytracer+0x260>
	...

00000000400046a0 <_ZN8Renderer4InitEjj>:
    400046a0:	d503245f 	bti	c
    400046a4:	29000801 	stp	w1, w2, [x0]
    400046a8:	d65f03c0 	ret
    400046ac:	d503201f 	nop

00000000400046b0 <_ZN8Renderer14GetRandomFloatEv>:
    400046b0:	d503245f 	bti	c
    400046b4:	b9401801 	ldr	w1, [x0, #24]
    400046b8:	52a6f002 	mov	w2, #0x37800000            	// #931135488
    400046bc:	1e27005f 	fmov	s31, w2
    400046c0:	4a013421 	eor	w1, w1, w1, lsl #13
    400046c4:	4a414421 	eor	w1, w1, w1, lsr #17
    400046c8:	4a011421 	eor	w1, w1, w1, lsl #5
    400046cc:	12003c22 	and	w2, w1, #0xffff
    400046d0:	b9001801 	str	w1, [x0, #24]
    400046d4:	1e220040 	scvtf	s0, w2
    400046d8:	1e3f0800 	fmul	s0, s0, s31
    400046dc:	d65f03c0 	ret

00000000400046e0 <_ZN8Renderer10ClosestHitERK3Rayfi>:
    400046e0:	d503245f 	bti	c
    400046e4:	f9400403 	ldr	x3, [x0, #8]
    400046e8:	52800280 	mov	w0, #0x14                  	// #20
    400046ec:	bd000100 	str	s0, [x8]
    400046f0:	b9001d02 	str	w2, [x8, #28]
    400046f4:	9b207c40 	smull	x0, w2, w0
    400046f8:	2d400823 	ldp	s3, s2, [x1]
    400046fc:	2d421426 	ldp	s6, s5, [x1, #16]
    40004700:	f9400463 	ldr	x3, [x3, #8]
    40004704:	2d411021 	ldp	s1, s4, [x1, #8]
    40004708:	1f060802 	fmadd	s2, s0, s6, s2
    4000470c:	8b000062 	add	x2, x3, x0
    40004710:	bc60687e 	ldr	s30, [x3, x0]
    40004714:	2d40f05d 	ldp	s29, s28, [x2, #4]
    40004718:	1f040c03 	fmadd	s3, s0, s4, s3
    4000471c:	1f050401 	fmadd	s1, s0, s5, s1
    40004720:	1e3d385d 	fsub	s29, s2, s29
    40004724:	1e3e387e 	fsub	s30, s3, s30
    40004728:	1e3c383c 	fsub	s28, s1, s28
    4000472c:	2d008903 	stp	s3, s2, [x8, #4]
    40004730:	bd000d01 	str	s1, [x8, #12]
    40004734:	1e3d0bbb 	fmul	s27, s29, s29
    40004738:	1f1e6fdb 	fmadd	s27, s30, s30, s27
    4000473c:	1f1c6f9b 	fmadd	s27, s28, s28, s27
    40004740:	1e21c37b 	fsqrt	s27, s27
    40004744:	1e202378 	fcmpe	s27, #0.0
    40004748:	540000ec 	b.gt	40004764 <_ZN8Renderer10ClosestHitERK3Rayfi+0x84>
    4000474c:	0f00041f 	movi	v31.2s, #0x0
    40004750:	1e2043fd 	fmov	s29, s31
    40004754:	1e2043fe 	fmov	s30, s31
    40004758:	bd00191f 	str	s31, [x8, #24]
    4000475c:	2d02751e 	stp	s30, s29, [x8, #16]
    40004760:	d65f03c0 	ret
    40004764:	1e2e101f 	fmov	s31, #1.000000000000000000e+00
    40004768:	1e3b1bff 	fdiv	s31, s31, s27
    4000476c:	1e3f0bde 	fmul	s30, s30, s31
    40004770:	1e3f0bbd 	fmul	s29, s29, s31
    40004774:	1e3f0b9f 	fmul	s31, s28, s31
    40004778:	2d02751e 	stp	s30, s29, [x8, #16]
    4000477c:	bd00191f 	str	s31, [x8, #24]
    40004780:	d65f03c0 	ret
    40004784:	d503201f 	nop
    40004788:	d503201f 	nop
    4000478c:	d503201f 	nop

0000000040004790 <_ZN8Renderer8TraceRayERK3Ray>:
    40004790:	d503245f 	bti	c
    40004794:	f9400403 	ldr	x3, [x0, #8]
    40004798:	b9401065 	ldr	w5, [x3, #16]
    4000479c:	340007a5 	cbz	w5, 40004890 <_ZN8Renderer8TraceRayERK3Ray+0x100>
    400047a0:	2d425c35 	ldp	s21, s23, [x1, #16]
    400047a4:	52847e07 	mov	w7, #0x23f0                	// #9200
    400047a8:	72a92e87 	movk	w7, #0x4974, lsl #16
    400047ac:	52824de6 	mov	w6, #0x126f                	// #4719
    400047b0:	72a75066 	movk	w6, #0x3a83, lsl #16
    400047b4:	1e221018 	fmov	s24, #4.000000000000000000e+00
    400047b8:	2d415834 	ldp	s20, s22, [x1, #8]
    400047bc:	52800004 	mov	w4, #0x0                   	// #0
    400047c0:	12800002 	mov	w2, #0xffffffff            	// #-1
    400047c4:	1e2700e0 	fmov	s0, w7
    400047c8:	1e2700d1 	fmov	s17, w6
    400047cc:	2d404833 	ldp	s19, s18, [x1]
    400047d0:	1e350ab9 	fmul	s25, s21, s21
    400047d4:	f9400463 	ldr	x3, [x3, #8]
    400047d8:	1f1666d9 	fmadd	s25, s22, s22, s25
    400047dc:	1f1766f9 	fmadd	s25, s23, s23, s25
    400047e0:	1e380b38 	fmul	s24, s25, s24
    400047e4:	d503201f 	nop
    400047e8:	2d40787a 	ldp	s26, s30, [x3]
    400047ec:	2d41747b 	ldp	s27, s29, [x3, #8]
    400047f0:	1e3e3a5e 	fsub	s30, s18, s30
    400047f4:	1e3a3a7a 	fsub	s26, s19, s26
    400047f8:	1e3b3a9b 	fsub	s27, s20, s27
    400047fc:	1e3e0bdc 	fmul	s28, s30, s30
    40004800:	1e3e0abf 	fmul	s31, s21, s30
    40004804:	1f1a735e 	fmadd	s30, s26, s26, s28
    40004808:	1f1a7edf 	fmadd	s31, s22, s26, s31
    4000480c:	1f1b7b7e 	fmadd	s30, s27, s27, s30
    40004810:	1f1b7eff 	fmadd	s31, s23, s27, s31
    40004814:	1f1dfba2 	fmsub	s2, s29, s29, s30
    40004818:	1e3f2bff 	fadd	s31, s31, s31
    4000481c:	1e38085d 	fmul	s29, s2, s24
    40004820:	1e2143fe 	fneg	s30, s31
    40004824:	1f3ff7ff 	fnmsub	s31, s31, s31, s29
    40004828:	1e2023f8 	fcmpe	s31, #0.0
    4000482c:	540000e4 	b.mi	40004848 <_ZN8Renderer8TraceRayERK3Ray+0xb8>  // b.first
    40004830:	1e21c3ff 	fsqrt	s31, s31
    40004834:	1e392b3d 	fadd	s29, s25, s25
    40004838:	1e3f3bdf 	fsub	s31, s30, s31
    4000483c:	1e3d1bff 	fdiv	s31, s31, s29
    40004840:	1e3123f0 	fcmpe	s31, s17
    40004844:	540001ac 	b.gt	40004878 <_ZN8Renderer8TraceRayERK3Ray+0xe8>
    40004848:	11000484 	add	w4, w4, #0x1
    4000484c:	91005063 	add	x3, x3, #0x14
    40004850:	6b05009f 	cmp	w4, w5
    40004854:	54fffca1 	b.ne	400047e8 <_ZN8Renderer8TraceRayERK3Ray+0x58>  // b.any
    40004858:	37f801c2 	tbnz	w2, #31, 40004890 <_ZN8Renderer8TraceRayERK3Ray+0x100>
    4000485c:	d503233f 	paciasp
    40004860:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40004864:	910003fd 	mov	x29, sp
    40004868:	97ffff9e 	bl	400046e0 <_ZN8Renderer10ClosestHitERK3Rayfi>
    4000486c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40004870:	d50323bf 	autiasp
    40004874:	d65f03c0 	ret
    40004878:	1e2023f0 	fcmpe	s31, s0
    4000487c:	54000044 	b.mi	40004884 <_ZN8Renderer8TraceRayERK3Ray+0xf4>  // b.first
    40004880:	17fffff2 	b	40004848 <_ZN8Renderer8TraceRayERK3Ray+0xb8>
    40004884:	1e2043e0 	fmov	s0, s31
    40004888:	2a0403e2 	mov	w2, w4
    4000488c:	17ffffef 	b	40004848 <_ZN8Renderer8TraceRayERK3Ray+0xb8>
    40004890:	f900091f 	str	xzr, [x8, #16]
    40004894:	d2b7f000 	mov	x0, #0xbf800000            	// #3212836864
    40004898:	2d41fc3d 	ldp	s29, s31, [x1, #12]
    4000489c:	f9000100 	str	x0, [x8]
    400048a0:	bd40143e 	ldr	s30, [x1, #20]
    400048a4:	b900191f 	str	wzr, [x8, #24]
    400048a8:	1e3f0bfc 	fmul	s28, s31, s31
    400048ac:	1f1d73a0 	fmadd	s0, s29, s29, s28
    400048b0:	1f1e03de 	fmadd	s30, s30, s30, s0
    400048b4:	1e21c3de 	fsqrt	s30, s30
    400048b8:	1e2023d8 	fcmpe	s30, #0.0
    400048bc:	5400012c 	b.gt	400048e0 <_ZN8Renderer8TraceRayERK3Ray+0x150>
    400048c0:	52933340 	mov	w0, #0x999a                	// #39322
    400048c4:	72a7eb20 	movk	w0, #0x3f59, lsl #16
    400048c8:	1e2e101f 	fmov	s31, #1.000000000000000000e+00
    400048cc:	1e2d101b 	fmov	s27, #7.500000000000000000e-01
    400048d0:	1e27001e 	fmov	s30, w0
    400048d4:	bd000d1f 	str	s31, [x8, #12]
    400048d8:	2d00f91b 	stp	s27, s30, [x8, #4]
    400048dc:	d65f03c0 	ret
    400048e0:	1e2e101c 	fmov	s28, #1.000000000000000000e+00
    400048e4:	1e2c101b 	fmov	s27, #5.000000000000000000e-01
    400048e8:	52866660 	mov	w0, #0x3333                	// #13107
    400048ec:	72a7e660 	movk	w0, #0x3f33, lsl #16
    400048f0:	1e27001d 	fmov	s29, w0
    400048f4:	1e3e1b9e 	fdiv	s30, s28, s30
    400048f8:	1f1e73ff 	fmadd	s31, s31, s30, s28
    400048fc:	1e3b0bff 	fmul	s31, s31, s27
    40004900:	1e3f3b9c 	fsub	s28, s28, s31
    40004904:	1f1b73fb 	fmadd	s27, s31, s27, s28
    40004908:	1f1d73fe 	fmadd	s30, s31, s29, s28
    4000490c:	1e3c2bff 	fadd	s31, s31, s28
    40004910:	bd000d1f 	str	s31, [x8, #12]
    40004914:	2d00f91b 	stp	s27, s30, [x8, #4]
    40004918:	d65f03c0 	ret
    4000491c:	d503201f 	nop

0000000040004920 <_ZN8Renderer8perPixelEjj>:
    40004920:	d503233f 	paciasp
    40004924:	a9b77bfd 	stp	x29, x30, [sp, #-144]!
    40004928:	910003fd 	mov	x29, sp
    4000492c:	1e23005e 	ucvtf	s30, w2
    40004930:	52a6f004 	mov	w4, #0x37800000            	// #931135488
    40004934:	1e23003d 	ucvtf	s29, w1
    40004938:	aa0003ea 	mov	x10, x0
    4000493c:	6d0127e8 	stp	d8, d9, [sp, #16]
    40004940:	6d022fea 	stp	d10, d11, [sp, #32]
    40004944:	6d0337ec 	stp	d12, d13, [sp, #48]
    40004948:	6d043fee 	stp	d14, d15, [sp, #64]
    4000494c:	b9401803 	ldr	w3, [x0, #24]
    40004950:	1e27009c 	fmov	s28, w4
    40004954:	f9400801 	ldr	x1, [x0, #16]
    40004958:	4a033462 	eor	w2, w3, w3, lsl #13
    4000495c:	4a424442 	eor	w2, w2, w2, lsr #17
    40004960:	2d43ec3a 	ldp	s26, s27, [x1, #28]
    40004964:	4a021442 	eor	w2, w2, w2, lsl #5
    40004968:	2d44b830 	ldp	s16, s14, [x1, #36]
    4000496c:	4a023449 	eor	w9, w2, w2, lsl #13
    40004970:	12003c42 	and	w2, w2, #0xffff
    40004974:	2d464c34 	ldp	s20, s19, [x1, #48]
    40004978:	4a494529 	eor	w9, w9, w9, lsr #17
    4000497c:	1e22005f 	scvtf	s31, w2
    40004980:	7e21db5a 	ucvtf	s26, s26
    40004984:	7e21db7b 	ucvtf	s27, s27
    40004988:	bd402c27 	ldr	s7, [x1, #44]
    4000498c:	4a091529 	eor	w9, w9, w9, lsl #5
    40004990:	12003d20 	and	w0, w9, #0xffff
    40004994:	1e220019 	scvtf	s25, w0
    40004998:	1f1c77fd 	fmadd	s29, s31, s28, s29
    4000499c:	1f1c7b3e 	fmadd	s30, s25, s28, s30
    400049a0:	bd40083c 	ldr	s28, [x1, #8]
    400049a4:	b9001949 	str	w9, [x10, #24]
    400049a8:	2d486036 	ldp	s22, s24, [x1, #64]
    400049ac:	1e3a1bbd 	fdiv	s29, s29, s26
    400049b0:	2d475c35 	ldp	s21, s23, [x1, #56]
    400049b4:	2d40643a 	ldp	s26, s25, [x1]
    400049b8:	1e3b1bde 	fdiv	s30, s30, s27
    400049bc:	1f133bbf 	fmadd	s31, s29, s19, s14
    400049c0:	1f1443b0 	fmadd	s16, s29, s20, s16
    400049c4:	1f151fa7 	fmadd	s7, s29, s21, s7
    400049c8:	1f167fdf 	fmadd	s31, s30, s22, s31
    400049cc:	1f1743d0 	fmadd	s16, s30, s23, s16
    400049d0:	1f181fc7 	fmadd	s7, s30, s24, s7
    400049d4:	1e393bff 	fsub	s31, s31, s25
    400049d8:	1e3a3a10 	fsub	s16, s16, s26
    400049dc:	1e3c38e7 	fsub	s7, s7, s28
    400049e0:	1e3f0bfe 	fmul	s30, s31, s31
    400049e4:	1f107a1e 	fmadd	s30, s16, s16, s30
    400049e8:	1f0778fe 	fmadd	s30, s7, s7, s30
    400049ec:	1e21c3de 	fsqrt	s30, s30
    400049f0:	1e2023d8 	fcmpe	s30, #0.0
    400049f4:	540000ac 	b.gt	40004a08 <_ZN8Renderer8perPixelEjj+0xe8>
    400049f8:	0f000407 	movi	v7.2s, #0x0
    400049fc:	1e2040ee 	fmov	s14, s7
    40004a00:	1e2040f0 	fmov	s16, s7
    40004a04:	14000006 	b	40004a1c <_ZN8Renderer8perPixelEjj+0xfc>
    40004a08:	1e2e101d 	fmov	s29, #1.000000000000000000e+00
    40004a0c:	1e3e1bbe 	fdiv	s30, s29, s30
    40004a10:	1e3e0a10 	fmul	s16, s16, s30
    40004a14:	1e3e0bee 	fmul	s14, s31, s30
    40004a18:	1e3e08e7 	fmul	s7, s7, s30
    40004a1c:	5299a744 	mov	w4, #0xcd3a                	// #52538
    40004a20:	72a7e264 	movk	w4, #0x3f13, lsl #16
    40004a24:	0f00040c 	movi	v12.2s, #0x0
    40004a28:	5296e2e3 	mov	w3, #0xb717                	// #46871
    40004a2c:	72a71a23 	movk	w3, #0x38d1, lsl #16
    40004a30:	f9400022 	ldr	x2, [x1]
    40004a34:	1e27008f 	fmov	s15, w4
    40004a38:	52a6f000 	mov	w0, #0x37800000            	// #931135488
    40004a3c:	1e2e100d 	fmov	s13, #1.000000000000000000e+00
    40004a40:	1e270068 	fmov	s8, w3
    40004a44:	5280008c 	mov	w12, #0x4                   	// #4
    40004a48:	5280028b 	mov	w11, #0x14                  	// #20
    40004a4c:	1e270009 	fmov	s9, w0
    40004a50:	b9400820 	ldr	w0, [x1, #8]
    40004a54:	1e20418b 	fmov	s11, s12
    40004a58:	1e20418a 	fmov	s10, s12
    40004a5c:	f9002fe2 	str	x2, [sp, #88]
    40004a60:	b90063e0 	str	w0, [sp, #96]
    40004a64:	9101c3e8 	add	x8, sp, #0x70
    40004a68:	910163e1 	add	x1, sp, #0x58
    40004a6c:	2d0cbbf0 	stp	s16, s14, [sp, #100]
    40004a70:	aa0a03e0 	mov	x0, x10
    40004a74:	bd006fe7 	str	s7, [sp, #108]
    40004a78:	97ffff46 	bl	40004790 <_ZN8Renderer8TraceRayERK3Ray>
    40004a7c:	bd4073ff 	ldr	s31, [sp, #112]
    40004a80:	1e2023f8 	fcmpe	s31, #0.0
    40004a84:	54000d64 	b.mi	40004c30 <_ZN8Renderer8perPixelEjj+0x310>  // b.first
    40004a88:	f9400540 	ldr	x0, [x10, #8]
    40004a8c:	4a093529 	eor	w9, w9, w9, lsl #13
    40004a90:	1e3c101d 	fmov	s29, #-5.000000000000000000e-01
    40004a94:	1e2c1017 	fmov	s23, #5.000000000000000000e-01
    40004a98:	1e2e1018 	fmov	s24, #1.000000000000000000e+00
    40004a9c:	2d50ebf6 	ldp	s22, s26, [sp, #132]
    40004aa0:	4a494529 	eor	w9, w9, w9, lsr #17
    40004aa4:	b9408fe2 	ldr	w2, [sp, #140]
    40004aa8:	4a091529 	eor	w9, w9, w9, lsl #5
    40004aac:	a9400003 	ldp	x3, x0, [x0]
    40004ab0:	4a093521 	eor	w1, w9, w9, lsl #13
    40004ab4:	12003d29 	and	w9, w9, #0xffff
    40004ab8:	1e2e0ad3 	fmul	s19, s22, s14
    40004abc:	4a414421 	eor	w1, w1, w1, lsr #17
    40004ac0:	1e2f0ade 	fmul	s30, s22, s15
    40004ac4:	2d4ff3f1 	ldp	s17, s28, [sp, #124]
    40004ac8:	1e22013f 	scvtf	s31, w9
    40004acc:	1e362ad5 	fadd	s21, s22, s22
    40004ad0:	9b2b0042 	smaddl	x2, w2, w11, x0
    40004ad4:	1e3a2b44 	fadd	s4, s26, s26
    40004ad8:	4a011421 	eor	w1, w1, w1, lsl #5
    40004adc:	2d4e9bf4 	ldp	s20, s6, [sp, #116]
    40004ae0:	b9801042 	ldrsw	x2, [x2, #16]
    40004ae4:	12003c20 	and	w0, w1, #0xffff
    40004ae8:	4a013421 	eor	w1, w1, w1, lsl #13
    40004aec:	1f104f93 	fmadd	s19, s28, s16, s19
    40004af0:	1f0f7b9e 	fmadd	s30, s28, s15, s30
    40004af4:	4a414421 	eor	w1, w1, w1, lsr #17
    40004af8:	1e22001b 	scvtf	s27, w0
    40004afc:	1f0977f2 	fmadd	s18, s31, s9, s29
    40004b00:	4a011429 	eor	w9, w1, w1, lsl #5
    40004b04:	1e3c2b83 	fadd	s3, s28, s28
    40004b08:	1f085394 	fmadd	s20, s28, s8, s20
    40004b0c:	d37cec41 	lsl	x1, x2, #4
    40004b10:	8b010060 	add	x0, x3, x1
    40004b14:	12003d22 	and	w2, w9, #0xffff
    40004b18:	1f1a4cff 	fmadd	s31, s7, s26, s19
    40004b1c:	1f0f7b5e 	fmadd	s30, s26, s15, s30
    40004b20:	bd400c13 	ldr	s19, [x0, #12]
    40004b24:	1e220045 	scvtf	s5, w2
    40004b28:	1f09777b 	fmadd	s27, s27, s9, s29
    40004b2c:	1f08475a 	fmadd	s26, s26, s8, s17
    40004b30:	1f15bbee 	fmsub	s14, s31, s21, s14
    40004b34:	1f03c3f0 	fmsub	s16, s31, s3, s16
    40004b38:	bc616875 	ldr	s21, [x3, x1]
    40004b3c:	1f0974bd 	fmadd	s29, s5, s9, s29
    40004b40:	1f049fff 	fmsub	s31, s31, s4, s7
    40004b44:	1f081ac7 	fmadd	s7, s22, s8, s6
    40004b48:	2d40f016 	ldp	s22, s28, [x0, #4]
    40004b4c:	b9001949 	str	w9, [x10, #24]
    40004b50:	1f133b6e 	fmadd	s14, s27, s19, s14
    40004b54:	1e2023d8 	fcmpe	s30, #0.0
    40004b58:	1f137fbf 	fmadd	s31, s29, s19, s31
    40004b5c:	bd0063fa 	str	s26, [sp, #96]
    40004b60:	0f00041d 	movi	v29.2s, #0x0
    40004b64:	1f134250 	fmadd	s16, s18, s19, s16
    40004b68:	2d0b1ff4 	stp	s20, s7, [sp, #88]
    40004b6c:	1e3e4fbe 	fcsel	s30, s29, s30, mi	// mi = first
    40004b70:	1e2e09dd 	fmul	s29, s14, s14
    40004b74:	1e360bdb 	fmul	s27, s30, s22
    40004b78:	1e3c0bdc 	fmul	s28, s30, s28
    40004b7c:	1e350bde 	fmul	s30, s30, s21
    40004b80:	1f10761d 	fmadd	s29, s16, s16, s29
    40004b84:	1f0d336c 	fmadd	s12, s27, s13, s12
    40004b88:	1f0d2f8b 	fmadd	s11, s28, s13, s11
    40004b8c:	1f0d2bca 	fmadd	s10, s30, s13, s10
    40004b90:	1e3709ad 	fmul	s13, s13, s23
    40004b94:	1f1f77e1 	fmadd	s1, s31, s31, s29
    40004b98:	1e21c03e 	fsqrt	s30, s1
    40004b9c:	1e2023d8 	fcmpe	s30, #0.0
    40004ba0:	540003ec 	b.gt	40004c1c <_ZN8Renderer8perPixelEjj+0x2fc>
    40004ba4:	0f000407 	movi	v7.2s, #0x0
    40004ba8:	1e2040ee 	fmov	s14, s7
    40004bac:	1e2040f0 	fmov	s16, s7
    40004bb0:	7100058c 	subs	w12, w12, #0x1
    40004bb4:	54fff581 	b.ne	40004a64 <_ZN8Renderer8perPixelEjj+0x144>  // b.any
    40004bb8:	1e260142 	fmov	w2, s10
    40004bbc:	d2800004 	mov	x4, #0x0                   	// #0
    40004bc0:	1e260161 	fmov	w1, s11
    40004bc4:	1e260180 	fmov	w0, s12
    40004bc8:	d2800003 	mov	x3, #0x0                   	// #0
    40004bcc:	6d4127e8 	ldp	d8, d9, [sp, #16]
    40004bd0:	d2a7f005 	mov	x5, #0x3f800000            	// #1065353216
    40004bd4:	6d422fea 	ldp	d10, d11, [sp, #32]
    40004bd8:	b3407c44 	bfxil	x4, x2, #0, #32
    40004bdc:	6d4337ec 	ldp	d12, d13, [sp, #48]
    40004be0:	b3407c23 	bfxil	x3, x1, #0, #32
    40004be4:	b3607c04 	bfi	x4, x0, #32, #32
    40004be8:	6d443fee 	ldp	d14, d15, [sp, #64]
    40004bec:	b3607ca3 	bfi	x3, x5, #32, #32
    40004bf0:	a8c97bfd 	ldp	x29, x30, [sp], #144
    40004bf4:	d50323bf 	autiasp
    40004bf8:	d360fc81 	lsr	x1, x4, #32
    40004bfc:	53007c84 	lsr	w4, w4, #0
    40004c00:	d360fc60 	lsr	x0, x3, #32
    40004c04:	53007c63 	lsr	w3, w3, #0
    40004c08:	1e270021 	fmov	s1, w1
    40004c0c:	1e270003 	fmov	s3, w0
    40004c10:	1e270080 	fmov	s0, w4
    40004c14:	1e270062 	fmov	s2, w3
    40004c18:	d65f03c0 	ret
    40004c1c:	1e3e1b18 	fdiv	s24, s24, s30
    40004c20:	1e380a10 	fmul	s16, s16, s24
    40004c24:	1e3809ce 	fmul	s14, s14, s24
    40004c28:	1e380be7 	fmul	s7, s31, s24
    40004c2c:	17ffffe1 	b	40004bb0 <_ZN8Renderer8perPixelEjj+0x290>
    40004c30:	1e2e09df 	fmul	s31, s14, s14
    40004c34:	1f107e01 	fmadd	s1, s16, s16, s31
    40004c38:	1f0704e7 	fmadd	s7, s7, s7, s1
    40004c3c:	1e21c0e7 	fsqrt	s7, s7
    40004c40:	1e2020f8 	fcmpe	s7, #0.0
    40004c44:	5400014c 	b.gt	40004c6c <_ZN8Renderer8perPixelEjj+0x34c>
    40004c48:	52933340 	mov	w0, #0x999a                	// #39322
    40004c4c:	72a7eb20 	movk	w0, #0x3f59, lsl #16
    40004c50:	1e2041bf 	fmov	s31, s13
    40004c54:	1e2d101d 	fmov	s29, #7.500000000000000000e-01
    40004c58:	1e27001e 	fmov	s30, w0
    40004c5c:	1f1d29aa 	fmadd	s10, s13, s29, s10
    40004c60:	1f1e31ac 	fmadd	s12, s13, s30, s12
    40004c64:	1e3f296b 	fadd	s11, s11, s31
    40004c68:	17ffffd4 	b	40004bb8 <_ZN8Renderer8perPixelEjj+0x298>
    40004c6c:	1e2e101e 	fmov	s30, #1.000000000000000000e+00
    40004c70:	1e2c101d 	fmov	s29, #5.000000000000000000e-01
    40004c74:	52866660 	mov	w0, #0x3333                	// #13107
    40004c78:	72a7e660 	movk	w0, #0x3f33, lsl #16
    40004c7c:	1e27001b 	fmov	s27, w0
    40004c80:	1e271bc7 	fdiv	s7, s30, s7
    40004c84:	1f0779df 	fmadd	s31, s14, s7, s30
    40004c88:	1e3d0bff 	fmul	s31, s31, s29
    40004c8c:	1e3f3bde 	fsub	s30, s30, s31
    40004c90:	1e3f2bdc 	fadd	s28, s30, s31
    40004c94:	1f1d7bfd 	fmadd	s29, s31, s29, s30
    40004c98:	1f1b7bfe 	fmadd	s30, s31, s27, s30
    40004c9c:	1e2d0b9f 	fmul	s31, s28, s13
    40004ca0:	17ffffef 	b	40004c5c <_ZN8Renderer8perPixelEjj+0x33c>
    40004ca4:	d503201f 	nop
    40004ca8:	d503201f 	nop
    40004cac:	d503201f 	nop

0000000040004cb0 <_ZN8Renderer6renderERK6CameraRK5ScenePj>:
    40004cb0:	d503245f 	bti	c
    40004cb4:	aa0003ee 	mov	x14, x0
    40004cb8:	b9400400 	ldr	w0, [x0, #4]
    40004cbc:	aa0303f2 	mov	x18, x3
    40004cc0:	a90085c2 	stp	x2, x1, [x14, #8]
    40004cc4:	34001180 	cbz	w0, 40004ef4 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x244>
    40004cc8:	52a86fe1 	mov	w1, #0x437f0000            	// #1132396544
    40004ccc:	d503233f 	paciasp
    40004cd0:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
    40004cd4:	910003fd 	mov	x29, sp
    40004cd8:	6d053fee 	stp	d14, d15, [sp, #80]
    40004cdc:	1e27002e 	fmov	s14, w1
    40004ce0:	a90153f3 	stp	x19, x20, [sp, #16]
    40004ce4:	52800014 	mov	w20, #0x0                   	// #0
    40004ce8:	a9025bf5 	stp	x21, x22, [sp, #32]
    40004cec:	a90363f7 	stp	x23, x24, [sp, #48]
    40004cf0:	6d0437ec 	stp	d12, d13, [sp, #64]
    40004cf4:	b94001d7 	ldr	w23, [x14]
    40004cf8:	2a1403f5 	mov	w21, w20
    40004cfc:	11004294 	add	w20, w20, #0x10
    40004d00:	34000d37 	cbz	w23, 40004ea4 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1f4>
    40004d04:	310046bf 	cmn	w21, #0x11
    40004d08:	54000fc8 	b.hi	40004f00 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x250>  // b.pmore
    40004d0c:	52800013 	mov	w19, #0x0                   	// #0
    40004d10:	5280020f 	mov	w15, #0x10                  	// #16
    40004d14:	6b15001f 	cmp	w0, w21
    40004d18:	54000a69 	b.ls	40004e64 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1b4>  // b.plast
    40004d1c:	2a1503ed 	mov	w13, w21
    40004d20:	2a1503e1 	mov	w1, w21
    40004d24:	3100467f 	cmn	w19, #0x11
    40004d28:	540008a8 	b.hi	40004e3c <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x18c>  // b.pmore
    40004d2c:	d503201f 	nop
    40004d30:	2a1303f6 	mov	w22, w19
    40004d34:	14000025 	b	40004dc8 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x118>
    40004d38:	1e2c101d 	fmov	s29, #5.000000000000000000e-01
    40004d3c:	1e2e101f 	fmov	s31, #1.000000000000000000e+00
    40004d40:	1b0d5af7 	madd	w23, w23, w13, w22
    40004d44:	0f00041e 	movi	v30.2s, #0x0
    40004d48:	110006d6 	add	w22, w22, #0x1
    40004d4c:	1e3d09ad 	fmul	s13, s13, s29
    40004d50:	1e3d09ef 	fmul	s15, s15, s29
    40004d54:	1e3d098c 	fmul	s12, s12, s29
    40004d58:	1e3f21b0 	fcmpe	s13, s31
    40004d5c:	1e2dcfed 	fcsel	s13, s31, s13, gt
    40004d60:	1e3f21f0 	fcmpe	s15, s31
    40004d64:	1e2fcfef 	fcsel	s15, s31, s15, gt
    40004d68:	1e3f2190 	fcmpe	s12, s31
    40004d6c:	1e2ccfff 	fcsel	s31, s31, s12, gt
    40004d70:	1e3e23f0 	fcmpe	s31, s30
    40004d74:	1e3f4fdf 	fcsel	s31, s30, s31, mi	// mi = first
    40004d78:	1e3e21f0 	fcmpe	s15, s30
    40004d7c:	1e2e0bff 	fmul	s31, s31, s14
    40004d80:	1e2f4fcf 	fcsel	s15, s30, s15, mi	// mi = first
    40004d84:	1e3e21b0 	fcmpe	s13, s30
    40004d88:	1e3903e0 	fcvtzu	w0, s31
    40004d8c:	1e2e09ef 	fmul	s15, s15, s14
    40004d90:	1e2d4fde 	fcsel	s30, s30, s13, mi	// mi = first
    40004d94:	53101c00 	ubfiz	w0, w0, #16, #8
    40004d98:	1e3901e2 	fcvtzu	w2, s15
    40004d9c:	1e2e0bde 	fmul	s30, s30, s14
    40004da0:	53181c42 	ubfiz	w2, w2, #8, #8
    40004da4:	7ea1bbde 	fcvtzu	s30, s30
    40004da8:	2a020000 	orr	w0, w0, w2
    40004dac:	0e013fc2 	umov	w2, v30.b[0]
    40004db0:	32081c42 	orr	w2, w2, #0xff000000
    40004db4:	2a020000 	orr	w0, w0, w2
    40004db8:	b8377a40 	str	w0, [x18, x23, lsl #2]
    40004dbc:	6b0f02df 	cmp	w22, w15
    40004dc0:	540005e2 	b.cs	40004e7c <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1cc>  // b.hs, b.nlast
    40004dc4:	b94001d7 	ldr	w23, [x14]
    40004dc8:	6b1602ff 	cmp	w23, w22
    40004dcc:	54000829 	b.ls	40004ed0 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x220>  // b.plast
    40004dd0:	0f00040c 	movi	v12.2s, #0x0
    40004dd4:	52800058 	mov	w24, #0x2                   	// #2
    40004dd8:	1e20418f 	fmov	s15, s12
    40004ddc:	1e20418d 	fmov	s13, s12
    40004de0:	2a0d03e2 	mov	w2, w13
    40004de4:	2a1603e1 	mov	w1, w22
    40004de8:	aa0e03e0 	mov	x0, x14
    40004dec:	97fffecd 	bl	40004920 <_ZN8Renderer8perPixelEjj>
    40004df0:	1e260004 	fmov	w4, s0
    40004df4:	d2800000 	mov	x0, #0x0                   	// #0
    40004df8:	1e260023 	fmov	w3, s1
    40004dfc:	1e260042 	fmov	w2, s2
    40004e00:	b3407c80 	bfxil	x0, x4, #0, #32
    40004e04:	b3607c60 	bfi	x0, x3, #32, #32
    40004e08:	93407c41 	sxtw	x1, w2
    40004e0c:	9e67003e 	fmov	d30, x1
    40004e10:	93407c01 	sxtw	x1, w0
    40004e14:	9e67001f 	fmov	d31, x0
    40004e18:	9e67003d 	fmov	d29, x1
    40004e1c:	1e3e298c 	fadd	s12, s12, s30
    40004e20:	7f6007ff 	ushr	d31, d31, #32
    40004e24:	1e3d29ad 	fadd	s13, s13, s29
    40004e28:	1e3f29ef 	fadd	s15, s15, s31
    40004e2c:	7100071f 	cmp	w24, #0x1
    40004e30:	54fff840 	b.eq	40004d38 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x88>  // b.none
    40004e34:	52800038 	mov	w24, #0x1                   	// #1
    40004e38:	17ffffea 	b	40004de0 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x130>
    40004e3c:	11000422 	add	w2, w1, #0x1
    40004e40:	11000821 	add	w1, w1, #0x2
    40004e44:	6b02029f 	cmp	w20, w2
    40004e48:	540000e9 	b.ls	40004e64 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1b4>  // b.plast
    40004e4c:	6b00005f 	cmp	w2, w0
    40004e50:	540000a2 	b.cs	40004e64 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1b4>  // b.hs, b.nlast
    40004e54:	6b01029f 	cmp	w20, w1
    40004e58:	54000069 	b.ls	40004e64 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1b4>  // b.plast
    40004e5c:	6b00003f 	cmp	w1, w0
    40004e60:	54fffee3 	b.cc	40004e3c <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x18c>  // b.lo, b.ul, b.last
    40004e64:	6b0f02ff 	cmp	w23, w15
    40004e68:	540001a9 	b.ls	40004e9c <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1ec>  // b.plast
    40004e6c:	110041e1 	add	w1, w15, #0x10
    40004e70:	2a0f03f3 	mov	w19, w15
    40004e74:	2a0103ef 	mov	w15, w1
    40004e78:	17ffffa7 	b	40004d14 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x64>
    40004e7c:	110005ad 	add	w13, w13, #0x1
    40004e80:	6b1401bf 	cmp	w13, w20
    40004e84:	54000342 	b.cs	40004eec <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x23c>  // b.hs, b.nlast
    40004e88:	294001d7 	ldp	w23, w0, [x14]
    40004e8c:	6b0001bf 	cmp	w13, w0
    40004e90:	54fff503 	b.cc	40004d30 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x80>  // b.lo, b.ul, b.last
    40004e94:	6b0f02ff 	cmp	w23, w15
    40004e98:	54fffea8 	b.hi	40004e6c <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1bc>  // b.pmore
    40004e9c:	6b14001f 	cmp	w0, w20
    40004ea0:	54fff2c8 	b.hi	40004cf8 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x48>  // b.pmore
    40004ea4:	1b177c00 	mul	w0, w0, w23
    40004ea8:	6d4437ec 	ldp	d12, d13, [sp, #64]
    40004eac:	a94153f3 	ldp	x19, x20, [sp, #16]
    40004eb0:	531e7401 	lsl	w1, w0, #2
    40004eb4:	aa1203e0 	mov	x0, x18
    40004eb8:	a9425bf5 	ldp	x21, x22, [sp, #32]
    40004ebc:	a94363f7 	ldp	x23, x24, [sp, #48]
    40004ec0:	6d453fee 	ldp	d14, d15, [sp, #80]
    40004ec4:	a8c67bfd 	ldp	x29, x30, [sp], #96
    40004ec8:	d50323bf 	autiasp
    40004ecc:	17fff739 	b	40002bb0 <clean_cache_provider>
    40004ed0:	110005ad 	add	w13, w13, #0x1
    40004ed4:	b94005c0 	ldr	w0, [x14, #4]
    40004ed8:	6b0d029f 	cmp	w20, w13
    40004edc:	54fffc49 	b.ls	40004e64 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1b4>  // b.plast
    40004ee0:	6b0001bf 	cmp	w13, w0
    40004ee4:	54fff263 	b.cc	40004d30 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x80>  // b.lo, b.ul, b.last
    40004ee8:	17ffffdf 	b	40004e64 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1b4>
    40004eec:	294001d7 	ldp	w23, w0, [x14]
    40004ef0:	17ffffdd 	b	40004e64 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1b4>
    40004ef4:	2a0003e1 	mov	w1, w0
    40004ef8:	aa0303e0 	mov	x0, x3
    40004efc:	17fff72d 	b	40002bb0 <clean_cache_provider>
    40004f00:	52800201 	mov	w1, #0x10                  	// #16
    40004f04:	11004022 	add	w2, w1, #0x10
    40004f08:	6b0102ff 	cmp	w23, w1
    40004f0c:	54fffc89 	b.ls	40004e9c <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1ec>  // b.plast
    40004f10:	6b0202ff 	cmp	w23, w2
    40004f14:	54fffc49 	b.ls	40004e9c <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1ec>  // b.plast
    40004f18:	11008021 	add	w1, w1, #0x20
    40004f1c:	11004022 	add	w2, w1, #0x10
    40004f20:	6b0102ff 	cmp	w23, w1
    40004f24:	54ffff68 	b.hi	40004f10 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x260>  // b.pmore
    40004f28:	6b14001f 	cmp	w0, w20
    40004f2c:	54ffee68 	b.hi	40004cf8 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x48>  // b.pmore
    40004f30:	17ffffdd 	b	40004ea4 <_ZN8Renderer6renderERK6CameraRK5ScenePj+0x1f4>
    40004f34:	d503201f 	nop
    40004f38:	d503201f 	nop
    40004f3c:	d503201f 	nop

0000000040004f40 <_ZN8Renderer4MissERK3Ray>:
    40004f40:	d503245f 	bti	c
    40004f44:	d2b7f000 	mov	x0, #0xbf800000            	// #3212836864
    40004f48:	bd40143e 	ldr	s30, [x1, #20]
    40004f4c:	f9000100 	str	x0, [x8]
    40004f50:	2d41fc3d 	ldp	s29, s31, [x1, #12]
    40004f54:	f900091f 	str	xzr, [x8, #16]
    40004f58:	b900191f 	str	wzr, [x8, #24]
    40004f5c:	1e3f0bfc 	fmul	s28, s31, s31
    40004f60:	1f1d73a0 	fmadd	s0, s29, s29, s28
    40004f64:	1f1e03de 	fmadd	s30, s30, s30, s0
    40004f68:	1e21c3de 	fsqrt	s30, s30
    40004f6c:	1e2023d8 	fcmpe	s30, #0.0
    40004f70:	5400012c 	b.gt	40004f94 <_ZN8Renderer4MissERK3Ray+0x54>
    40004f74:	52933340 	mov	w0, #0x999a                	// #39322
    40004f78:	72a7eb20 	movk	w0, #0x3f59, lsl #16
    40004f7c:	1e2e101f 	fmov	s31, #1.000000000000000000e+00
    40004f80:	1e2d101b 	fmov	s27, #7.500000000000000000e-01
    40004f84:	1e27001e 	fmov	s30, w0
    40004f88:	bd000d1f 	str	s31, [x8, #12]
    40004f8c:	2d00f91b 	stp	s27, s30, [x8, #4]
    40004f90:	d65f03c0 	ret
    40004f94:	1e2e101c 	fmov	s28, #1.000000000000000000e+00
    40004f98:	1e2c101b 	fmov	s27, #5.000000000000000000e-01
    40004f9c:	52866660 	mov	w0, #0x3333                	// #13107
    40004fa0:	72a7e660 	movk	w0, #0x3f33, lsl #16
    40004fa4:	1e27001d 	fmov	s29, w0
    40004fa8:	1e3e1b9e 	fdiv	s30, s28, s30
    40004fac:	1f1e73ff 	fmadd	s31, s31, s30, s28
    40004fb0:	1e3b0bff 	fmul	s31, s31, s27
    40004fb4:	1e3f3b9c 	fsub	s28, s28, s31
    40004fb8:	1f1b73fb 	fmadd	s27, s31, s27, s28
    40004fbc:	1f1d73fe 	fmadd	s30, s31, s29, s28
    40004fc0:	1e3c2bff 	fadd	s31, s31, s28
    40004fc4:	bd000d1f 	str	s31, [x8, #12]
    40004fc8:	2d00f91b 	stp	s27, s30, [x8, #4]
    40004fcc:	d65f03c0 	ret

0000000040004fd0 <tanf>:
    40004fd0:	d503245f 	bti	c
    40004fd4:	5281ba21 	mov	w1, #0xdd1                 	// #3537
    40004fd8:	72a7aba1 	movk	w1, #0x3d5d, lsl #16
    40004fdc:	1e20081d 	fmul	s29, s0, s0
    40004fe0:	52911120 	mov	w0, #0x8889                	// #34953
    40004fe4:	72a7c100 	movk	w0, #0x3e08, lsl #16
    40004fe8:	1e2e101c 	fmov	s28, #1.000000000000000000e+00
    40004fec:	1e27003a 	fmov	s26, w1
    40004ff0:	5284f482 	mov	w2, #0x27a4                	// #10148
    40004ff4:	72a79662 	movk	w2, #0x3cb3, lsl #16
    40004ff8:	1e27001f 	fmov	s31, w0
    40004ffc:	52955561 	mov	w1, #0xaaab                	// #43691
    40005000:	72a7d541 	movk	w1, #0x3eaa, lsl #16
    40005004:	1e27005b 	fmov	s27, w2
    40005008:	1e27003e 	fmov	s30, w1
    4000500c:	1f1a7fbf 	fmadd	s31, s29, s26, s31
    40005010:	1f1b7fbf 	fmadd	s31, s29, s27, s31
    40005014:	1f1d7bff 	fmadd	s31, s31, s29, s30
    40005018:	1f1d73ff 	fmadd	s31, s31, s29, s28
    4000501c:	1e200be0 	fmul	s0, s31, s0
    40005020:	d65f03c0 	ret
    40005024:	d503201f 	nop
    40005028:	d503201f 	nop
    4000502c:	d503201f 	nop

0000000040005030 <__cxa_atexit>:
    40005030:	d503245f 	bti	c
    40005034:	52800000 	mov	w0, #0x0                   	// #0
    40005038:	d65f03c0 	ret
    4000503c:	d503201f 	nop

0000000040005040 <__cxa_pure_virtual>:
    40005040:	d503245f 	bti	c
    40005044:	d503201f 	nop
    40005048:	14000000 	b	40005048 <__cxa_pure_virtual+0x8>
    4000504c:	d503201f 	nop

0000000040005050 <_Znwm>:
    40005050:	d503245f 	bti	c
    40005054:	17fff683 	b	40002a60 <kmalloc>
    40005058:	d503201f 	nop
    4000505c:	d503201f 	nop

0000000040005060 <_Znam>:
    40005060:	d503245f 	bti	c
    40005064:	17fff67f 	b	40002a60 <kmalloc>
    40005068:	d503201f 	nop
    4000506c:	d503201f 	nop

0000000040005070 <_ZdlPv>:
    40005070:	d503245f 	bti	c
    40005074:	d65f03c0 	ret
    40005078:	d503201f 	nop
    4000507c:	d503201f 	nop

0000000040005080 <_ZdaPv>:
    40005080:	d503245f 	bti	c
    40005084:	d65f03c0 	ret
    40005088:	d503201f 	nop
    4000508c:	d503201f 	nop

0000000040005090 <_ZdlPvm>:
    40005090:	d503245f 	bti	c
    40005094:	d65f03c0 	ret
