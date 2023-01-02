;introduction to variables
dosseg
.model small
.stack 100h

.data
    Var1 Byte 1
    Var2 Byte ?
    ; Var3 db 'abcd$'
    ; msg db 'mai shapper hu$'
.code
main proc
        ;  mov ax, @data
        ;  mov ds, ax

         mov cl, 48
         mov Var1, cl
        ;  mov cl, Var1
        ;  add Var2, cl
        ;  add var2, 48
         mov dl, Var1

         mov ah, 2
         int 21h



    ;lea dx, Var3
    ;mov ah, 9
    ;int 21h

        ;  mov ah,13
        ;  int 21h
        ;  mov ah,10
        ;  int 21h

    ;lea dx, msg
    ;mov ah, 9
    ;int 21h

         mov ah, 4ch
         int 21h
main endp
end main
