title Pedro Rodolfo Silva Galvão Santos(22886287) Luis Guilherme Pilotto de Menezes Regu(22013635)
.MODEL SMALL


MM MACRO               ;<---- macro para trocar a dificuldade.

    lea si,matriz2 
    lea di,matriz 
    mov cx,81
    volta1:
    movsb 
    loop volta1

    ENDM
    
MG MACRO                ;<---- macro para trocar o gabarito da dificuldade escolhida.

    lea si,gabarito2 
    lea di,gabarito  
    mov cx,81
    volta2:
    movsb 
    loop volta2
   
    ENDM

PL  MACRO               ;<---- macro para pular linha

    mov ah,02
    mov dl,10
    int 21h

    ENDM

ESPAÇO MACRO            ;<---- macro para dar um ESPAÇO

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
msg8 db "selecionar dificuldade:$"
msg9 db "facil-1$"
msgA db "dificil-2$"
msgB db "VOCE GANHOU!!!!!!!!$"
msgC db "COMO JOGAR:",10,"apos selecionar a dificuldade o jogador devera escolher as cordenadas de coluna e linha,depois digitar o numero que ira para aquela posicao na matriz,se o numero estiver correto ele aparecera na matriz se estiver incorreto um X aparecera nolugar$"

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

matriz2 db 38h,37h,?,?,39h,?,?,35h,32h
        db ?,?,?,?,?,?,?,?,?
        db 33h,?,39h,?,38h,?,?,?,?
        db ?,?,?,37h,?,39h,34h,?,?
        db ?,35h,?,?,33h,?,39h,?,?
        db ?,?,38h,36h,35h,?,?,33h,37h
        db ?,38h,32h,?,?,?,35h,37h,?
        db ?,34h,?,?,32h,?,36h,?,38h
        db 36h,?,?,31h,?,?,33h,?,34h

       

     

gabarito2 db 38h,37h,34h,33h,39h,36h,31h,35h,32h
          db 35h,36h,31h,32h,34h,37h,38h,39h,33h
          db 33h,32h,39h,35h,38h,31h,37h,34h,36h
          db 32h,33h,36h,37h,31h,39h,34h,38h,35h
          db 34h,35h,37h,38h,33h,32h,39h,36h,31h
          db 39h,31h,38h,36h,35h,34h,32h,33h,37h
          db 31h,38h,32h,34h,36h,33h,35h,37h,39h
          db 37h,34h,33h,39h,32h,35h,36h,31h,38h
          db 36h,39h,35h,31h,37h,38h,33h,32h,34h
            
.CODE 
main PROC

    lea bx,matriz
    mov ax,@data      
    mov ds,ax        ;<---- inicializa DS
    mov es,ax        ;<---- inicializa ES

    mov ah,09        ;<---- exibe mensagem de 'instruções' na tela
    lea dx,msgC
    int 21h
    pl
    pl

    mov ah,09        ;<---- exibe mensagem de 'dificuldade' na tela
    lea dx,msg8
    int 21h
    pl               ;<---- macro de espaçamento entre os numeros
    mov ah,09        ;<---- exibe mensagem de 'facil-1' na tela
    lea dx,msg9
    int 21h
    ESPAÇO           ;<---- macro de espaçamento entre os numeros
    ESPAÇO           ;<---- macro de espaçamento entre os numeros
    mov ah,09        ;<---- exibe mensagem de 'dificil-2' na tela
    lea dx,msgA
    int 21h
    pl               ;<---- macro de espaçamento entre os numeros

    mov ah,01        ;<---- entrada da dificuldade, o usuario escolhe
    int 21h
    mov bh,al
    pl               ;<---- macro de pular linha
    pl               ;<---- macro de pular linha
    
    cmp bh,32h       ;<---- verifica a dificuldade, se for dificil (2) ele não entra no jne 
    jne pula
    
    MM               ;<---- macro para trocar a dificuldade.
    MG               ;<---- macro para trocar o gabarito da dificuldade escolhida.
   
    pula:
    t:
    mov ax,3
    int 10h
    call imprimir    ;<---- chama o procediemnto imprimir para imprimir a matriz(Sudoku) na tela
    call entrada     ;<---- chama o procedimento entrada para o usuario manipular a matriz(Sudoku)
    lea si,matriz    ;<---- aponta matriz
    lea di,gabarito  ;<---- aponta gabarito
    cmpsb            ;<---- compara matriz e gabarito, retornando ZF
    jz t              
    pl               ;<---- macro de pular linha
    call imprimir    ;<---- chama a funçao mais uma vez de imprimir

    mov ah,09        ;<---- exibe a mensagem de VITORIA
    lea dx,msgB
    int 21h

    mov ah,4ch       ;<---- finaliza o programa
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