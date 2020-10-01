global line_len

; [esp+8] - end of line byte
; [esp+4] - line adress
; eax - result

section .text

line_len:
    xor eax, eax
    mov edx, [esp+4]
    mov ecx, [esp+8]

.handle_symbol:
    cmp [edx+eax], cl
    je .quit
    cmp byte [edx+eax], 0
    je .quit
    inc eax
    jmp short .handle_symbol

.quit:
    ret

