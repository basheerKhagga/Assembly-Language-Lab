dosseg
.model small
.stack 100h
.data
 Var1 dw 8
Var2 dw 7
quo db ?
rem db ?

.code

main proc
mov ax, @data
mov ds, ax

; mov ah, 1
; int 21h


; mov Var1, al
; sub var1, 48
; mov dx, var1
; mov ah, 2
; int 21h


; mov ah, 1
; int 21h

; mov Var2, al
; sub var2, 48
mov ax, Var1
add ax, Var2
; sub ax, 48
; sub ax, 48

; mov dx, ax
; mov ah, 2
; int 21h
; mov ax, al
mov bl, 10
div bl ; quotient goes in al while rem in ah
mov quo , al
mov rem, ah



mov dl, quo
add dl, 48
mov ah, 2
int 21h


mov dl, rem
add dl, 48
mov ah, 2
int 21h

; mov al, 5
; mov bl, 6
; mul bl ; multiply al and bl
; AAM
; mov ch, ah
; mov cl, al

; mov dl, ch
; add dl, 48
; mov ah, 2
; int 21h


; mov dl, cl
; add dl, 48
; mov ah, 2
; int 21h

mov ah, 4ch
int 21h
main endp
end main
