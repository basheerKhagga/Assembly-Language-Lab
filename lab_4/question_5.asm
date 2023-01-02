
;table of 3
dosseg
.model small
.stack 100h
.data
var1 db 3
var2 db 1

msg db '3 * $'
msg2 db ': $' 

var3 db 0
var4 db 0

.code
main proc
Mov ax,@data
Mov ds,ax





mov cl,10 ; inc cl for each iteration

l1:
mov al, 3 ; mov 3 to al each time because multiplication result is stored in ax
mov bl,var2 ; this contains the 1 to 10 iteration



mul bl ; multiply al to bl and store result in ax
mov dx,ax ; moving ax into dx because dx is divided by 10 to get a remainder and quotient for printing
mov bl,10 ; divide dx by bl 
div bl ; divide dx by bl

mov var3,ah
mov var4,al

add var3,48
add var4,48
mov dl,10
mov ah,2
int 21h
Mov dx, offset msg
Mov ah,9
Int 21h
mov dl,var2
add dl,48
mov ah,2
int 21h
Mov dx, offset msg2
Mov ah,9
Int 21h
mov dl,var4
mov ah,2
int 21h
mov dl,var3
mov ah,2
int 21h

add var2, 1
loop l1
mov ah,4ch
int 21h
main endp
end main