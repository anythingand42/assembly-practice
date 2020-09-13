global _start

extern str_to_num
extern rand

section .text
_start:
        push 1
        call rand
lalala:
        mov ebx, 0
        mov eax, 1
        int 80h

section .data
msg db "1234"
str_len equ $-msg
