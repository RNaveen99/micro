.model small
.data
    first db 7, 8, 9, 15, 2
    num db 15
    msg1 db 10, 13, "Number found at Index $"
    msg2 db 10, 13, "Number not found $"
.code
    .startup
    mov si, 0
    mov bl, num
    mov cx, 5
    search:
        cmp first[si], bl
        je found
        inc si
        loop search

    lea dx, msg2
    mov ah, 09h
    int 21h
    .exit

    found:
        lea dx, msg1
        mov ah, 09h
        int 21h
        mov dx, si
        add dl, 30h
        mov ah, 02h
        int 21h
    .exit
end