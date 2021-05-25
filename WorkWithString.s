.section .data
string:
	.asciz "2ABC32abc."
message1:
	.asciz "rule 1"
message2:
	.asciz "rule 2"
.set trm,46
.set A,65
.set Z,90
.set a,97
.set z,122
.set zero,48
.set nine,57
.text
.globl main
main:
	pushq %rbp			# initialize stack (create base)
	movq %rsp,%rbp			# initialize stack (create pointer)


	xor %rax,%rax			# rax = 0
	xor %rbx,%rbx			# rax = 0
	cmpb $0,string(%rax)		# is this string empty?
	je .done2			# if string is empty activate rule 2 and end program
.IsFirstLat1:				# FIND BIG LETTERS IN BEGIN
	cmpb $A,string(%rax)		# string[0] is a Big letter?
	jl .done2			# if it's a digit or something else go activate rule 2!!!
	cmpb $Z,string(%rax)		# string[0] is a Big letter?
	jle .searchend			# if it is then go to the end of string go increase %rax!!!
	jg  .IsFirstLat2		# if it isn't then go to find out is this letter small!!!
.IsFirstLat2:				# FIND SMALL LETTER IN BEGIN
	cmpb $a,string(%rax)		# string[0] is a small letter?
	jl .done2			# if it isn't then activate rule 2 and go end program!!!
	cmpb $z,string(%rax)		# string[0] is a small letter?
	jle .searchend			# if it is then go to the end of string (increase rax)!!!
	jmp .done2			# Activate rule 2!!!
.searchend:				# LOOP!!! INCREASE %RAX AND GO TO THE END OF STRING
	inc %rax			# rax++
	cmpb $trm,string(%rax)		# compare string[rax] and '.'
	je .IsLastLat			# if string[rax] == '.' go check last letter!!!
	jne .searchend			# if string[rax] != '.' continue loop!!!
.IsLastLat:				# IF IT IS LAST THEN DO RULE 1 OR RULE 2
	dec %rax			# %rax--; string[rax] - it's the last letter of the string or something else
	cmpb $A,string(%rax)		# string [rax] is a Big letter?
	jl .done2			# if it isn't go activate rule 2!!!
	cmpb $Z,string(%rax)		# string [rax] is a Big letter?
	jle .done1			# if it is acivate rule 1!!!
	cmpb $a,string(%rax)		# string [rax] is a small letter?
	jl .done2			# if it isn't go activate rule 2!!!
	cmpb $z,string(%rax)		# string [rax] is a small letter?
	jle .done1			# if it is go activate rule 1 !!!
	jg .done2			# if it isn't go activate rule 2 !!!
.done1:					# RULE 1 ACTIVATED!!! MAKE ALL BIG LETTERS SMALL!!!
	movq $string, %rdi		# input string in printf("")
	call puts			# printf("%s\n", string)
	movq $message1,%rdi		# input "rule 1\n" in printf("")
	call puts			# printf("rule 1\n")
	xor %rax,%rax			# rax = 0 (for start search big letters from begin)
	jmp .zamena1			# go to find big letters and make it small!!!
.zamena1:				# LOOP!!! FIND IS STRING[RAX] IS LETTER OR TERMINATE
	cmpb $trm,string(%rax)		# string[rax] and '.'
	je .final			# if string[rax] == '.' end program!!!
	cmpb $A,string(%rax)		# string[rax] is maybe a big letter?
	jge .zamena2			# if it's maybe a big letter then check if it's really a big letter!!!
	inc %rax			# rax++ if it isn't a big letter
	jmp .zamena1			# if it isn't a big letter continue loop!!!
.zamena2:				# IS THIS LETTER REALLY A BIG LETTER? IF NOT GO TO CHECK NEXT LETTER
	cmpb $Z,string(%rax)		# is string[rax] is really a big letter?
	jle .zamena3			# if this is really a big letter then go make it small!!!
	inc %rax			# rax++ (if it isn't a big letter go check next letter)
	jmp .zamena1			# check next letter like previous one!!!
.zamena3:				# MAKE BIG LETTER SMALL AND GO TO CHECK NEXT LETTER
	xor %rbx,%rbx			# rbx = 0
	movb string(%rax),%dl		# dl = string[rax]
	addb $32,%dl			# dl = string[rax] + 32
	movb %dl,string(%rax)		# string[rax] = dl (make 'B' to 'b')
	inc %rax			# rax++
	jmp .zamena1			# go to check new letter!!!
.done2:					# RULE 2 ACTIVATED!!!
	movq $string, %rdi		# printf("INPUT DATA\n")
	call puts			# printf("INPUT DATA\n")
	movq $message2,%rdi		# printf("rule 2\n")
	call puts			# printf("rule 2\n")
	xor %rax, %rax			# rax = 0, counter
	xor %rbx, %rbx			# rbx = 0, position of number
	xor %rcx, %rcx			# rcx = 0, temporary value (for swapping)
	jmp .checknum			# go find number!!!
.checknum:				# IS STR[RAX] NUMBER?
	cmpb $trm, string(%rax)		# compare '.' and str[rax]
	je .final			# go to end program and do output!!!
	cmpb $zero, string(%rax)	# compare '0' and str[rax]
	jl .skipletter			# '0' > str[rax] it's not a number!!!
	cmpb $nine, string(%rax)	# compare '9' and str[rax]
	jg .skipletter			# '9' < str[rax] it's not a number!!!
	jle .swapping			# it's a number, go swap letter and number
.skipletter:				# INCREASE RAX AND GO CHECK NEW STR[RAX]
	inc %rax			# rax++
	jmp .checknum			# go to check another str[rax], maybe it's a num
.swapping:				# CHANGE LETTER TO NUMBER
	movb string(%rax), %cl		# cl = str[rax]
	movb string(%rbx), %ch		# ch = str[rbx]
	movb %ch, string(%rax)		# str[rax] = ch
	movb %cl,string(%rbx)		# str[rbx] = cl
	inc %rbx			# rbx++
	inc %rax			# rax++
	jmp .checknum			# go to check str[rax] is number or letter
.final:					# END OF THE PROGRAM!!!
	movq $string,%rdi		# put string to rdi for output by function puts
	call puts			# puts(string)
	ret				# END



