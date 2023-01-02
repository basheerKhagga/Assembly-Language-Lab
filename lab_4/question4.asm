
;determine even or odd
dosseg
.model small
.stack 100h
.data

Msg1 db 'number is even$'
Msg2 db 'number is odd$'

.code

main proc

Mov ax,@data
Mov ds,ax

xor ax, ax
mov ah, 1
int 21h

mov bl, 2
div bl

cmp ah, 0

je l1


Mov dx, offset Msg2
    Mov ah,9
    Int 21h
mov ah, 4ch
int 21h



l1:
mov dx, offset Msg1
mov ah,9
int 21h

mov ah, 4ch
int 21h
main endp
end main
