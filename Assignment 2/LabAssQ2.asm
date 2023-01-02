dosseg
.model small
.stack 100h
.data
ask1 db 'String 1 -> $'
ask2 db 'String 2 -> $'
res1 db 'Equal $'
res2 db 'Not Equal $'

len db 0 ;length of 2d string
string db 0 ;dynamic string at the end of data
.code

main proc
mov ax, @data
mov ds, ax



xor ax, ax
    mov si, offset ask1
    push si

    call printmsg
    mov si, offset string
    ; function call seprator
    push si
    call getString
    push ax ; storing size of first array in stack
    
    add si, ax
    push si
    ; function call seprator
    mov si, offset ask2
    push si
    call printmsg
    
    call getString

    pop dx ; retreiveing size of first array
    mov cx, 2
    cmp ax, dx
    jne exit

    mov si, offset string ; first array
    mov di, offset string
    add di, dx ; second array

    dec si
    dec di

    mov cx, ax
    firstloop:
        cmp cx, 1
        je exit
        inc si
        inc di
        mov dl, [di]
        cmp dl, 'Z'
        jb dxisCapital
        ;if letter in dx is not capital
        cmp dl,  [si]
        loope firstloop
        inc cx
       
        sub dl, 32
        cmp dl, [si]
        loope firstloop
        inc cx
        jmp exit

        dxisCapital:
        cmp dl, [si]
        loope firstloop
        inc cx
        add dl, 32
        cmp dl, [si]
        loope firstloop
        inc cx
        jmp exit


    exit:
    cmp cx, 1
    jne notequal
    mov ax, offset res1
    push ax
    call printmsg
    jmp outof
    notequal:
    mov ax, offset res2
    push ax  
    call printmsg

outof:

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

; ask user for input until enter has pressed
; gets offset of destination string in stack 
; returns size in ax
; removes the input recieved from stack
getString PROC
    push bp
    mov bp, sp
    push si
    push cx
    mov cx, 0
    mov si, [bp + 4]
    

    call newLine
    askagain:
        mov ah, 1
        int 21h
        mov [si], al 
        inc si
        inc cx
        cmp al, 13
        jne askagain

    dec si
    mov [si], byte ptr '$'
    mov ax, cx
    pop cx
    pop si
    pop bp
    ret 2
getString ENDP

end main
