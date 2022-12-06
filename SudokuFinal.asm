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

    mov ax,@data      ;inicializa DS
    mov ds,ax
    t:
    call imprimir     ;chama o procediemnto imprimir para imprimir a matriz(Sudoku) na tela
    call entrada      ;chama o procedimento entrada para o usuario manipular a matriz(Sudoku)
    jmp t

    mov ah,4ch
    int 21h
    
main ENDP

imprimir PROC
    
    xor bx,bx         ;<---- zera SI e BX para iniciar os apontadores da matrix
    xor si,si      
    lea bx,matriz
    
    mov ah,09         ;<---- exibe mensagem de 'colunas' na tela
    lea dx,msg1       
    int 21h

    pl                ;<---- macro de pular linha

     mov ah,09        ;<---- exibe mensagem de barra horizontal na tela
    lea dx,msg2
    int 21h

    pl                ;<---- macro de pular linha

    mov ch,31h        ;<---- exibe numero da linha
    mov dl,ch
    int 21h

    mov ah,09 
    lea dx,msg3       ;<---- exibe mensagem de barra vertical na tela
    int 21h

    mov cl,9          ;<---- inicia contador de linhas e colunas
    mov di,9
    xor bx,bx
    volta:
    mov ah,02         ;<---- exibe numero localizado na posiçao da matriz apontada por SI e BX
    mov dl,matriz[bx][si]
    int 21H

    ESPAÇO            ;<---- macro de espaçamento entre os numeros

    inc si            ;<---- incrementa SI para exibir o proximo numero da linha
    dec di            ;<---- decrementa DI até todos os elementos da linha serem exebidos
    jnz volta         ;<---- quando DI for igual a zero iniciar processo de ir para a proxima linha

    PL                ;<---- macro de pular linha

    xor si,si         ;<---- zera SI para voltar para o primeiro elemento da linha
    mov di,9          ;<---- adiciona o numero de colunas
    add bx,9          ;<---- adiciona em bx o numero de colunas,para ir para proxima linha
    add ch,01h        ;<---- aumenta o numero da coluna em 1
    cmp ch,3Ah        ;<---- checa se o numero da coluna é maior que 9
    je fim            ;<---- se o numero da coluna é maior que 9 pula para o RET

    mov ah,02         ;<---- exibe numero da linha
    mov dl,ch
    int 21h

    mov ah,09         ;<---- exibe mensagem de barra vertical na tela
    lea dx,msg3
    int 21h
    loop volta         ;<---- repete prcesso até serem exibidas todas s linhas

    fim:
    RET
 
imprimir ENDP

entrada PROC

      
    PL                 ;<---- macro de pular linha
    mov ah,09 
    lea dx,msg4        ;<---- exibe mensagem de selecinar cordenadas na tela
    int 21h

    pl                 ;<---- macro de pular linha

    mov ah,09          ;<---- exibe mensagem de selecinar coluna na tela
    lea dx,msg5
    int 21h
      
   
      mov si,9        ;<---- inicia SI com 9 para selecionar a linha correspondente
      mov ah,01       ;<---- função ah1 para o usuario digitar cordenadas da coluna
      int 21h
      and al,0fh      ;<---- transforma caracter em numero 
      dec al          ;<---- decrementa al para cordenadas visualizadas pelo usuario correspondam as da matriz
      xor ah,ah       ;<---- zera ah para enviar somente o conteudo de al para bx
      mov bx,ax       ;<---- move cordenada da coluna selecionada para bx
      
    pl                ;<---- macro de pular linha

      mov ah,09       ;<---- exibe mensagem de selecinar linha na tela
      lea dx,msg6
      int 21h
    
      mov ah,01       ;<---- função ah1 para o usuario digotar cordenadas da linha
      int 21h
      and al,0fh      ;<---- transforma caracter em numero 
      dec al          ;<---- decrementa al para cordenadas visualizadas pelo usuario correspondam as da matriz
      mul si          ;<---- multiplica al por 9 para ir para linha correspondente
      xor ah,ah       ;<---- zera ah para enviar somente o conteudo de al para bx
      mov si,ax       ;<---- move cordenada da linha selecionada para bx

    pl                ;<---- macro de pular linha

    mov ah,09         ;<---- exibe mensagem de selecionar numero
    lea dx,msg7
    int 21h


    mov ah,01         ;<---- seleciona o numero que sera colocado na cordenada escolhida
    int 21h


    mov dl,gabarito[bx][si]   ;<---- move o numero corresponde as cordenadas selecionadas da matriz gabarito para dl
    cmp al,dl                 ;<---- compara o numero selecionado com o numero correto
    jne fim2                  ;<---- se o numero digitado for errado pula para fim2
    mov matriz[bx][si],al     ;<---- se o numero digitado for correto o numero é enviado para matriz

    pl                        ;<---- macro de pular linha
    pl                        ;<---- macro de pular linha

    RET
    fim2:

    pl                        ;<---- macro de pular linha
    pl                        ;<---- macro de pular linha
    
    mov al,88                 ;<---- se o numero digitado for incorreto enviar o caracter "X" para matriz
    mov matriz[bx][si],al
    RET

    
entrada ENDP
END MAIN
