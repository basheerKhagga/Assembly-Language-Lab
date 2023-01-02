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
        mov ah,01h
loop1:
        int 21h
        cmp al,13
        je  next 
        
        mov [si],al
        inc si
        jmp loop1

        next:
        mov al,'$'

        mov [si],al

       mov dx,offset array1
       mov ah,9
       int 21h

        mov ah,4ch
        int 21h

main endp
end main