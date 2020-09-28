global num_to_str

; only for natural numbers lower than 2^32
; [esp+12] - destination str address (should be at least 11 bytes)
; [esp+8] - source num (32 bit)
; eax - number of bytes written
; ebx - error flag (0 - success, 1 - error)

section .text

num_to_str:
    push ebp
    mov ebp, esp

    sub esp, 4
    mov eax, [ebp+8]
    mov [ebp-4], eax            ; source num
    mov edi, [ebp+12]           ; destination str
    mov ebx, 1000000000         ; divider
    xor ecx, ecx                ; digit's counter

.find_start_divider:
    xor edx, edx
    mov eax, [ebp-4]
    mov esi, ebx
    div esi
    cmp eax, 0
    jne .handle_digit           ; if true, ebx contains start divider
    xor edx, edx
    mov eax, ebx
    mov esi, 10
    div esi
    mov ebx, eax
    jmp .find_start_divider

.handle_digit:
    xor edx, edx
    mov eax, [ebp-4]
    mov esi, ebx
    div esi
    add eax, '0'

    mov [edi+ecx], eax
    inc ecx

    cmp edx, 0                  ; check remainder
    je .success

    mov [ebp-4], edx

    xor edx, edx                ; divide ebx by 10
    mov eax, ebx
    mov esi, 10
    div esi
    mov ebx, eax

    jmp .handle_digit

.error:
    mov ebx, 1
    jmp .quit
.success:
    mov eax, ecx                ; return number of written bytes
    xor ebx, ebx
.quit:
    mov esp, ebp
    pop ebp
    ret
