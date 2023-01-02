.model small
.stack 100h
.data
prompt1 db 'Mouse not connected!', '$'
prompt2 db 'Mouse connected, Number of Buttons: ', '$'
.code
main proc
mov ax, @data
mov ds, ax
mov ax, 0
int 33h
cmp ax, 0
jne exit
lea dx, prompt1

mov ah, 09
int 21h
jmp end1
exit:
lea dx, prompt2
mov ah, 09
int 21h
mov dl, bl
add dl, 48
mov ah, 02
int 21h
mov ah, 00h
mov al, 13  
int 10h
mov ax, 1
int 33h
mov cx, 100
mov dx, 100
mov ax, 4
int 33h

end1:
mov AH,4Ch
int 21h
main endp
end main