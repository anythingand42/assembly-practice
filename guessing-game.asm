global _start

extern str_to_num
extern rand

section .text
_start:
    push dword 1
    call rand
    add esp, 4

    mov ebp, esp
    sub esp, 8
    mov [ebp-4], eax        ; hidden number
    mov dword [ebp-8], 0    ; attempt counter

    ; print greeting
    mov edx, greeting
    mov ecx, greeting_len
    mov ebx, 1
    mov eax, 4
    int 80h

    mov edx,

.quit:
    xor ebx, ebx
    mov eax, 1
    int 80h

section .data
greeting         db     "guess the number (from 0 to 255)", 10
greeting_len     equ    $-greeting

msg_less         db     "try less", 10
msg_less_len     equ    $-msg_less

msg_more         db     "try more", 10
msg_more_len     equ    $-msg_more

msg_win          db     "well done", 10
msg_win_len      equ    $-msg_win
