#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <gcrypt.h>

#define GCRYPT_VERSION "1.5.0"
#define GCRY_CIPHER GCRY_CIPHER_AES128

int main(void){
    if(!gcry_check_version(GCRYPT_VERSION)){
        fputs("libgcrypt version mismatch\n", stderr);
        exit(2);
    }
    gcry_control(GCRYCTL_SUSPEND_SECMEM_WARN);
    gcry_control(GCRYCTL_INIT_SECMEM, 16384, 0);
    gcry_control(GCRYCTL_RESUME_SECMEM_WARN);
    gcry_control (GCRYCTL_INITIALIZATION_FINISHED, 0);

    int algo = -1;
    size_t i;
    const char *name = "aes128";
    char hexstring[16] = {0x80};
    char key[16] = {0};
    char iniVector[16] = {0};
    size_t txtLenght = strlen(hexstring);
    char *encBuffer = malloc(txtLenght);
    gcry_cipher_hd_t hd;
    algo = gcry_cipher_map_name(name);
    size_t blkLength = gcry_cipher_get_algo_blklen(GCRY_CIPHER);
    size_t keyLength = gcry_cipher_get_algo_keylen(GCRY_CIPHER);

    gcry_cipher_open(&hd, algo, GCRY_CIPHER_MODE_CBC, 0);
    gcry_cipher_setkey(hd, key, keyLength);
    gcry_cipher_setiv(hd, iniVector, blkLength);
    gcry_cipher_encrypt(hd, encBuffer, txtLenght, plain_text, txtLenght);

    printf("encBuffer = ");
    for(i = 0; i < txtLenght; i++){
        printf("%02x", (unsigned char) encBuffer[i]);
    }
    printf("\n");

    gcry_cipher_close(hd);
    free(encBuffer);
    return 0;
}
