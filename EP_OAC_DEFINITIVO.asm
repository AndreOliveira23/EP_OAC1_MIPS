.data
	vetorA: .space 12 #Aloca 12 bytes para o vetor A. Cada elemento ocupa 4 bytes. Portanto, o vetor A terá 3 elementos
	printVetorA: .asciiz "Vetor A: " #Texto para ser colocado na tela antes de imprimir o vetor A
	
	vetorB: .space 20 #Aloca 20 bytes para o vetor A. Cada elemento ocupa 4 bytes. Portanto, o vetor A terá 5 elementos
	printVetorB: .asciiz "Vetor B: " 
	
	delimitador: .asciiz " "
	abreColchetes: .asciiz "["
	fechaColchetes: .asciiz "]"
	
	quebraLinha: .asciiz "\n"
	
	estaContido: .asciiz "O vetor A está contido no vetor B"
	naoEstaContido: .asciiz "O vetor A não está contido no vetor B"
	
.text 
	main:
	#==============================================================Colocando valores no vetor A==============================================================
	
	#Adicionando valores desjeados nos registradores
	addi $s0,$zero,1
	addi $s1,$zero,2
	addi $s2,$zero,3
	
	#Atribui zero ao registrador t0 para usar como índice
	addi $t0,$zero, 0
	
	sw $s0, vetorA($t0) #adiciona o valor contido em $s0 na primeira posição do vetorA
	  addi $t0,$t0,4 #adiciona 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s1,vetorA($t0) #adiciona $s1 na segunda posição do vetor A (deslocamento de 4 bytes)
	  addi $t0,$t0,4 #adiciona mais 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s2,vetorA($t0) #adiciona $s2 na terceira posição do vetor A
	  
	  
	  
	  
	  
	addi $t0,$zero,0 #reinicia $t0 para usar como índice no laço de repetição
	
	
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
		
		#Iterando o i para passar para o próximo item do vetor
		j while
		
	exit:
		#printando "]"
		li $v0, 4
		la $a0, fechaColchetes
		syscall
		
		#Printando "\n" para printar o vetor B na próxima linha
		li $v0, 4
		la $a0, quebraLinha
		syscall
		
	#==============================================================Colocando valores no vetor B==============================================================
	
	#Coloca valores desejados nos registradores
	addi $s0,$zero,4
	addi $s1,$zero,10
	addi $s2,$zero,14
	addi $s3,$zero,16
	addi $s4,$zero,22
	
	#Atribui zero ao registrador t0 para usar como índice
	addi $t0,$zero, 0
	
	sw $s0, vetorB($t0) #adiciona o valor contido em $s0 na primeira posição do vetor B
	  addi $t0,$t0,4 #adiciona 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s1,vetorB($t0) #adiciona o valor contido em $s1 na segunda posição do vetor B(deslocamento de 4 bytes)
	  addi $t0,$t0,4 #adiciona mais 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s2,vetorB($t0) #adiciona o valor contido em $s2 na terceira posição do vetor B
	  addi $t0, $t0, 4 #adiciona 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s3, vetorB($t0) #adiciona o valor contido em $s3 na quarta posição do vetor B
	  addi $t0, $t0, 4 #adiciona 4 no valor de $t0 para deslocamento por bytes na próxima atribuição
	  
	sw $s4, vetorB($t0) #adiciona o valor contido em $s3 na quinta posição do vetor B
	  
	  
	addi $t0,$zero,0 #reinicia $t0 para usar como índice no laço de repetição para impressão do vetor
	
	
	#Printando "vetor B:"
	li $v0, 4
	la $a0, printVetorB
	syscall
	
	#printando "["
	li $v0, 4
	la $a0, abreColchetes
	syscall
	
	whileB:
		beq $t0,20,exitB #if ($t0 == 20) { exit}
		
		lw $t6,vetorB($t0) #carregando o primeiro elemento do vetor B no registrador $t6 
		
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
		

#==============================================================Checando se A está contido em B==============================================================


	addi $t0,$zero,0 #reinicia $t0
	addi $t1,$zero,0 #reinicia $t1
	
	
	while_A: #laço externo
		beq $t0,12,exit_A #Verifica se o valor em $t0 é igual a 12. Se não for, quer dizer que não passou por todos os elementos de A
		
		while_B: #laço interno
			beq $t1,20,while_A #Verifica se o valor em $t0 é igual a 20. Se não for, quer dizer que não passou por todos os elementos de B
		
		lw $t6,vetorA($t0) #carregando o primeiro elemento do vetor A no registrador $t6 
	
		lw $t7,vetorB($t1) #carregando o primeiro elemento do vetor A no registrador $t7 
		
		beq $t6,$t7,numerosEncontrados #Se o i-ésimo elemento de A (contido no valor atual de $t6) for igual ao i-ésimo elemento de B (contido no valor atual de $t7) , salta para a rotina contida em "numerosEncontrados"
		
		addi $t0,$t0,4 #Incrementa 4 no registrador $t0, que está servindo como índice de vetor A. O deslocamento é por Byte. o próximo elemento está a +4 bytes de deslocalemnto
	
		addi $t1,$t1,4 #Incrementa 4 no registrador $t1, que está servindo como índice do vetor B. O deslocamento é por Byte. o próximo elemento está a +4 bytes de deslocalemnto
		
		j while_A #Salta de volta para o laço externo

		
	exit_A: #Após percorrer todos os elementos de ambos os vetores, verifica uma variável de controle para saber se o vetor A está contdo em B ou não
		addi $t8,$zero,3 #Adiciona 3 no registrador $t8 para usar como comparativo
		beq $t5,$t8,AcontidoEmB #Se o valor contido em $t5 é igual a 3, quer dizer que os 3 elementos de A foram encontrados em B, portanto, A está contido em B
		bne $t5,$t8,ANaoContidoEmB #Se o valor contido em $t5 é diferente de 3, quer dizer que pelo menos 1 dos 3 elementos de A não foram encontrados em B, portanto A não está contido em B

	numerosEncontrados: #Incrementa o registrador $t5, é usado para contar quantos elementos de A foram encontrados em B
		addi $t5,$t5,1

	AcontidoEmB: #Imprime na tela que A está contido em B (quando chamado)
		li $v0, 4
		la $a0, quebraLinha
		syscall
		
		li $v0, 4
		la $a0, estaContido
		syscall
	
		#encerrando programa
		li $v0, 10
		syscall

	ANaoContidoEmB: #Imprime na tela que A não está contido em B (quando chamado)
		li $v0, 4
		la $a0, quebraLinha
		syscall
	
		li $v0, 4
		la $a0, naoEstaContido
		syscall
	
		#encerrando programa
		li $v0, 10
		syscall	
