.MODEL SMALL
PL  MACRO 

    mov ah,02
    mov dl,10
    int 21h

    
    ENDM
.stack 100h
.DATA 


msg1 db "#|012345678$"
msg2 db "------------$"
msg3 db "|$"
matriz db 35h,33h,0,0,37h,0,0,0,0
       db 36h,?,?,31h,39h,35h,?,?,?
       db ?,39h,38h,?,?,?,?,36h,?
       db 38h,?,?,?,36h,?,?,?,33h
       db 34h,?,?,38h,?,33h,?,?,31h
       db 37h,?,?,?,32h,?,?,?,36h
       db ?,36h,?,?,?,?,32h,38h,?
       db ?,?,?,34h,31h,39h,?,?,35h
       db ?,?,?,?,38h,?,?,37h,39h

.CODE 


main PROC
    mov ax,@data
    mov ds,ax
    mov es,ax
    lea SI,matriz
    volta2:
    xor si,si
    xor bx,bx
    mov cl,73
    
    mov ah,09 
    lea dx,msg1
    int 21h
    pl
     mov ah,09 
    lea dx,msg2
    int 21h
    pl
    mov ch,30h
    mov ah,02
    mov dl,ch
    int 21h
    mov ah,09 
    lea dx,msg3
    int 21h
    volta:
    
    mov dl,matriz[si]
    mov ah,02
     int 21h
    inc si
    inc bx
    cmp cx,1
    je fim
    cmp bx,9
    je pl1
    loop volta
    jmp fim
    pl1:
    PL
    add ch,01h
    xor bx,bx
    cmp ch,39h
    je fim
    mov ah,02 
    mov dl,ch
    int 21h
      mov ah,09 
    lea dx,msg3
    int 21h


   

    
    jmp volta

    
    
   

    



    fim:
    pl
    pl
   
      xor si,si
      xor bx,bx

      mov bl,9
      mov ah,01
      int 21h
      sub al,30h
      mul bl
      mov bl,al

      mov ah,01
      int 21h
      sub al,30h
      xor si,si
      xor ah,ah
      mov si,ax

      mov ah,01
      int 21h

    xor ah,ah
    mov matriz[bx][si],al
    pl
    jmp volta2
   

   

    

    mov ah,4ch
    int 21h


    
main ENDP
end main
