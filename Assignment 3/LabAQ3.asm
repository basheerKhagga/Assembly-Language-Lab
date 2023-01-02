dosseg
.model small
.stack 100h
.data

a db 0
b db 0
l db 0
d db 0
e db 0
f db 0
g db 0

.code

main proc
mov ax, @data
mov ds, ax
xor ax,ax

mov cx, 7
mov si, offset a
takeinput:
    mov ah, 1
    int 21h
    sub al, 48
    mov [si], al
    inc si
    loop takeinput
    
call newLine
xor dx,dx
mov cl, g
mov ch, d
mov bl, e
mov bh, l

cmp cl, f
je firstAnd
cmp bl, ch
je exit
firstAnd:
cmp cl, ch
je secIf
cmp f, bl
jg exit

        secIf:
        cmp a, cl
        jng exit
        cmp b, bl
        jg exit

            cmp bh, a 
            jng exit
            cmp bl, bh
            jl exit

                
                mov dl, a
                add dl, 48
                mov ah, 2 
                int 21h

exit:
mov ah, 4ch
int 21h
main endp

; diplay new line
newLine PROC
    push ax
    push dx

    mov dl, 10
    mov ah, 2
    int 21h

    mov dl, 13
    mov ah, 2
    int 21h
    
    pop dx
    pop ax
    ret 
newLine ENDP

end main
