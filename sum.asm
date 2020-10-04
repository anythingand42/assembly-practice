global sum

; [ebp+12] - start
; [ebp+8] - end
; eax - result

section .text

sum:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, [ebp+12]
    cmp eax, [ebp+8]
    je .quit

    mov ebx, eax
    inc eax
    push eax
    push dword [ebp+8]
    call sum
    add esp, 8
    add eax, ebx

.quit:
    pop ebx
    mov esp, ebp
    pop ebp
    ret
