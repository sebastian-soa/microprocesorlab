#Testeaza daca un numar dat de la tastatura este nr. prim.

	.data
	.align 2
numere_prime:
	.space 100

	.text
	.globl main
main:
	li $t4, 0		#ct nr prime
	li $t5, 24		#nr. max de nr. prime
	li $a1, 2		#nr. de verificat
	la $t6, numere_prime	#adresa unde se salv
cauta:
	jal test_prim		#apelam rutina
	beqz $s0, nu_e_prim	#$s0 = ?
e_prim:
	addi $t4, $t4, 1	#ct<-ct + 1
	sw $a1, ($t6)
	addi $t6, $t6, 4	#incr. adresa unde se salv
	li $v0, 1
	move $a0, $a1
	syscall
	putc ' '
nu_e_prim:
	addi $a1, $a1, 1	#urm. nr. prim
	sge $t7, $t4, $t5
	bnez $t7, sfarsit
	j cauta
	
sfarsit:
	li $v0, 10
	syscall

#rutina care verifica daca un numar este prim
#primeste nr. de verificat in $a1
#intoarce in $s0 val 1 daca nr e prim, 0 in caz contrar
test_prim:
	li $t0, 1		#$t0<-divizorii
repeta:
	addi $t0, $t0, 1
	sge $t3, $t0, $a1		#div > n => nr. prim
	bnez $t3, gata_prim
	div $a1, $t0
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
