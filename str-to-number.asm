global str_to_num

section .text

; only for natural numbers lower than 2^32
; [esb+8] - source str adress
; [esp+12] - str len
; eax - result

str_to_num:
        push ebp
        mov ebp, esp

        sub esp, 8
        mov eax, [ebp+12]
        dec eax
        mov dword [ebp-4], 0            ; accum
        mov [ebp-8], eax                ; strlen - 1

        mov esi, [ebp+8]                ; source str address
        xor ecx, ecx                    ; ptr
        mov ebx, 10

.handle_digit:
        xor eax, eax
        mov al, [esi+ecx]
        cmp al, '0'
        jb .error
        cmp al, '9'
        ja .error
        sub eax, '0'
        mov edi, [ebp+12]
        sub edi, ecx
        dec edi
        jz .after_mul

.mul_10:
        mul ebx
        dec edi
        jnz .mul_10

.after_mul:
        add [ebp-4], eax
        cmp ecx, [ebp-8]
        je .end
        inc ecx
        jmp .handle_digit

.end:
        mov eax, [ebp-4]
        jmp .success

.error:
        mov ebx, 1
        jmp .quit
.success:
        xor ebx, ebx
.quit:
        mov esp, ebp
        pop ebp
        ret
