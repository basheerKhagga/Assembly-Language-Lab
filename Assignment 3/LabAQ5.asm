dosseg
.model small
.stack 100h
.data


msg1 db 'User Input -> $'
.code

main proc
mov ax, @data
mov ds, ax

mov ax, offset msg1
push ax
call printmsg

mov ah, 1
int 21h
xor ah, ah
sub al, 48


call newLine
mov bx, 1
push ax
call diamond   


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

; recursive diamond fucntion 
; recieves input in stack
; requires bx to have 1 
x_input equ [bp + 4]
diamond PROC
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    ; base condition
    cmp byte ptr x_input, 1
    jg recurse
        ; prints the middle line of diamond before exiting
        mov cx, bx
        first:
            call asterik
            loop first
        call newLine

    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 2

    recurse:
    ; result of division remain in al through out
    mov ax, x_input
    mov dl, 2
    div dl
    ; loop for spaces
    xor cx, cx
    mov cl, al
    secnd:
        call space
        loop secnd
    ;loop for asteriks while going towards base condition
    mov dl, 0
    thrd:
        call asterik    
        inc dl
        cmp dl, bl
        jl thrd
    add bx, 2
    push dx
    ; new line called after every complete diamond line
    call newLine
    
    mov dx, word ptr x_input
    sub dx, 2
    push dx
    call diamond

    ;loop for spaces while returning
    pop dx
    mov cl, al
        frth: 
            call space
            loop frth

    ;loop for asteriks while returning
    xor cx, cx
    mov cl, dl 
    fifth:
        call asterik
        loop fifth     

    call newLine


    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 2
diamond ENDP

; prints a single space without changing registers
space PROC
    push ax
    push dx

    mov dl, ' '
    mov ah, 2
    int 21h

    pop dx
    pop ax
    ret
space ENDP

; prints a single asterik without changing registers
asterik PROC
    push ax
    push dx

    mov dl, '*'
    mov ah, 2
    int 21h

    pop dx
    pop ax
    ret
asterik ENDP

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
