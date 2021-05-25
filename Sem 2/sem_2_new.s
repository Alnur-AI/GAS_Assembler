.section .data

fmt:
	.asciz	"%d\n"
noFreeSpace:
	.asciz	"НЕТ СВОБОДНОЙ ПАМЯТИ"
pr1:
	.asciz	"%s ("
pr2:
	.asciz	" , "
pr3:
	.asciz	")"
pr4:
	.asciz	"___ ("

.set	word, 0
.set	num, 16
.set	left, 24
.set	right, 32
			# 40 bytes
			# aligning 48 bytes

	.bss
.lcomm	str, 100
.lcomm	buffer, 20

.lcomm	heap, 1000
.lcomm	heap_ptr, 8
.lcomm	tree_ptr, 8
.lcomm	tmp, 8

.section .text
	.globl main
main:					# BEGIN PROGRAM
	pushq	%rbp			# Define Stack 1://[exit main address]
	movq	%rsp, %rbp		# Define Stack 2://%rbp = %rsp, program start working

	call	init_heap		# CREATE A_HEAP // We define 1000 bytes in ".lcomm heap, 1000" as a heap

	leal	str, %edi		# %edi = &str
	movl	$100, %esi		# %esi = 100
	movl	stdin, %edx		# %edx = stdin
	call	fgets			# CALL INPUT OPERTION fgets(str, 100, stdin);//We do input, input string in command line

L1:

	leal	str, %esi		# %esi = &str // in L3 we will read it for search words
L2:

	pushq	%rdi			# Save %rdi in stack: //[%rdi, exit main adress]
	pushq	%rsi			# Save %rsi in stack: //[%rsi, %rdi, exit main adress]

	leal	buffer, %edi		# %edi = &buffer
	movl	$20, %esi		# %esi = 20
	call	explicit_bzero		# CALL explicit_bzero(&buffer, 20); ["buffer = "\0\0...\0" "]

	popq	%rsi			# pop stack to %rsi:  //[%rdi, exit main adress]
	popq	%rdi			# pop stack to %rdi:  //[exit main adress]

	leal	buffer, %edi		# %edi = &buffer
L3:

	lodsb				# LOAD operand from string "str[%esi]" in %al ||| %esi = %esi + 1

	cmpb	$',', %al		# compare ',' and %al
	je	make_word		# if %al == ',' CALL MAKE WORD
	cmpb	$'.', %al		# compare '.' and %al
	je	make_word		# if %al == '.' CALL MAKE WORD

	cmpb	$'A', %al		# compare 'A' and %al
	jl	L2			# if 'A' > %al JUMP "L2" ["buffer = "\0...\0""] //it's not a letter, we need to make buffer equal "\0...\0"
	cmpb	$'Z', %al		# compare 'Z' and %al
	jg	L2			# if 'Z' < %al JUMP "L2" ["buffer = "\0...\0""] //it's not a letter, we need to make buffer equal "\0...\0"

	stosb				# STORE %al in string "buffer[%edi]" ||| %edi = %edi + 1
	jmp	L3			# JUMP "L3"//read another letter
make_word:

	movb	%al, %bl		# %bl = %al
	movb	$0, %al			# %al = 0
	stosb				# STORE %al = 0 in string buffer[%edi] ||| %edi = %edi + 1// buffer = "word...word\0"

	pushq	%rbx			# Save %rbx in stack: //[%rbx, exit main adress]
	pushq	%rdi			# Save %rdi in stack: //[%rdi, %rbx, exit main adress]
	pushq	%rsi			# Save %rsi in stack: //[%rsi, %rdi, %rbx, exit main adress]

	call	insert			# CALL INSERT FUNCTION // Put word in tree

	popq	%rsi			# pop stack to %rsi: //[%rdi, %rbx, exit main adress]
	popq	%rdi			# pop stack to $rdi: //[%rbx, exit main adress]
	popq	%rbx			# pop stack to %rbx: //[exit main adress]

	cmpb	$'.', %bl		# compare '.' and %bl
	je	end_of_text		# if %bl == '.' CALL EXIT OF TEXT //then start print this tree with conditions and exit program

	jmp	L2			# CALL L2 //read other word

end_of_text:
	movl	tree_ptr, %ebx		# %ebx = tree_ptr
	call	printTree		# CALL printTree
	ret				# END OF PROGRAM

###################INIT HEAP###########################

init_heap:
	leal	heap, %eax		# %eax = &heap
	movl	%eax, heap_ptr		# heap_ptr = %eax = &heap

	movl	$20, %ecx		# %ecx = 20 //20 words
	leal	heap, %ebx		# %ebx = &heap
F1:
	pushq	%rcx			# Save %rcx in stack: //[%rcx, exit init_heap adress, exit main adress]

	leal	48(%ebx), %eax		# %eax = &((%ebx = &heap) + 48)
	movl	%eax, (%ebx)		# &(%ebx = &heap) = %eax = &(%ebx = &heap) + 48
	addl	$48, %ebx		# %ebx += 48

	popq	%rcx			# pop stack to %rcx: //[exit init_heap adress, exit main adress]
	loop	F1			# JUMP F1 ||| %ecx-- ||| if %ecx == 0 do next instruction
	ret				# RETURN TO "main + 4" TEXT ADDRESS

####################ALLOCATOR###########################

