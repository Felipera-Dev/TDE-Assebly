.data
lista_inicial: .asciiz "Lista inicial: "
lista_ordenada: .asciiz "\nLista ordenada: "
virgula: .asciiz "," 
lista:  .word 4, 3, 9, 5, 2, 1    
len:    .word 6                   # tamanho da lista

.text
.globl main
main:
    # print da lista sem ordenar
    li $v0, 4              
    la $a0, lista_inicial    # Carrega o endereço da mensagem inicial
    syscall

    # print da lista inicial
    li $t1, 0              # criando o índice i = 0
    la $t2, lista          

print_lista_inicial:
    bge $t1, 6, continuar_ordenacao   # se i >= len (6), termina de printar os numeros e vai para a ordenação
    lw $a0, 0($t2)                 # valor lista[i]
    li $v0, 1                      
    syscall
	
    li $v0, 4                      # print das virgulas entre os numeros
    la $a0, virgula
    syscall

    addi $t2, $t2, 4                
    addi $t1, $t1, 1                # i + 1
    j print_lista_inicial       

continuar_ordenacao:
    la $a1, lista         
    jal ordenar  # chama a função ordenar

    # print da lista ordenada
    li $v0, 4              
    la $a0, lista_ordenada   # endereço da mensagem de lista ordenada
    syscall

   
    li $t1, 0              # i = 0
    la $t2, lista          # o endereço da lista

print_lista_ordenada:
    bge $t1, 6, end        # se i >= len (6), termina o programa
    lw $a0, 0($t2)         # Carrega o valor lista[i]
    li $v0, 1              # Syscall para imprimir inteiro
    syscall

    li $v0, 4              # colocando a virgula entre os numeros
    la $a0, virgula
    syscall

    addi $t2, $t2, 4       
    addi $t1, $t1, 1       # i + 1
    j print_lista_ordenada

end:
    li $v0, 10             
    syscall

ordenar:
    li $t0, 1              # verifica se houve algum numero trocou de lugar com outro
    la $t7, len           
    lw $t7, 0($t7)         # pega o tamanho da lista

while:
    bne $t0, 1, end_while  # se não teve troca, sai do while
    li $t0, 0              # reinicia a verificacao de troca
    move $t1, $zero        # i = 0

for:
    mul $t2, $t1, 4        # t2 = i * 4;calula o offset: distância em bytes(4bytes) entre o início de uma área de memória e o elemento que você quer acessar.
    add $t2, $t2, $a1      # t2 = endereço de lista[i]
    lw $t3, 0($t2)         # t3 = lista[i]

    addi $t4, $t1, 1       # t4 = i + 1
    mul $t5, $t4, 4        # t5 = (i + 1) * 4 / mesma coisa do inicio
    add $t5, $t5, $a1      # t5 = endereço de lista[i + 1]
    lw $t6, 0($t5)         # t6 = lista[i + 1]


    slt $t8, $t3, $t6      # se(lista[i] < lista[i+1]){ t8 = 1 } else{t8 = 0}
    beq $t8, 1, end_for     # se t8 = 1 ele termina o for

    # troca os valores de lista[i] e lista[i+1]
    li $t0, 1              # avisando que houve troca
    sw $t6, 0($t2)         # lista[i] = lista[i+1]
    sw $t3, 0($t5)         # lista[i+1] = lista[i]

end_for:
    addi $t1, $t1, 1       #  i++

    # verificacao  para continuar o for
    sub $t9, $t7, $t1      # t9 = len - i
    bgtz $t9, for          # se i < len - 1, repete o for,pois ainda nao chegou no final da lista

    j while                # reinicia while

end_while:
    jr $ra                 # retorna de ordenar


