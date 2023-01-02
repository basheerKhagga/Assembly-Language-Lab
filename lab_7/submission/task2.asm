dosseg
.model small
.stack 100h
.data
    a1   db ?
    b1   db ?
    c1   db ?
.code
main proc
            mov ax,@data
            mov ds,ax
            mov dl, 10
            mov bl, 0

    nextdig:                ;

            mov ah, 01h
            int 21h

            cmp al, 13
            je  next

            mov ah, 0
            sub al, 48

            mov cl, al
            mov al, bl

            mul dl

            add al, cl
            mov bl, al

            jmp nextdig
    next:   

    ;mov al,bl
             
    ;SUB BL, 48

            MOV AH, 1       ; read a character
            INT 21H

            MOV BH, bL      ; save Second digit in BH in ASCII CODE
    ;SUB BH, 30H


    ;ADD BL, BH                   ; add First and Second digit
    ;mov al,bl
            sub al,48
            mov cl,bh
            mul cl
            mov bl,10
            div bl
            mov bh,ah

            mov bl,1
            mul bl

            mov bl,10
            div bl
            mov a1,al
            mov b1,ah
            mov c1,bh
            
            mov dx,13
            mov ah,2
            int 21h
            mov dx,10
            mov ah,2
            int 21h
            mov dl,a1
            add dl,48
            mov ah,2
            int 21h
            mov dl,b1
            add dl,48
            mov ah,2
            int 21h
            mov dl,c1
            add dl,48
            mov ah,2
            int 21h

            mov ah,4ch
            int 21h
main endp
end main