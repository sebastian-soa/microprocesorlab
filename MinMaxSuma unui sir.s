
	.data
msg_citire_n:
	.asciiz "n = "
msg_citire_elemente:
	.asciiz "Introduceti elemente:"
msg_citire_nr:
	.asciiz "Nr:"
msg_max:
	.asciiz "Max = %d"
msg_min:
	.asciiz "Min = %d"
msg_suma:
	.asciiz "Suma = %d"
msg_nr_negativ:
	.asciiz "Nr. negativ!"
	
	.align2
param_citire_n:
	.word msg_citire_n
param_citire_elemente:
	.word msg_citire_elemente
param_citire_nr:
	.word msg_citire_nr
param_max:
	.word msg_max
max_value:
	.space 4
param_min:
	.word msg_min
min_value:
	.space 4
param_suma:
	.word msg_suma
sum_value:
	.space 4
param_nr_negativ:
	.word msg_nr_negativ

	.text
	.global main
main:
	addi r1, r0, msg_citire_n
	jal InputUnsigned		# jump and save
	addi r2, r1, 0			# r2<-contor numere
	

	sw sum_value, r5		# sum_value<-r5
	addi r14, r0, param_citire_elemente
	trap 5					# afisare mesaj

	addi r3, r0, -32000		# r3<-max
	addi r4, r0, 32000		# r4<-min
	addi r5, r0, 0			# r5<-suma
	
citeste:
	addi r1, r0, msg_citire_nr
	jal InputUnsigned
	sle r15, r1, r0			#set flag pt. <=
	bnez r15, nr_negativ
	
suma:
	add r5, r5, r1			#suma<-suma+nr
	
Mmin:
	sge r15,r1, r4			#set flag pt. >= pt. comparare min cu nr
	bnez r15, Mmax			
	add r4, r0, r1			#r4<-new min
Mmax:
	slt r15, r1, r3			#set flag pt. < pt. comparare max cu nr
	bnez r15, continue
	add r3, r0, r1			#r3<-new max
	
continue:
	subi r2, r2, 1			#inc contor
	bnez r2, citeste
	j sfarsit

nr_negativ:
	addi r14, r0, param_nr_negativ
	trap 5					
	j citeste

sfarsit:
	sw sum_value, r5		# sum_value<-sum
	addi r14, r0, param_suma
	trap 5					# afisare mesaj

	sw min_value, r4		# min_value<-min
	addi r14, r0, param_min
	trap 5					# afisare mesaj

	sw max_value, r3		# max_value<-max
	addi r14, r0, param_max
	trap 5					# afisare mesaj
	
	trap 0					#apel sistem de încheiere program