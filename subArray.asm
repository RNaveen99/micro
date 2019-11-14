;jg : jump if greater
.model small
.stack 100h
.data
    first db 7, 8, 9, 1, 2
    second db 3, 2, 5, 4, 6
    result db 5 dup(?)
    msg1 db "Result : $"
    msg2 db " $"
.code
    .startup
    mov si, 0
    mov cx, 5
    subtraction:
        mov dl, first[si]
        sub dl, second[si]
        mov result[si], dl
        inc si
        loop subtraction
    
    lea dx, msg1
    mov ah, 09h
    int 21h

    mov cx, 5
    mov bx, cx
    mov si,  0
    output:
        mov cx, 2
        print:
            rol result[si], 4
            mov dl, result[si]
            and dl, 0fh
            cmp dl, 9h
            jg l3
            add dl, 30h
            jmp l4
            l3:
                add dl, 37h
            l4:
                mov ah, 02h
                int 21h
                loop print
        lea dx, msg2
        mov ah, 09h
        int 21h
        inc si
        mov cx, bx
        dec bx
        loop output
    .exit
end