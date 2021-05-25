	.data
.set	word, 0
.set	num, 16
.set	left, 24
.set	right, 32


fmt_c:
	.asciz	"%c "
fmt_d:
	.asciz	"%d\n"
pr1:
	.asciz	"%s ("
pr2:
	.asciz	" , "
pr3:
	.asciz	")"

error_msg:
	.asciz	"NO LEFT FREE SPACE"


	.bss
.lcomm	heap, 1000
.lcomm	buffer, 9

.lcomm	head, 8


	.text

.globl main
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$0, head

first_loop:
	leal	buffer, %edi
	movl	$9, %esi
	call	explicit_bzero

	call	getchar
	cmpb	$'.', %al
	je	end_of_text

	cmpb	$'A', %al
	jl	first_loop
	cmpb	$'Z', %al
	jg	first_loop

	movl	$0, %ecx
second_loop:
	cmpb	$',', %al
	je	make_buffer

	cmpb	$'A', %al
	jl	first_loop
	cmpb	$'Z', %al
	jg	first_loop

	movb	%al, buffer(%ecx)
	incl	%ecx
	call	getchar
	jmp	second_loop

make_buffer:
	movl	$0, buffer(%ecx)

	leal	buffer, %edi
	call	strlen

	cmpl	$8, %eax
	jg	first_loop

	leal	buffer, %edi
	call	insertNode
	jmp	first_loop

end_of_text:
	movq	head, %rdi
	call	printTree
	ret

#####################################################
.type getFreeSpace, @function
.globl getFreeSpace

getFreeSpace:
	movl	$0, %ecx
search_loop:
	cmpb	$0, heap(%ecx)
	je	found
	addl	$48, %ecx

	cmpl	$960, %ecx
	jg	error_exit

	jmp	search_loop

found:
	movb	$1, heap(%ecx)
	addl	$8, %ecx
	leal	heap(%ecx), %eax
	ret

error_exit:
	leal	error_msg, %edi
	call	puts
	movl	$1, %edi
	call	exit

#################################################
.type newNode, @function
.globl newNode

newNode:	# %edi - &buffer
	call	getFreeSpace

	movl	%edi, %esi
	leal	word(%eax), %edi
	call	strcpy

	movl	$1, num(%eax)
	movl	$0, left(%eax)
	movl	$0, right(%eax)

	ret

##################################################

.type insertNode, @function
.globl insertNode

insertNode:
	cmpl	$0, head
	jne	not_null

	call	newNode

	movl	%eax, head
	ret

not_null:
	movl	head, %ebx	# tmp
f_loop:
	leal	word(%ebx), %esi
	call	strcmp
	cmpl	$0, %eax

	jg	right_side
	je	equal


left_side:
	cmpl	$0, left(%ebx)
	je	ins_left
	movl	left(%ebx), %ebx
	jmp	f_loop

ins_left:
	call	newNode
	movl	%eax, left(%ebx)
	ret


right_side:
	cmpl	$0, right(%ebx)
	je	ins_right
	movl	right(%ebx), %ebx
	jmp	f_loop

ins_right:
	call	newNode
	movl	%eax, right(%ebx)
	ret

equal:
	incl	num(%ebx)
	ret

################################################

.type printTree, @function
.globl printTree

printTree:
	movq	%rdi, %rbx
	cmpq	$0, %rbx
	jne	L1
	ret

L1:
	leaq	pr1, %rdi
	leaq	word(%rbx), %rsi
	xor	%rax, %rax
	call	printf

	pushq	%rbx

	movq	left(%rbx), %rdi
	call	printTree

	popq	%rbx

	leal	pr2, %edi
	xor	%rax, %rax
	call	printf

	pushq	%rbx

	movq	right(%rbx), %rdi
	call	printTree

	pop	%rbx

	leaq	pr3, %rdi
	xor	%rax, %rax
	call	printf

	ret
#################################################

