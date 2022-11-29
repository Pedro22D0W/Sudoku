.MODEL SMALL
PL  MACRO 

    mov ah,02
    mov dl,10
    int 21h

    
    ENDM
.DATA 

matr1 DB 35h,33h,?
      db 36h,35h,?
      db ?,39h,38h

matr2 db ?,37h,?
      db 31h,39h,35h
      db ?,?,?

matr3 db ?,?,?
      db ?,?,?
      db ?,36h,?

matr4 db 38h,?,?
      db 34h,?,?
      db 37h,?,?

matr5 db ?,36h,?
      db 38h,?,33h
      db ?,32h,?

matr6 db ?,?,33h
      db ?,?,31h
      db ?,?,36h

matr7 db ?,36h,?
      db ?,?,?
      db ?,?,?
         
matr8 db ?,?,?
      db 34h,31h,39h
      db ?,38h,?

matr9 db 32h,38h,?
      db ?,?,35h
      db ?,37h,39h

.CODE


main PROC
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    mov bx,1
    mov si,3

    
    mov dl,matr1[bx][si]
    mov ah,02
    int 21h
    
   

    




    mov ah,4ch
    int 21h


    
main ENDP
end main
