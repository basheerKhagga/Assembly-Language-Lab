.model small
.stack 100h
.data
.code
main proc
mov ah, 00h
mov al, 012h ;using 480p res 
int 10h
keepgoing:
mov ax, 1
int 33h
mov ax, 3
int 33h
mov ah, 0ch
mov al, 0fh
mov bh, 0h
int 10h
mov ax, 4
int 33h
mov ax, 5
mov bx, 0
int 33h
cmp ax, 1
jne keepgoing

mov AH,4Ch
int 21h
main endp
end main