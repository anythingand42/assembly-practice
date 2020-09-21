global _start

extern str_to_num
extern rand
extern line_len

%define I_BUF_SIZE 8

section .text
_start:
    push 1
    call rand
    add esp, 4

    cmp ebx, 0
    je .rand_ok
    mov edx, msg_randerr_len
    mov ecx, msg_randerr
    mov ebx, 1
    mov eax, 4
    int 80h
    jmp .error

.rand_ok:
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

    cmp eax, 3              ; max number of digits (from 0 to 255)
    ja .cant_read

    push eax
    push i_buf
    call str_to_num
    add esp, 8

    cmp ebx, 0
    jne .cant_read

    add dword [ebp-8], 1
    cmp [ebp-4], eax
    ja .try_more
    cmp [ebp-4], eax
    jb .try_less

    mov edx, msg_win_len
    mov ecx, msg_win
    mov ebx, 1
    mov eax, 4
    int 80h
    mov ecx, [ebp-8]
.metka:
    jmp .quit

.try_less:
    mov edx, msg_less_len
    mov ecx, msg_less
    mov ebx, 1
    mov eax, 4
    int 80h
    jmp .clear_buf
.try_more:
    mov edx, msg_more_len
    mov ecx, msg_more
    mov ebx, 1
    mov eax, 4
    int 80h
.clear_buf:
    mov ecx, I_BUF_SIZE
    mov eax, 0
.clear_loop:
    mov ebx, i_buf
    add ebx, eax
    inc eax
    dec ecx
    jnz .clear_loop
    jmp .handle_input

.cant_read:
    mov edx, msg_readerr_len
    mov ecx, msg_readerr
    mov ebx, 1
    mov eax, 4
    int 80h

.error:
    mov ebx, 1
    jmp short .quit
.success:
    xor eax, eax
.quit:
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

msg_randerr      db     "error reading /dev/random", 10
msg_randerr_len  equ    $-msg_randerr

section .bss
i_buf        resb   I_BUF_SIZE
