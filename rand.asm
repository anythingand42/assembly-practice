global rand

; read random bytes from /dev/random and write them to eax
; [esp+8] - number of bytes (1 <= x <= 3)
; eax - result (-1 if error)

section .text

rand:
    push ebp
    mov ebp, esp
    push ebx

    ; open /dev/random
    mov ecx, 0          ; read only
    mov ebx, dev_rnd
    mov eax, 5
    int 80h

    cmp eax, 0          ; check opening errors
    jl .error

    ; read
    push 0              ; use stack as a buffer
    mov edx, [ebp+8]
    mov ecx, esp
    mov ebx, eax
    mov eax, 3
    int 80h

    cmp eax, [ebp+8]    ; check number of read bytes
    jne .error

    pop eax
    jmp .quit

.error:
    mov eax, -1
    jmp .quit
.quit:
    pop ebx
    mov esp, ebp
    pop ebp
    ret

section .data
dev_rnd     db  "/dev/random", 0
