.data
    ANO_ALEX:    .word 2005         # ano de nascimento do Alex
    ANO_ROGERIO: .word 2006         # ano de nascimento do Rogério
    ANO_FELIPE:  .word 2005         # ano de nascimento do Felipe
    ANO_LOGAN:   .word 2005         # ano de nascimento do Logan

    msg: .asciiz "Soma dos anos de nascimento: "   # string a ser impressa (terminada em '\0')

.text
.globl main
main:
    # Carregar os anos em registradores
    lw $t0, ANO_ALEX       # $t0 <- 2005
    lw $t1, ANO_ROGERIO    # $t1 <- 2006
    lw $t2, ANO_FELIPE     # $t2 <- 2005
    lw $t3, ANO_LOGAN      # $t3 <- 2005

    # Somar todos (acumular em $t4)
    add $t4, $t0, $t1      # $t4 <- $t0 + $t1  (2005 + 2006 = 4011)
    add $t4, $t4, $t2      # $t4 <- $t4 + $t2  (4011 + 2005 = 6016)
    add $t4, $t4, $t3      # $t4 <- $t4 + $t3  (6016 + 2005 = 8021)

    # Imprimir mensagem (syscall 4 = print string)
    li $v0, 4              # prepara syscall 4 (print string)
    la $a0, msg            # $a0 <- endereço da string a ser impressa
    syscall                # executa imprimir string

    # Imprimir valor da soma (syscall 1 = print integer)
    li $v0, 1              # prepara syscall 1 (print integer)
    move $a0, $t4          # $a0 <- valor inteiro a imprimir (8021)
    syscall                # executa imprimir inteiro

    # Finalizar programa (syscall 10 = exit)
    li $v0, 10
    syscall
