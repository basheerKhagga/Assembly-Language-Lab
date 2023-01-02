dosseg
.model small
.stack 100h
.data

inputarr db 8 dup(0)
sum db 0
subtraction db 0
multiplication db 0
division db 0

msg1 db 'User Input -> $'
msg2 db 'Printing in descending order -> $'

.code

main proc
mov ax, @data
mov ds, ax
xor ax,ax

mov ax, offset msg1
push ax
call printmsg


mov cx, 8
mov si, offset inputarr
takeinput:
    mov ah, 1
    int 21h
    sub al, 48
    mov [si], al
    inc si
    loop takeinput

call newLine

mov si, offset inputarr
mov cl, [si]
add cl, [si + 1]
mov sum, cl


mov al, [si + 2] 
mul byte ptr [si + 3]
mov multiplication, al

mov cl, [si + 4]
sub cl, [si + 5]
mov subtraction, cl


mov al, [si + 6]
div byte ptr [si + 7]
mov division, al

mov si, offset sum
mov cx, 4
push cx
push si
call Dscorting

mov ax, offset msg2
push ax
call printmsg
call newLine

; registers have same values after returning from Dscorting
push cx
push si
call byteArrayPrinter

mov ah, 4ch
int 21h
main endp


; diplay new line
newLine PROC
    push ax
    push dx

    mov dl, 10
    mov ah, 2
    int 21h

    mov dl, 13
    mov ah, 2
    int 21h
    
    pop dx
    pop ax
    ret 
newLine ENDP

; bubble sort 
; Sorts array in ascending order
; recieves 2-Byte size in stack
; recieves starting array in stack
; removes offset and size on returning
x_offset equ [bp + 4]
y_size equ [bp + 6]
sortArraySize equ 1 ; 1 means byte use 2 for word array
Dscorting PROC
    push bp
    mov bp, sp
    push si
    push cx
    push ax
    push dx
    

    xor ax, ax


;start of outer loop
mov cx, y_size
    outerloop:
        ;start of inner loop
        mov al, 0  ;starting index
        mov ah, cl ; ah = arraysize - 1
        sub ah, 1  ; ^ ending condition  run loop n-1 times
        mov si, x_offset

        ;inner loop
        cmbck:
        cmp al, ah
        jnae innerloop
        
        loop outerloop

pop dx
pop ax
pop cx
pop si
pop bp
ret 4

; inside of innerloop
swap: 
    mov dl, [si + sortArraySize]
    mov [si + sortArraySize], bh
    mov [si], dl 
    jmp comeback

innerloop:
        mov bh, [si]

        ;if greater than perform swap
        cmp bh, [si + sortArraySize]
        jl swap 
        comeback: ;after swap come back

        add si, sortArraySize
        add al, sortArraySize
        jmp cmbck

Dscorting ENDP


; prints an array of size y_size given at x_offset
; x_offset equ [bp + 4]
; y_size equ [bp + 6]
; recieves size in stack
; recieves array offset in stack
; requires array to be of byte size and Values should not be grater than 99 
byteArrayPrinter PROC
    push bp
    mov bp, sp
    push si
    push cx
    push ax
    push dx

    mov si, x_offset 
    mov cx, 0
    cb:
    cmp cl, y_size ; cannot compare with si registers
    jb print

    pop dx
    pop ax
    pop cx
    pop si
    pop bp
    ret 4

    print:
    xor ax, ax
    mov al, [si] 
    mov dh, 10
    div dh
    mov dh, 0
    mov dl, al
    add dl, 48
    push ax
    mov ah, 2
    int 21h
    pop ax
    mov dl, ah
    add dl, 48
    mov ah, 2
    int 21h
    inc si
    inc cx
    call newLine
    jmp cb

    
byteArrayPrinter ENDP

; prints string on console
; gets offset of string in stack 
; removes the input recieved from stack
printmsg PROC
    push bp
    mov bp, sp
    mov bp, [bp + 4]
    push dx
    push ax

        
        mov dx, bp
        mov ah, 9
        int 21h

    pop ax
    pop dx
    pop bp
    ret 2
printmsg ENDP

end main