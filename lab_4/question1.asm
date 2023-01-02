dosseg
.model small
.stack 100h
.data
    var1 DB ?
    var2 DB ?
    var3 DW ?
    var4_a DB ?
    var4_b DB ?
.code
    main proc
    mov ax,@data
    mov ds,ax
    mov dl,'('
    mov ah,2
    int 21h
    mov ah,1
    int 21h
    sub al,48
    mov var1,al
    mov dl,'*'
    mov ah,2
    int 21h
    mov ah,1
    int 21h
    sub al,48
    mov var2,al
    mov dl,')'
    mov ah,2
    int 21h
    mov dl,'+'
    mov ah,2
    int 21h
    xor ax,ax
    mov ah,1
    int 21h
    sub al,48

    mov bl, 1
    mul bl 
    mov var3,ax
    mov dl,'='
    mov ah,2
    int 21h
    mov al,var1
    mul var2
    mov dx,ax
    add dx,var3
    mov ax,dx
    mov bl,10
    div bl
    add al,48
    add ah,48
    mov var4_a,al
    mov var4_b,ah
    mov dl,var4_a
    mov ah,2
    int 21h
    mov dl,var4_b
    mov ah,2
    int 21h
    mov ah,4ch
    int 21h
main endp
end main
    

    
