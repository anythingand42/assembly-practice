global _start

extern str_to_num
extern rand
extern line_len

%define I_BUF_SIZE 16

section .text
_start:
    push 1
    call rand
    add esp, 4

    mov ebp, esp
    sub esp, 8
    mov [ebp-4], eax        ; hidden number
    mov dword [ebp-8], 0    ; attempt counter

    ; print greeting
    mov edx, greeting_len
    mov ecx, greeting
    mov ebx, 1
    mov eax, 4
    int 80h

.handle_input:
    mov edx, I_BUF_SIZE
    mov ecx, i_buf
    mov ebx, 0
    mov eax, 3
    int 80h

    push 10                 ; end of line
    push i_buf
    call line_len
    add esp, 8

    cmp eax, 0
    je .cant_read

    cmp eax, 10             ; number of digits in 2^32
    ja .cant_read

    push eax
    push i_buf
    call str_to_num
    add esp, 8

    cmp ebx, 0
    jne .cant_read
    jmp .quit

.cant_read:
    mov edx, msg_readerr_len
    mov ecx, msg_readerr
    mov ebx, 1
    mov eax, 4
    int 80h
    jmp .handle_input

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

msg_readerr      db     "can't read", 10
msg_readerr_len  equ    $-msg_readerr

section .bss
i_buf        resb   I_BUF_SIZE
