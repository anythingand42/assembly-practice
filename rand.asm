global rand

; read random bytes from /dev/random and write them to eax
; [esp+8] - number of bytes (1 <= x <= 4)
; eax - result
; ebx - error flag (0 - success, 1 - error)

section .text

rand:
    push ebp
    mov ebp, esp

    ; open /dev/random
    mov ecx, 0          ; read only
    mov ebx, dev_rnd
    mov eax, 5
    int 80h

    cmp eax, 0          ; check opening errors
    jl .error

    ; read
    push dword 0        ; use stack as a buffer
    mov edx, [ebp+8]
    mov ecx, esp
    mov ebx, eax
    mov eax, 3
    int 80h

    cmp eax, [ebp+8]    ; check number of read bytes
    jne .error

    pop eax

.error:
    mov ebx, 1
    jmp .quit
.success:
    xor ebx, ebx
.quit:
    mov esp, ebp
    pop ebp
    ret

section .data
dev_rnd     db  "/dev/random", 0
