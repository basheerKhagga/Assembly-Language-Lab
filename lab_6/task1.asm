dosseg
.model small
.stack 100h
.data
multiplicant db '5'
counter db 49
a1 db ?
b1 db ?
.code
main proc
mov cx,10
mov ax,@data
mov ds,ax

L1:
    ; print '5'
    mov dl, multiplicant
    mov ah,2
    int 21h
        ;print space
        mov dl,' '
        mov ah,2
        int 21h
    ;print '*'
    mov dl, '*'
    mov ah,2
    int 21h
        ;print space
        mov dl,' '
        mov ah,2
        int 21h
    ; counter from  0 to 10
    mov dl, counter
    mov ah,2
    int 21h
        ;print space
        mov dl,' '
        mov ah,2
        int 21h
    ;print '='
    mov dl, '='
    mov ah,2
    int 21h
    ;print '>'
    mov dl, '>'
    mov ah,2
    int 21h
        ;print space
        mov dl,' '
        mov ah,2
        int 21h
mov al,multiplicant
sub al,48
mov bl,counter
sub bl,48
mul bl
mov bl,10
div bl
mov a1,al
mov b1,ah
mov dl,a1
add dl,48
mov ah,2
int 21h
mov dl,b1
add dl,48
mov ah,2
int 21h
inc counter
mov dl,10
mov ah,2
int 21h
loop L1

mov ah,4ch
int 21h
main endp
end main