global _start
section .text
_start:

        jmp short north		;We use JMP-CALL_POP technic to operate with /bin/ksh without bind to certain address

south:
        xor eax, eax    ;We zeroed eax as we need NULL for terminated argv[] later
        pop esi         ;esi now contains an address of /bin/ksh string
        mov dword [esi + 8], eax	;add NULL at the end of /bin/ksh 
        mov ebx,esi     ;mov address of /bin/ksh into ebx

        push eax        ;NULL
	mov edx, esp	;EDX points to NULL (envp[])
        push ebx        ;make pointer to /bin/ksh and push it into stack
        mov ecx, esp    ;copy pointer to argv[] from stack into ecx 
        mov    al,0xb   ;execve() code (11)
        int    0x80     ;run syscall

north:
        call south		;Call initiates storing the next command address into stack, so that we store address of /bin/ksh string 
        string db "/bin/ksh"    ;here we use a part of ksh
