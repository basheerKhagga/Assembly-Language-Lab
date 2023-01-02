.model small
.stack 100h
.data
promptX db 'X-axis: ', '$'
promptY db 'Y-axis: ', '$'

xcoor dw 0
ycoor dw 0
count db 0
.code
main proc
mov ax, @data
mov ds, ax
mov ah, 00h
mov al, 13h 
int 10h
keepgoing:
mov ax, 1  ;displaying mouse
int 33h
mov ax, 3  ; don't know about this yet
int 33h
mov xcoor, cx 
mov ycoor, dx
mov ax, 4
int 33h
lea dx, promptX
mov ah, 09
int 21h
mov ax, xcoor
call output1
lea dx, prompty
mov ah, 09
int 21h
mov ax, ycoor
call output1
mov cx, 0000h
mov dx, 0fffh
mov ah, 86h
int 15h
mov ah, 00h
mov al, 13
int 10h
mov ax, 5
mov bx, 0
int 33h
cmp ax, 1
jne keepgoing
mov AH,4Ch
int 21h
main endp

output1 proc
mov count, 0
continuepushing:
mov DX, 0
mov BX, 10
div BX
push DX
inc count
cmp AX, 0
jne continuepushing
continuepopping:
pop DX
add DX, 48
mov AH, 02h
int 21h
dec count
cmp count,0
jne continuepopping
stoppopping:
mov DX, 10
mov AH, 02
int 21h
ret
output1 endp
end main