.data
citire_n:
	.asciiz "n = "
citire_k:
	.asciiz "k = "
afisare_c:
	.asciiz "C(n, k) = "
afisare_a:
	.asciiz "A(n, k) = "
	.align 4
nf:
	.space 4
kf:
	.space 4
nkf:
	.space 4
	
.text
	.globl main
main:
	li $v0, 4								# cod syscall 4 - print string
	la $a0, citire_n
	syscall
	li $v0, 5								# cod syscall 5 - read integer
	syscall
	move $t0, $v0							# t0<-n
	li $v0, 4
	la $a0, citire_k						# cod syscall 4 - print string
	syscall
	li $v0, 5								# cod syscall 5 - read integer
	syscall
	move $t1, $v0							# t1<-k

	#n factorial
	subu $sp, $sp, 12						# sp<-sp-12
	sw $ra, 8($sp)							
	sw $fp, 4($sp)
	move $a0, $t0							# a0<-n
	addu $fp, $sp, 12						# fp<-sp+12(vf.)
	jal factorial
	addu $sp, $sp, 12						# sp<-sp+12
	la $t2, nf								# t2<- adresa nf
	sw $v1, ($t2)							# v1 mem. adresa nf

	#k factorial
	subu $sp, $sp, 12						# sp<-sp-12
	sw $ra, 8($sp)
	sw $fp, 4($sp)
	move $a0, $t1							#a0<-k
	addu $fp, $sp, 12
	jal factorial
	addu $sp, $sp, 12   					# sp<-sp+12
	la $t2, kf								# t2<- adresa kf
	sw $v1, ($t2)							# v1 mem. adresa kf

	#n-k factorial
	subu $sp, $sp, 12						# sp<-sp-12
	sw $ra, 8($sp)
	sw $fp, 4($sp)
	sub $t0, $t0, $t1						# n<-n-k
	move $a0, $t0							# a0<-n-k
	addu $fp, $sp, 12
	jal factorial
	addu $sp, $sp, 12						# sp<-sp+12
	la $t2, nkf								# t2<- adresa nkf
	sw $v1, ($t2)   						# v1 mem. adresa nkf

	#Aranjamente - A(n, k) = n! / (n-k)!
	la $t0, nf								# t0<- adresa n!
	lw $t1, ($t0)							# t1<- n!
	la $t0, nkf								# t0<- adresa (n-k)!
	lw $t2, ($t0)							# t2<- (n-k)!
	div $t1, $t2							# n! / (n-k)!
	mfhi $t1
	mflo $t2
	puts afisare_a
	puti $t2
	putc ' '
	puti $t1

	#Combinari - C(n, k) = n! / k!*(n-k)!
	la $t0, nf								# t0<- adresa n!
	lw $t1, ($t0)							# t1<- n!
	la $t0, nkf							    # t0<- adresa (n-k)!
	lw $t2, ($t0)							# t2<- (n-k)!
	la $t0, kf								# t0<- adresa k!
	lw $t3, ($t0)							# t3<- k!
	mul $t3, $t3, $t2						# k!*(n-k)!
	div $t1, $t3							# n! / k!*(n-k)!
	mfhi $t1
	mflo $t2
	putc '\n'
	puts afisare_c
	puti $t2
	putc ' '
	puti $t1
	
	
sfarsit:
	done

#rutina factorial
factorial:
	subu $sp, $sp, 12
	sw $ra, 8($sp)
	sw $fp, 4($sp)
	sw $a0, ($sp)
	addu $fp, $sp, 12		#loop
	
	lw $v1, ($sp)			
	bgtz $v1, continua
	li $v1, 1
	j iesire
	
continua:
	lw $a0, ($sp)			
	addi $a0, $a0, -1		#dec. a0
	jal factorial
	#Intoarcere din factorial
	lw $a0, ($sp)
	mul $v1, $v1, $a0		#n*(n-1)

iesire:
	lw $ra, 8($sp)
	lw $fp, 4($sp)
	addu $sp, $sp, 12		
	jr $ra					# jump la adr. ra
	


