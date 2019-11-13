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
    first dw 1234h, 5678h
    second dw 1234h, 5678h
    result dw 2 dup(0)
    tempCount dw ?
    msg db "Result of 32 bit addition: $", 10

.code
    .startup
    mov si, 4h
    lea dx, msg
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
    
    jnc printing

    ;---------------print carry if any-----------------
    mov dl, 31h
    mov ah, 02h
    int 21h
    ;--------------------------------------------------

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

        ; mov bx, result[si]
        ; mov cx, 4
        ;     printDigit2:
        ;         rol bx, 4
        ;         mov dl, bl
        ;         and dl, 0fh
        ;         add dl, 30h
        ;         cmp dl, 39h
        ;         jbe print2
        ;         add dl, 07h
        ;         print2:
        ;             mov ah, 02h
        ;             int 21h
        ;     loop printDigit2
    .exit
end