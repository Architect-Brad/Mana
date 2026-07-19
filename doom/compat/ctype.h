#ifndef MANA_COMPAT_CTYPE_H
#define MANA_COMPAT_CTYPE_H
/* Function forms only — avoid macros that break other prototypes */
int isdigit(int c);
int isalpha(int c);
int isalnum(int c);
int isspace(int c);
int isupper(int c);
int islower(int c);
int isprint(int c);
int toupper(int c);
int tolower(int c);
#endif
