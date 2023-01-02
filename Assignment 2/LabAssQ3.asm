dosseg
.model small
.stack 100h
.data
ask1 db 'Enter string -> $'
ask2 db 'Enter substring -> $'
res1 db 'Substring $'
res2 db 'Not Substring $'
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
    cmp ax, dx ;ax stores the size of second array
    ja exit

    mov si, offset string
    mov di, offset string
    add di, dx
    mov cx, dx
    mov bh, 0
    dec al ;removing '$' from size
iterate:
    mov bl, [di]
    cmp [si], bl
    jne reset

    inc bh
    cmp bh, al ; will only work for sizes less than 0256d (storage of a byte)
    je exit
    inc si 
    inc di
    jmp endloop

    reset:
    inc si
    mov bh, 0
    mov di, offset string
    add di, dx
    endloop:
    loop iterate

exit:
    cmp bh, al
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
