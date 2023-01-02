.model small
.data
        array1    db      5   dup(' '),'$'
.code

main proc
        mov ax,@data
        mov ds,ax
        xor ax, ax

        mov si, offset array1

        mov bl,0
        mov cx, 0
loop1:
        mov ah,01h
        int 21h
        cmp al,13
        je  next 
        
        xor ah, ah
        add cx, 1
        push ax 
        
        jmp loop1

        next:

      mov bl,0
        
loop2:
        
        pop [si]
        inc si
        
        loop loop2

        mov al,'$'
        mov [si],al

       mov dx,offset array1
       mov ah,9
       int 21h

        mov ah,4ch
        int 21h

main endp
end main