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

matriz db 35h,33h,0,0,37h,0,0,0,0
       db 36h,?,?,31h,39h,35h,?,?,?
       db ?,39h,38h,?,?,?,?,36h,?
       db 38h,?,?,?,36h,?,?,?,33h
       db 34h,?,?,38h,?,33h,?,?,31h
       db 37h,?,?,?,32h,?,?,?,36h
       db ?,36h,?,?,?,?,32h,38h,?
       db ?,?,?,34h,31h,39h,?,?,35h
       db 31H,?,?,?,38h,?,?,37h,39h

.CODE 


main PROC
    mov ax,@data
    mov ds,ax
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
    pl
    pl
 

   

    

    mov ah,4ch
    int 21h


    
main ENDP
END MAIN


        mov dl,matriz[si]
        mov ah,02
        int 21h
        ESPAÇO
        inc si
        inc bx
        cmp cx,1
        je fim
        cmp bx,9
        je pl1
         cmp DI,10
         je fim
    loop volta

    jmp fim
    pl1:
    PL
    add ch,01h
    xor bx,bx
    cmp ch,3Ah
    je fim
    mov ah,02 
    mov dl,ch
    int 21h
    mov ah,09 
    lea dl,msg3
    int 21h
  


   

    
    jmp volta

