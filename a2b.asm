.model small
.stack 100h
.data
    msg1 db "Enter an ASCII character: $"
    msg2 db 10, 13, "ASCII character in Binary: $"
.code
    .startup
    lea dx, msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al

    lea dx, msg2
    mov ah, 09h
    int 21h

    mov cx, 8
    output:
        rol bl, 1
        mov dl, bl
        and dl, 01h
        add dl, 30h
        mov ah, 02h
        int 21h
        loop output
    .exit
end