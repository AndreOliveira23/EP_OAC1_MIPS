.data
	vetorA: .space 12
	delimitador: .asciiz " "
	abreColchetes: .asciiz "["
	fechaColchetes: .asciiz "]"
	printVetorA: .asciiz "Vetor A: "
	
	vetorB: .space 20
	printVetorB: .asciiz "Vetor B: "
	
	quebraLinha: .asciiz "\n"
	
	estaContido: .asciiz "O vetor A está contido no vetor B"
	naoEstaContido: .asciiz "O vetor A não está contido no vetor B"
	
.text 
	
	#Coloca valores no vetor A
	addi $s0,$zero,1
	addi $s1,$zero,2
	addi $s2,$zero,3
	
	#Atribui zero ao registrador t0 para usar como índice
	addi $t0,$zero, 0
	
	sw $s0, vetorA($t0) #adiciona $s0 na primeira posição do vetorA
	  addi $t0,$t0,4 #adiciona 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s1,vetorA($t0) #adiciona $s1 na segunda posição do vetor A (deslocamento de 4 bytes)
	  addi $t0,$t0,4 #adiciona mais 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s2,vetorA($t0) #adiciona $s2 na terceira posição do vetor A
	  
	addi $t0,$zero,0 #reinicia $t0
	
	
	#Printando "vetor A"
	li $v0, 4
	la $a0, printVetorA
	syscall
	
	#printando "["
	li $v0, 4
	la $a0, abreColchetes
	syscall
	
	while:
		beq $t0,12,exit #if ($t0 == 12) { exit}
		
		lw $t6,vetorA($t0) #carregando o primeiro elemento do vetor A no registrador $t6 
		
		addi $t0,$t0,4
		
		#printando valor atual
		li $v0,1 #preparando syscall
		move $a0,$t6 #movendo valor de $t6 para $a0
		syscall 
		
		#Printando espaço em branco para separar valores
		li $v0, 4
		la $a0, delimitador
		syscall
		
		
		j while
	exit:
		#printando "]"
		li $v0, 4
		la $a0, fechaColchetes
		syscall
		
		#Printando "vetor A"
		li $v0, 4
		la $a0, quebraLinha
		syscall
		
		

####################################################################VETOR B#######################################

	#Coloca valores no vetor B
	addi $s0,$zero,4
	addi $s1,$zero,10
	addi $s2,$zero,14
	addi $s3,$zero,16
	addi $s4,$zero,22
	
	#Atribui zero ao registrador t0 para usar como índice
	addi $t0,$zero, 0
	
	sw $s0, vetorB($t0) #adiciona $s0 na primeira posição do vetorA
	  addi $t0,$t0,4 #adiciona 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s1,vetorB($t0) #adiciona $s1 na segunda posição do vetor A (deslocamento de 4 bytes)
	  addi $t0,$t0,4 #adiciona mais 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s2,vetorB($t0) #adiciona $s2 na terceira posição do vetor A
	  addi $t0, $t0, 4
	  
	sw $s3, vetorB($t0)
	  addi $t0, $t0, 4
	  
	sw $s4, vetorB($t0)
	  
	  
	addi $t0,$zero,0 #reinicia $t0
	
	
	#Printando "vetor A"
	li $v0, 4
	la $a0, printVetorB
	syscall
	
	#printando "["
	li $v0, 4
	la $a0, abreColchetes
	syscall
	
	whileB:
		beq $t0,20,exitB #if ($t0 == 20) { exit}
		
		lw $t6,vetorB($t0) #carregando o primeiro elemento do vetor A no registrador $t6 
		
		addi $t0,$t0,4
		
		#printando valor atual
		li $v0,1 #preparando syscall
		move $a0,$t6 #movendo valor de $t6 para $a0
		syscall 
		
		#Printando espaço em branco para separar valores
		li $v0, 4
		la $a0, delimitador
		syscall
		
		j whileB
	exitB:
		#printando "]"
		li $v0, 4
		la $a0, fechaColchetes
		syscall
		


############################################### CHECANDO SE A ESTÁ CONTIDO EM B ##################################################


	addi $t0,$zero,0 #reinicia $t0
	addi $t1,$zero,0 #reinicia $t1
	
	
while_A:
	beq $t0,12,exit_A #if ($t0 == 12) { exit}
		
	while_B:
		beq $t1,20,while_A #if ($t0 != 20) { whileA }
		
	lw $t6,vetorA($t0) #carregando o primeiro elemento do vetor A no registrador $t6 
	
	lw $t7,vetorB($t1) #carregando o primeiro elemento do vetor A no registrador $t7 
		
	beq $t6,$t7,numerosEncontrados
		
	addi $t0,$t0,4
	
	addi $t1,$t1,4
		
	j while_A

		
exit_A:
	
	addi $t8,$zero,3
	beq $t5,$t8,AcontidoEmB
	bne $t5,$t8,ANaoContidoEmB

numerosEncontrados:
	addi $t5,$t5,1

AcontidoEmB:
	li $v0, 4
	la $a0, quebraLinha
	syscall
		
	li $v0, 4
	la $a0, estaContido
	syscall
	
	#encerrando programa
	li $v0, 10
	syscall

ANaoContidoEmB:
	li $v0, 4
	la $a0, quebraLinha
	syscall
	
	li $v0, 4
	la $a0, naoEstaContido
	syscall
	
	#encerrando programa
	li $v0, 10
	syscall	