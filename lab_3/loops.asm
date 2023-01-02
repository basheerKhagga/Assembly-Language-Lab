;program to print from 0 to 9
dosseg
.model small
.stack 100h
.data

.code

main proc

    mov cl, 10
    

    L1:
    mov dl, cl
    add dl, 47
    mov ah, 2+lk
    int 21h
    loop L1

         mov ah, 4ch
         int 21h
main endp
end main

