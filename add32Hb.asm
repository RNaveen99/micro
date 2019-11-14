;lea : moves the memory address of operand 2 to operand 1
;int 21h : interrupt call int [interruptIndex]
;cx is a 16 bit register used with loops
;clc : carry flag CF = 0
;adc : add-with-carry
;jnc : jump if carry flag off
;jbe : jump if less or equals
;interrupt code 02h "output a char"

.model small

.data
    first dw 2 dup(0)
    second dw 2 dup(0)
    result dw 2 dup(0)
    tempCount dw ?
    msg1 db 10, "Enter first number: $"
    msg2 db 10, "Enter second number: $"
    msg3 db 10, "Result of 32 bit addition: $", 10

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
            mov ah, 01
            int 21h
            sub al, 30h
            cmp al, 9h
            jbe store1
            sub al, 07h
        store1:
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
            mov ah, 01
            int 21h
            sub al, 30h
            cmp al, 9h
            jbe store2
            sub al, 07h
        store2:
            mov ah, 00h
            add bx, ax
            loop inputDigit2
        mov second[si], bx
        inc si
        inc si
        mov cx, tempCount
        loop input2

    lea dx, msg3
    mov ah, 09h
    int 21h
    
    mov cx, 2
    clc

    addition:
        dec si
        dec si
        mov dx, first[si]
        adc dx, second[si]
        mov result[si], dx
    loop addition
    
    jnc output

    ;---------------print carry if any-----------------
    mov dl, 31h
    mov ah, 02h
    int 21h
    ;--------------------------------------------------
    
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
                cmp dl, 39h
                jbe print
                add dl, 07h
                print:
                    mov ah, 02h
                    int 21h
                loop printDigit
            inc si
            inc si
            mov cx, tempCount
            loop printing
    .exit
end