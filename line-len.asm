global line_len

; [esp+12] - end of line byte
; [esp+8] - line adress
; eax - result

section .text

line_len:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]

.handle_symbol:
    cmp [ebx+eax], cl
    je .quit
    cmp byte [ebx+eax], 0
    je .quit
    inc eax
    jmp short .handle_symbol

.quit:
    pop ebp
    ret

