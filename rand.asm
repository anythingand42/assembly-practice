global rand

; read random bytes from /dev/random and write them to eax
; [esp+8] - number of bytes (1 <= x <= 4)

section .text

rand:
    push ebp
    mov ebp, esp

    ; open /dev/random
    mov ecx, 0          ; read only
    mov ebx, dev_rnd
    mov eax, 5
    int 80h

    ; read
    push dword 0        ; the stack is buffer
    mov edx, [ebp+8]
    mov ecx, esp
    mov ebx, eax
    mov eax, 3
    int 80h

    pop eax

    mov esp, ebp
    pop ebp
    ret

section .data
dev_rnd     db  "/dev/random", 0
