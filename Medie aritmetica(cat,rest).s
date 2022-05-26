#Calculeaza media aritmetica a n nr citite de la tastatura
	.data
msg_citire_n:
	.asciiz "n = "
msg_citire_nr:
	.asciiz "Introduceti numerele: "
msg_afisare_medie:
	.asciiz "Media aritmetica (cat, rest) = "
n:
	.space 4
numere:
	.space 100
	.text
	.globl main
main:

	puts msg_citire_n	# afisare string pe consola
	geti $t0		# $t0<-n, citeste n de la tastatura
	la $t2, n		# incarcare adresa lui n in $t2
	sw $t0, ($t2)	# memoreaza cuv. din reg. $t0 la adresa din $t2 

	puts msg_citire_nr	# afisare string pe consola
	
	li $t2, 0			# $t2<-suma (initializam suma cu 0)
	la $t1, numere		# $t1<-adresa unde se vor memora numerele
	
citeste:
	li $v0, 5			# $v0<-5(cod apel sistem 5 - citire intreg)
#	syscall
	add $t2, $t2, $v0	# $t2<-$t2+$v0(adauga nr. la suma)
	sw $v0, ($t1)		# memoreaza cuv. din reg. $v0 la adresa din $t1(mem. nr. in t1) 
	addi $t1, $t1, 4	# $t1<-$t1+4 
	li $t3, 1			# $t3<-1
	sub $t0, $t0, $t3	# $t0<-$t0-$t3(1) => dec. nr. n
	bnez $t0, citeste 	# not egal zero(n != 0 => citeste)

	la $t3, n			# incarcare adresa lui n in $t3 
	lw $t0, ($t3)		# incarcare 4o din $t3 in $t0
	div $t2, $t0		# suma / n
	mfhi $t0		
	mflo $t1
	puts msg_afisare_medie
	puti $t1			#cat
	putc ','
	puti $t0			#rest


sfarsit:
	done
