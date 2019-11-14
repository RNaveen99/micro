.model small
.stack 100h
.data
    first dw 1234h, 5678h
    second dw 1234h, 5678h
    result dw 2 dup(0)
    tempCount dw ?
    msg1 db 10, "Enter first number : $"
    msg2 db 10, "Enter second number : $"
    msg3 db 10, "Result of BCD addition : $"

.code
    .startup
    lea dx, msg1
    mov ah, 09h
    int 21h

    mov si, 0
    mov cx, 2

    input1:
        mov bx, 00
        mov tempCount, cx
        mov cx, 4
        inputDigit1:
            shl bx, 4
            mov ah, 01h
            int 21h
            sub al, 30h
            mov ah, 00h
            add bx, ax
            loop inputDigit1
        mov first[si], bx
        inc si
        inc si
        mov cx, tempCount
        loop input1

    lea dx, msg2
    mov ah, 09h
    int 21h

    mov si, 0
    mov cx, 2

    input2:
        mov bx, 00
        mov tempCount, cx
        mov cx, 4
        inputDigit2:
            shl bx, 4
            mov ah, 01h
            int 21h
            sub al, 30h
            mov ah, 00h
            add bx, ax
            loop inputDigit2
        mov second[si], bx
        inc si
        inc si
        mov cx, tempCount
        loop input2

    mov cx, 2
    
    clc

    addition:
        dec si
        dec si
        mov ax, first[si]
        mov bx, second[si]
        adc al, bl
        daa
        adc ah, bh
        mov bl, al
        mov al, ah
        daa
        mov bh, al
        mov result[si], bx
        loop addition

    lea dx, msg3
    mov ah, 09h
    int 21h

    jnc output
    mov dl, 31h
    mov ah, 02h
    int 21h

    output:
        mov cx, 2
        printing:
            mov bx, result[si]
            mov tempCount, cx
            mov cx, 4
            printDigit:
                rol bx, 4
                mov dl, bl
                and dl, 0fh
                add dl, 30h
                mov ah, 02h
                int 21h
                loop printDigit
            inc si
            inc si
            mov cx, tempCount
            loop printing
    .exit
end