get_free_space:
	movl	heap_ptr, %eax		# %eax = heap_ptr

	cmpl	$0, heap_ptr		# compare 0 and heap_ptr
	je	no_free_space		# if 0 == heap_ptr JUMP NO FREE SPACE//if you have no free space

	movl	(%eax), %ebx		# %ebx = &(%eax = heap_ptr)
	movl	%ebx, heap_ptr		# heap_ptr = %ebx = &(eax = heap_ptr)

	movl	%eax, %edi		# %edi = %eax = heap_ptr

	movl	$48, %esi		# %esi = 48
	call	explicit_bzero		# CALL explicit_bzero // make structure = "\0...\0"

	ret				# RETURN TO "create_node + 1" TEXT ADDRESS

no_free_space:
	leal	noFreeSpace, %edi	# %edi = &noFreeSpace
	call	puts			# CALL puts//output "NO FREE SPACE"

	movl	$1, %edi		# %edi = 1//exit condition
	call	exit			# END PROGRAM

###############CREATE NODE FOR TREE########################

create_node:
	call	get_free_space		# CALL GET FREE SPACE
	movl	%eax, %edi		# %edi = %eax = head_ptr(old)
	leal	buffer, %esi		# %esi = &buffer
	call	strcpy			# CALL STRCPY // copy in head_ptr buffer

	movl	$1, num(%eax)		# struct.num = 1 // this word is available in tree
	ret				# RETURN TO "insert + 1" TEXT ADDRESS

###################INSERT NODE IN TREE######################

insert:
	call	create_node		# CALL CREATE NODE
	movl	%eax, tmp		# tmp = %eax = head_ptr (old) = pointer to W0RD

	cmpl	$0, tree_ptr		# compare 0 and tree_ptr
	jne	not_null		# if 0 != tree_ptr JUMP NOT NULL// if tree is not empty

	movl	tmp, %eax		# %eax = tmp = head_ptr (old) = poiter to word
	movl	%eax, tree_ptr		# tree_ptr = %eax = head_ptr(old) = pointer to word// input word in root
	ret				# RETURN TO "make_word + 8" TEXT ADDRESS

not_null:
	movl	tree_ptr, %ebx		# %ebx = tree_ptr

ins_loop:
	movl	tmp, %edi		# %edi = tmp = head_ptr(old) = pointer to word
	movl	%ebx, %esi		# %esi = %ebx = tree_ptr = pointer to another word
	call	strcmp			# CALL STRCMP// compare this words(this is needed for inserting compare to position in alphabet)

	cmpl	$0, %eax		# compare 0 and %eax
	jl	less			# JUMP LESS// construct left leaf
	jg	greater			# JUMP GREATER// construct right leaf

	incl	num(%ebx)		# struct.num++
	ret				# RETURN TO "make_word + 8" TEXT ADDRESS

less:
	cmpl	$0, left(%ebx)		# compare 0 and struct.left
	je	ins_left		# if struct.left == 0 JUMP ins_left

	movl	left(%ebx), %ebx	# %ebx = struct.left//put word in leaf
	jmp	ins_loop		# JUMP INS LOOP//not empty, search again!

ins_left:
	movl	tmp, %eax		# %eax = tmp = head_ptr(old) = pointer to word
	movl	%eax, left(%ebx)	# struct.left = %eax = head_ptr(old) = pointer to word
	ret				# RETURN TO "make_word + 8" TEXT ADDRESS

greater:
	cmpl	$0, right(%ebx)		# compare 0 and struct.right
	je	ins_right		# if struct.right == 0 JUMP INS RIGHT
	movl	right(%ebx), %ebx	# %ebx = struct.right
	jmp	ins_loop		# JUMP INS LOOP
ins_right:
	movl	tmp, %eax		# %eax = tmp = head_ptr(old) = pointer to word
	movl	%eax, right(%ebx)	# struct.right = %eax = head_ptr(old) = pointer to word
	ret				# RETURN TO "make_word + 8" TEXT ADDRESS

#####################PRINT TREE############################

printTree:
	cmpl	$0, %ebx		# compare 0 and %ebx = tree_ptr//Tree is empty?
	jne	G0			# if 0 != %ebx = tree_ptr JUMP G0// if no then go print it
	ret				# END PROGRAMM
G0:
	cmpl	$1, num(%ebx)		# compare 1 and struct.num//this word is empty?
	jg	G1			# if 1 == struct.num JUMP G1//if no go print "-----"

	leal	pr4, %edi		# %edi = &"___ ("
	xor	%rax, %rax		# %rax = 0
	call	printf			# CALL PRINTF

	jmp	G2			# JUMP G2

G1:

	leal	pr1, %edi 		# %edi = &("%s (")//movl $pr1, %edi
	movl	%ebx, %esi		# %esi = %ebx = tree_ptr
	xor	%rax, %rax		# %rax = 0
	call	printf			# CALL PRINTF
G2:

	pushq	%rbx			# Save %rbx to stack: //[]

	movl	left(%ebx), %ebx	# %ebx = struct.left
	call	printTree		# CALL PRINTTREE //recursion

	popq	%rbx			# pop stack to %rbx //[]

	leal	pr2, %edi		# %edi = ","
	xor	%rax, %rax		# %rax = 0
	call	printf			# CALL PRINTF

	pushq	%rbx			# Save %rbx to stack:
	movl	right(%ebx), %ebx	# %ebx = struct.right
	call	printTree		# CALL PRINTTREE //recursion
	popq	%rbx			# Pop stack to %rbx:

	leal	pr3, %edi		# %edi = &")"
	xor	%rax, %rax		# %rax = 0
	call	printf			# CALL PRINTF

	ret				# RETURN TO "end_of_text + 2" TEXT ADDRESS
