#Testeaza daca un numar dat de la tastatura este nr. prim.

	.data
msg_citire:
	.asciiz "n = "
msg_prim:
	.asciiz "Numarul e prim!"
msg_neprim:
	.asciiz "Numarul nu e prim!"
	.align 2
n:
	.word 2

	.text
	.globl main
main:
	li $v0, 4		#afisare mesaj citire
	la $a0, msg_citire
	syscall

	li $v0, 5		#citire int
	syscall
	move $a0, $v0		#a0<- nr n
	la $t0, n
	sw $a0, ($t0)		#salvam n citit

	jal test_prim		#apelam rutina
	bnez $s0, e_prim	#$s0 = ?
	la $a0, msg_neprim
	li $v0, 4
	syscall
	j sfarsit
e_prim:
	la $a0, msg_prim
	li $v0, 4
	syscall
sfarsit:
	li $v0, 10
	syscall

#rutina care verifica daca un numar este prim
#primeste nr. de verificat in $a0
#intoarce in $s0 val 1 daca nr e prim, 0 in caz contrar
test_prim:
	li $t0, 1		#$t0<-divizorii
repeta:
	addi $t0, $t0, 1
	sge $t3, $t0, $a0		#div > n => nr. prim
	bnez $t3, gata_prim
	div $a0, $t0
	mfhi $t1		#t1<-rest
	mflo $t2		#t2<-cat
	beqz $t1, gata_neprim
	j repeta

gata_neprim:
	li $s0, 0
	j iesire_proc
gata_prim:
	li $s0, 1	
iesire_proc:
	jr $ra
