dosseg
.model small
.stack 100h
.data
string1 db 'ustaad$'
string2 db ' shapper$'
.code

main proc

mov dx, @data
mov ds, dx

mov dx, offset string1
mov ah, 9 ; print string
int 21h

mov dl, 10 ; new line feed
mov ah, 2 
int 21h     
mov dl, 13 ; carriage return
mov ah, 2 
int 21h

lea dx, string2
mov ah, 9 ; print string
int 21h



mov ah, 4ch
int 21h
main endp
end main
