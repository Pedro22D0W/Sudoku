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
MSG1 DB "#",0B3H,"1 2 3 4 5 6 7 8 9$"


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
    CALL PRINT_MATRIZ
    volta2:
    xor si,si
    xor bx,bx
    mov cl,81
    
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

    volta:
        mov dl,matriz[si]
        mov ah,02
        int 21h
        ESPAÇO
        inc si
        inc bx
        INC DI
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

    mov ah,02 
    mov dl,ch
    int 21h
      mov ah,09 
   
    lea dx,msg3
    int 21h
     cmp CH,39H
    je fim


   

    
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

PRINT_MATRIZ PROC
    RET
PRINT_MATRIZ ENDP
end main



MOV CL, LIN_COL             ; Usado como contador de linhas  
        MOV AH, 02h                 ; Carrega a funcao 02h (Escrita de caracter no STANDARD OUTPUT(monitor))  

        OUT1:                       ;   
            MOV CH, LIN_COL         ; Usado como contador de colunas  
            OUT2:                       ;   
                MOV DL, MATRIZ[BX][SI]  ; Copia a informacao da matriz para DL(entrada padrao para função 02h)  
                OR DL, 30h              ; Converte para caracter
                INT 21h                 ;   
                MOV DL, 20H             ;
                INT 21h                 ; SPACE  
                INC SI                  ; Atualiza o endereço da matriz, deslocando para a proxima coluna  
                DEC CH                  ;   
            JNZ OUT2                ; LOOP1
            MOV DL, 10              ; 
            INT 21h                 ; LINE FEED  
            ADD BX, LIN_COL         ; Desloca uma linha na matriz  
            XOR SI,SI               ; Reseta as colunas
            DEC CL                  ;   
        JNZ OUT1