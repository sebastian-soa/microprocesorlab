//Program de calcul a sumei de n numere întregi aflate în memorie la adresa
//0x10010000. Afisare suma si scriere în memorie la adresa 0x10010030. 


.data
  array:	.word 7,14,12,8 
  nr:   	.word 4
  rezultat:	.word 0x10010030

.text 
.global main
 main: 
	lw $t0, nr		//load word (nr) in reg t0
	la $t1, array	//nr total de elmente
	lw $t2, nr		//contor
	xor $t3, $t3, $t3	//initializare reg. t3 pt. ca aici punem suma
	//citim
 for:
	lw $t4, ($t1)	//citim din sursa
	add $t3, $t4, $t3	//adaugam la sursa
	addi $t2, $t2, -1	//dec contor 
	addi $t1, $t1, $t4	//inc adresa
	bgtz $t2, for
	sw $t3, rezultat
	done