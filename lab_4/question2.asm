;two numbers are equal or not

dosseg
.model small
.stack 100h
.data
var1 BYTE ?
var2 BYTE ?

Msg1 db 'numbers are equal$'
Msg2 db 'numbers are not equal$'
.code
main proc
Mov ax,@data
Mov ds,ax


mov ah, 1
int 21h

mov var1, al
Mov dl,al
Mov ah,1
Int 21h


mov var2, al
Cmp dl,al
Je l1
    Mov dx, offset Msg2
    Mov ah,9
    Int 21h
Mov ah,4ch
Int 21h
l1:
mov dx, offset Msg1
mov ah,9
int 21h
mov ah,4ch
int 21h
main endp
end main