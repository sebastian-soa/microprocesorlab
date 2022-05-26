.data
nr: 
	.space 4
mesaj_prim: 
	.asciiz "Este prim"
mesaj_nu_e_prim: 	
	.asciiz "Nu este prim"

.text
	li, $v0, 5	# syscall pentru citire intreg
	syscall
	sw $v0, nr	# mem.cuv din reg. v0 

	li $t0, 2	# $t0<-2
loop: 
	bge $t0, $v0, end_loop	# $t0(2) >= $v0 => end loop
	divu $v0, $t0			# nr/2
	mfhi $t1				# $t1<-cat
	beqz $t1, nu_e_prim		# cat=0 => nu e prim
	addiu $t0, $t0, 1		# inc $t0
	j loop
	
end_loop:
	li $v0, 4				# cod 4 syscall - print string
	la $a0, mesaj_prim 		# $a0 <- adresa lui mesaj_prim
	syscall	
	j final

nup_e_prim:
	li $v0, 4				# cod 4 syscall - print string
	la $a0, mesaj_nu_e_prim # $a0 <- adresa lui mesaj_nu_e_prim
	syscall
	
final:
	li $v0, 10				# cod 10 syscall - exit
	syscall
