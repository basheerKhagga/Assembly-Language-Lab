
; Print characters from A to Z
dosseg
.model small
.stack 100h

.data

.code

main proc
mov cl,26
mov dl,65


l1:
mov ah,2
int 21h

inc dl
loop l1

mov dl, 13
mov ah, 2
int 21h

mov dl, 10
mov ah, 2
int 21h

xor cx, cx
xor dx, dx


mov cl, 26
mov dl, 91

l2:
sub dl, 1


mov ah, 2
int 21h

loop l2


mov ah,4ch
int 21h

main endp

end main