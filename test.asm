global _start

; extern str_to_num
; extern rand
extern line_len

section .text
_start:
        push 10
        push msg
        call line_len
lalala:
        mov ebx, 0
        mov eax, 1
        int 80h

section .data
msg db "1234", 10
str_len equ $-msg
