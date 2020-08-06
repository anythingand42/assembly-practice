global _start

section .text
_start:
    mov edx, msg_len
    mov ecx, msg
    mov ebx, 1    ; stdout
    mov eax, 4    ; write
    int 80h

    xor ebx, ebx
    mov eax, 1
    int 80h

section .data
msg     db  "Hello, world!", 10
msg_len equ $-msg
