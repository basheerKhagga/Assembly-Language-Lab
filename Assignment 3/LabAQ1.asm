;blind game
dosseg
.model small
.stack 100h
.data

input db 0
msg db 'Random input -> $'
msg2 db 'User input -> $'
success db 'W$'
F db 'F$'
L db 'L$'

.code

main proc
mov ax, @data
mov ds, ax

mov si, offset msg
push si
call newLine
call printmsg

; get input 
mov ah, 7
int 21h

mov bl, al ; bl contains user input


mov cx, 3

game:
    mov si, offset msg2
    push si
    call newLine
    call printmsg
    mov ah, 1
    int 21h
    cmp bl, al
    je WExit
    cmp cx, 1
    je exit ; exit program
    
    ; print f and iterate again
    mov si, offset F
    push si
    call newLine
    call printmsg 
    loop game
    
; exit program after printing L
exit:
mov si, offset L
push si
call newLine
call printmsg 
mov ah, 4ch
int 21h

; exit program after printing W
WExit:
    mov si, offset success
    push si
    call newLine
    call printmsg 
    mov ah, 4ch
    int 21h


main endp

; diplay enter
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

; gets offset of string in stack 
; prints string on console
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
