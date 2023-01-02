dosseg
.model small
.stack 100h
.data
getsize db 'Input size of array -> $'
len db 0 ;length of 2d string
string db 0 ;dynamic string at the end of data


.code
main proc
mov ax, @data
mov ds, ax

; get size from user
mov si, offset getsize
push si
call printmsg
mov ah, 1
int 21h
xor cx,cx
sub al, 48
mov cl, al
mov len, cl
call newLine
;--------------------------------



xor ax, ax
mov si, offset string
mov bp, sp
getAllElements:
    add si, ax
    push si
    ; function call seprator
    push si
    call getString
    loop getAllElements


mov si, sp ; si contains end address of pointer array to be sorted in stack
mov cl, len
getAllPrec:
    sub bp, 2 ; pointer to address array stored in stack
    push [bp]
    call calStrprec
    push ax
    loop getAllPrec

mov bp, sp
push bp
call hashMapSorting


mov cl, len
l3:
    pop ax
    ; call printmsg
    ; add bp, 2
    loop l3

mov bp, si ; si contains stack's address of sorted address array 
call swapStrArrays

call newLine

xor cx, cx
mov cl, len
mov si , offset string
push cx
push si
call printer

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


; calculate precedence of ascii string
; gets offset of string terminated by $
; returns precedence in ax
; removes input recieved from stack
calStrprec PROC
    push bp
    mov bp, sp
    push dx
    push bx
    push cx
    mov bx, [bp + 4]


    xor cx, cx
    mov dx, 1

calnextbyte:
    cmp byte ptr [bx], '$' ;cmp before to see if first value is the end of string
    je exitcalStrprec
    mov ax, dx
    mul byte ptr [bx]
    add cx, ax
    inc dx
    inc bx
    jmp calnextbyte
    
    exitcalStrprec:
    mov ax, cx
    pop cx
    pop bx
    pop dx
    pop bp
    ret 2
calStrprec ENDP

; Sort two arrays in stack -> An array of precedence and An array of thier addresses accordingly
; recieves an array 
hashMapSorting PROC
    push bp
    mov bp, sp
    mov bp, [bp+4]
    push cx
    push ax
    push bx
    push dx
    xor ax, ax


;start of outer loop
push si
push bp

mov cl, len 
    outerloop:
        ;start of inner loop
        mov al, 0  ;starting index
        mov ah, cl ; ah = arraysize - 1
        sub ah, 1  ; ^ ending condition  run loop n-1 times
        pop bp  ; reset bp every time for outer loop
        pop si
        push si
        push bp
        
        ;inner loop
        cmbck:
        cmp al, ah
        jnae innerloop
        

        loop outerloop
pop bp
pop si

    pop dx
    pop bx
    pop ax
    pop cx
    pop bp
    ret 2

    ; inside of innerloop
swap: 
    mov dx, [bp + 2]
    mov [bp + 2], bx
    mov [bp], dx 

    ;store bp on stack temporarily
    push bp
    mov bp, si    ; swap addresses with their precedence values
    mov bx, [bp]
    mov dx, [bp + 2]
    mov [bp + 2], bx
    mov [bp], dx
    pop bp
    jmp comeback

innerloop:
        mov bx, [bp]

        ;if greater than perform swap
        cmp bx, [bp + 2]
        ja swap 
        comeback: ;after swap come back

        add bp, 2
        add si, 2 ; iterator for 2d pointer array in hashmap
        inc al
        jmp cmbck
hashMapSorting ENDP

; swap values an array in stack with an array in .data
; recieves an array of pointers in bp through which values have to be swapped 
; The destination array is global
; returns nothing Does not delete the parameters from stack
swapStrArrays  PROC
    push bp
    ; mov bp, sp
    push si
    push bx
    push dx
    push cx
    ; add bp, 4

    mov dx, sp ; contains starting address of stack where values will start from

    ; loop to push all values from global array to stack
    mov cl, len
    pushvalues:
        mov si, [bp]

        pushtostack:
            cmp [si], byte ptr '$'
            je pushed
            push [si]
            inc si
            jmp pushtostack


            pushed:
            push [si]


        add bp, 2
        loop pushvalues

    mov bp, dx
    sub bp, 2 ; move bp to sorted values in stack
    mov si, offset string
    xor cx, cx
    mov cl, len 
    ; the global array is updated through values pushed in stack
go:
        mov bl, [bp]
        mov [si], bl
        cmp bl, '$'
        je nextIteration
        inc si
        sub bp, 2
        jmp go
        nextIteration:
        inc si
        sub bp, 2
        loop go
    
    ; mov bp, dx
    mov sp, dx
    pop cx
    pop dx
    pop bx
    pop si
    pop bp
    ret 
swapStrArrays  ENDP

; print a 2d string array based on $ and size
; recieves address of 2d and size in stack
; removes parameters from stack
; requires each array to end with $
x_offset equ [bp + 4]
y_size equ [bp + 6]
printer PROC
    push bp
    mov bp, sp
    push si
    push cx
    push ax
    push dx
    mov si, x_offset
    mov cx, y_size

    nextString:
        mov dl, [si]
        inc si
        cmp dl, '$'
        je AStringEnded ; first value can be '$' so cmp at start
        mov ah, 2
        int 21h
        jmp nextString
        AStringEnded:
        call newLine
        loop nextString

    pop dx
    pop ax
    pop cx
    pop si
    pop bp
    ret 4
printer ENDP

end main
