/* Single-player net stubs for Mana — no sockets, no multiplayer. */
#include "doomtype.h"
#include "d_net.h"
#include "i_net.h"

void I_InitNetwork(void) {
    extern doomcom_t *doomcom;
    static doomcom_t com;
    doomcom = &com;
    doomcom->id = DOOMCOM_ID;
    doomcom->numnodes = 1;
    doomcom->numplayers = 1;
    doomcom->consoleplayer = 0;
    doomcom->ticdup = 1;
    doomcom->extratics = 0;
    doomcom->deathmatch = 0;
    doomcom->savegame = -1;
}

void I_NetCmd(void) {
    /* no-op */
}
