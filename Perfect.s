#Verifica daca un nr. citit de la tast e nr. perfect
#un nr perfect = suma divizorilor sai(inclusiv 1), mai putini el insusi
	.data
msg_citire:
	.asciiz "n = "
msg_afisare:
	.asciiz "Numarul este perfect!\n"
msg_afisare_nu:
	.asciiz "Numarul nu este perfect!\n"
	.align 4
divizori:
	.space 100
n:
	.word 6
	.text
	.globl main
main:
	li $v0, 4
	la $a0, msg_citire
	syscall
	
	li $v0, 5
	syscall
	move $a1, $v0		#$a1<-n

	li $t4, 0		#t4<-suma formata din divizori
	li $t0, 2
	div $a1, $t0
	mflo $t5		#t5<-n/2
	li $t6, 0		#t6<-ct divizori
	la $t3, divizori	#$t3<-adresa tabloului
	li $t0, 1		#$t0<-div
divide:
	div $a1, $t0
	mfhi $t1		#$t1<-rest
	mflo $t2		#$r2<-cat
	bnez $t1, nu_se_divide
se_divide:
	sw $t0, ($t3) 
	add $t4, $t4, $t0
	addi $t3, $t3, 4
	addi $t6, $t6, 1
nu_se_divide:
	addi $t0, $t0, 1
	sgt $t8, $t0, $t5
	beqz $t8, divide
	
	sub $t7, $a1, $t4
	beqz $t7, e_perfect
nu_e_perfect:
	li $v0, 4
	la $a0, msg_afisare_nu
	syscall
	j sfarsit

e_perfect:
	li $v0, 4
	la $a0, msg_afisare
	syscall
	li $t1, 0
	la $t3, divizori
afis_div:
	lw $a0, ($t3) 
	li $v0, 1
	syscall
	putc '+'
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	sgt $t7, $t6, $t1
	bnez $t7, afis_div

sfarsit:
	done
