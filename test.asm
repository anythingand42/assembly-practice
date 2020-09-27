global _start

; extern str_to_num
; extern rand
; extern line_len
extern num_to_str

section .text
_start:
        push buf
        push 3214
        call num_to_str
lalala:
        mov ebx, 0
        mov eax, 1
        int 80h

section .bss
buf     resb    11
