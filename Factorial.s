.data 
	nr: 
		.word 5
	err: 
		.asciiz "Eroare"
		
		.text
		.globl main
		
	main:
					# citim nr cu get1 sau syscall
		lw $a0, nr 		# $a0<-nr
		bltz $a0, eroare 	# verif n>0
		jal factorial 		
					# afisare n!
		move $a0, $t1		# $a0<-$t1
		li $v0, 1		# cod 1 syscall - print integer
		syscall
		done
		
	factorial:
		addi $sp, $sp, -4 	# dec stiva 
		sw $ra, ($sp)		# push $ra
		li $t1,1		# load instr. with 1
		beqz $a0, end		# if a0 equal 0 go to end
		
	multiply:
		mul $t1,$t1,$a0		# multiply 
		addi $a0,$a0, -1	# n-1 pentru factorial
		bgtz $a0, multiply	# if a0 > 0 atunci mul
	end:
		lw $ra, ($sp)		# load word address in ra
		addi $sp,$sp, 4		# inc with 4 for pop()
		jr $ra			#jmp to register ra
		
	eroare:
		puts err
		j main
	