dosseg
.model small
.stack 100h
.data

array1 dw 1,4,3,2,9,8,7,6,0,5


.code
main proc

mov ax, @data
mov ds, ax

xor ax, ax


    mov cx, 10

    outerLoop:
        mov bx, 0

        innerLoop:
            mov ax, array1 + bx
            cmp ax, array1 + bx + 2
            

            jbe noswap

                ;swapping
                mov dx, array1 + bx + 2
                mov array1 + bx + 2, ax
                mov array1 + bx, dx
            
            noswap:
            add bx, 2
            cmp bx, 18
            jne innerLoop

        loop outerLoop
        
        

mov cx, 10
mov bx, -2

do:
add bx, 2
mov dx, array1 + bx
add dx, 48
mov ah, 2
int 21h 

loop do


mov ah, 4ch
int 21h
main endp
end main
