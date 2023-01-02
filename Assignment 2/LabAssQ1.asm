dosseg 
.model small
.stack 100h

.data
array dw 10,9,2
      dw 100,54,100
      dw 1,9,2
      dw 0

row_size db 6
row_index db 0
addition dw 0
msg1 db "Enter the Row Index: $"
msg2 db "Sum of the Required Row is: $"
.code
main proc
mov ax,@data
mov ds,ax
mov ax,0
mov dx,offset msg1
mov ah,9
int 21h

mov ah,1
int 21h 
sub al,48
mov row_index,al
mov bx,offset array
push bx
mov al,row_size
mov ah,0
push ax
mov al,row_index
push ax
mov al,type array
push ax
call calc_row_sum

call newline

call printOuput 




mov ah,4ch
int 21h
main endp

printOuput proc
push dx
push ax
mov dx,offset msg2
mov ah,9
int 21h
pop ax
push ax

mov dx,0
mov cx,0
repeat2:
inc cx
mov dx,0
mov bx,10
div bx
mov bx,ax
add dx,48
push dx
mov ax,bx
cmp ax,0
jne repeat2

print:
pop dx
mov ah,2
int 21h
loop print
pop ax
pop dx
ret
printOuput endp

newline proc
push dx
push ax
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h
pop ax
pop dx
ret
newline endp
calc_row_sum proc
mov bp,sp
push dx
push cx
add bp,8
mov bx,[bp]
sub bp,2
mov cx,[bp]
sub bp,2
mov ax,[bp]
sub bp,2
mov dx,[bp]
mul cl
add bx,ax

mov ax,0
adding:
add ax,[bx]
add bx,dx
sub cx,dx
cmp cx,0
jne adding
mov addition,ax
pop cx
pop dx
ret
calc_row_sum endp
end main