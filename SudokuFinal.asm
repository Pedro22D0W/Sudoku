.MODEL SMALL
PL  MACRO 

    mov ah,02
    mov dl,10
    int 21h

    
    ENDM

ESPAÇO MACRO
     mov ah,02
    mov dl,32
    int 21h
    ENDM
.stack 100h
.DATA 

msg1 DB "#",0B3H,"1 2 3 4 5 6 7 8 9$"



msg2 db 0C4H,0C5H,18 DUP(0C4H),"$"
msg3 db 0B3H,"$"
msg4 db "selecione as cordenadas:$"
msg5 db "selecione a coluna:$"
msg6 db "selecione a linha:$"
msg7 db "selecione o numero:$"

matriz db 35h,33h,0,0,37h,0,0,0,0
       db 36h,?,?,31h,39h,35h,?,?,?
       db ?,39h,38h,?,?,?,?,36h,?
       db 38h,?,?,?,36h,?,?,?,33h
       db 34h,?,?,38h,?,33h,?,?,31h
       db 37h,?,?,?,32h,?,?,?,36h
       db ?,36h,?,?,?,?,32h,38h,?
       db ?,?,?,34h,31h,39h,?,?,35h
       db 33h,?,?,?,38h,?,?,37h,39h

gabarito db 35h,33h,34h,36h,37h,38h,39h,31h,32h
       db 36h,37h,32h,31h,39h,35h,33h,34h,38h
       db 31h,39h,38h,33h,34h,32h,35h,36h,37h
       db 38h,35h,39h,37h,36h,31h,34h,32h,33h
       db 34h,32h,36h,38h,35h,33h,37h,39h,31h
       db 37h,31h,33h,39h,32h,34h,38h,35h,36h
       db 39h,36h,31h,35h,33h,37h,32h,38h,34h
       db 32h,38h,37h,34h,31h,39h,36h,33h,35h
       db 33h,34h,35h,32h,38h,36h,31h,37h,39h

.CODE 


main PROC

    mov ax,@data
    mov ds,ax
    t:
    call imprimir
    call entrada
    jmp t

    mov ah,4ch
    int 21h
    
main ENDP

imprimir PROC
    mov ax,@data
    mov ds,ax
    xor bx,bx
    xor si,si
    lea bx,matriz
    
    mov ah,09 
    lea dx,msg1
    int 21h
    pl
     mov ah,09 
    lea dx,msg2
    int 21h
    pl
    mov ch,31h
    mov ah,02
    mov dl,ch
    int 21h
    mov ah,09 
    lea dx,msg3
    int 21h

    mov cl,9
    mov di,9
    xor bx,bx
    volta:
    mov ah,02
    mov dl,matriz[bx][si]
    int 21H
    ESPAÇO
    inc si
    dec di
    jnz volta
    PL
    xor si,si
    mov di,9
    add bx,9
    add ch,01h
    cmp ch,3Ah
    je fim
    mov ah,02 
    mov dl,ch
    int 21h
    mov ah,09 
    lea dx,msg3
    int 21h
    loop volta

    fim:
    RET
 
imprimir ENDP

entrada PROC

      
    PL
    mov ah,09 
    lea dx,msg4
    int 21h
    pl
    mov ah,09 
    lea dx,msg5
    int 21h
      
   
      mov si,9
      mov ah,01
      int 21h
      sub al,30h
      dec al
      xor ah,ah
      mov bx,ax
    pl
      mov ah,09 
    lea dx,msg6
    int 21h
    
      mov ah,01
      int 21h
      sub al,30h
      dec al
      mul si
      xor ah,ah
      mov si,ax

    pl
      mov ah,09 
    lea dx,msg7
    int 21h


      mov ah,01
      int 21h

    xor ah,ah
    mov dl,gabarito[bx][si]
    cmp al,dl
    jne fim2
    mov matriz[bx][si],al
    pl
    pl
    RET
    fim2:
    pl
    pl
    mov al,88
    mov matriz[bx][si],al
    RET

    
entrada ENDP
END MAIN
