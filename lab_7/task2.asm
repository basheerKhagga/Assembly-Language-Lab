dosseg
.model small
.stack 100h
.data

num1 db 0
num2 db 0
result dw  0
msg1 db 'input 2 digits $'
msg2 db 'input another 2 digits $'


.code

main proc
mov ax, @data
mov ds, ax

mov dx, offset msg1
mov ah, 9
int 21h
;print enter
mov dl, 13
mov ah, 02h
int 21h
mov dl, 10
mov ah, 02h
int 21h
xor dx, dx
xor ax, ax

;input tenth of the 2 digit number
mov ah, 01h
int 21h
xor ah, ah
sub al, 48
mov bl, 10
mul bl ;multiplying by 10

mov num1, al

;input unit of the 2 digit number
mov ah, 01h
int 21h
xor ah, ah
sub al, 48

add num1, al

; \\\\\\\\\\\\\\\\\\\\\\\\\\ input 2nd 2 digit number
;print enter
mov dl, 13
mov ah, 02h
int 21h
mov dl, 10
mov ah, 02h
int 21h
mov dx, offset msg2
mov ah, 9
int 21h
;print enter
mov dl, 13
mov ah, 02h
int 21h
mov dl, 10
mov ah, 02h
int 21h
xor dx, dx
xor ax, ax

;input tenth of the 2 digit number
mov ah, 01h
int 21h
xor ah, ah
sub al, 48
mov bl, 10
mul bl ;multiplying by 10

mov num2, al

;input unit of the 2 digit number
mov ah, 01h
int 21h
xor ah, ah
sub al, 48

add num2, al

;print enter
mov dl, 13
mov ah, 02h
int 21h
mov dl, 10
mov ah, 02h
int 21h

mov al, num1
mov bl, num2
mul bl



;result is in ax
mov result, ax
mov bl, 10
div bl


; calculate last digit
mov dl, ah
add dl, 48
mov cl, dl


;divide for 2 digits
xor ah, ah
mov bl, 10
div bl
mov ch, ah 

; print 3rd last digit
mov dl, al
add dl, 48
mov ah, 02h
int 21h

; print 2nd last digit
mov dl, ch
add dl, 48

mov ah, 02h
int 21h

; print last digit
mov dl, cl
mov ah, 02h
int 21h

mov ah, 4ch
int 21h
main endp


end main
