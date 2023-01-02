.model small
.stack 100h
.data
.code

main proc
mov ah, 00h ; video mode
mov al, 13
int 10h
mov ax, 1 ; Toggle mouse hide/unhide
int 33h
mov cx, 607 ; x-position
mov dx, 170 ; y-position
mov ax, 4
int 33h
mov AH,4Ch
int 21h
main endp
end main