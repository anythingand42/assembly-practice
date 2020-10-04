global _start

extern str_to_num
extern line_len
extern num_to_str
extern sum

section .text

_start:
    mov eax, [esp]      ; argc
    cmp eax, 3
    jne .error

    mov esi, esp
    add esi, 8          ; *argv[1]
    push 0
    push dword [esi]
    call line_len
    add esp, 8
    push eax
    push dword [esi]
    call str_to_num
    add esp, 8
    cmp eax, -1
    je .error

    mov ebx, eax        ; start
    add esi, 4
    push 0
    push dword [esi]
    call line_len
    add esp, 8
    push eax
    push dword [esi]
    call str_to_num
    add esp, 8
    cmp eax, -1
    je .error
    ; end is in eax

    cmp ebx, eax
    ja .error
    push ebx
    push eax
    call sum
    add esp, 8

    push buf
    push eax
    call num_to_str
    add esp, 8

    push 0
    push buf
    call line_len
    add esp, 8
    mov byte [buf+eax], 10
    inc eax

    mov edx, eax
    mov ecx, buf
    mov ebx, 1
    mov eax, 4
    int 80h
    jmp .quit

.error:
    jmp .quit

.quit:
    mov ebx, 0
    mov eax, 1
    int 80h

section .bss
buf     resb    16
