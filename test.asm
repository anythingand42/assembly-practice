global _start

extern str_to_num

section .text
_start:
        push str_len
        push msg
        call str_to_num
lalala:
        mov ebx, 0
        mov eax, 1
        int 80h

section .data
msg db "1234"
str_len equ $-msg
