	.data
fmt:
	.asciz	"%s --> "
msg:
	.asciz	"The list is:"

	.bss
.lcomm	heap, 500
.lcomm	buffer, 9

.lcomm	head, 8		# указатель на список


	.text
.globl main

main:
first_loop:
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
	movb	$0, buffer(%ecx)
	movl	$buffer, %edi
	call	insertNode
	jmp	first_loop

end_of_text:
	movl	head, %edi
	call	printList
	ret

##############################################
.type getFreeSpace, @function
.globl getFreeSpace

getFreeSpace:
	movl	$0, %ecx
func1_loop:
	cmpb	$0, heap(%ecx)
	je	get

	addl	$25, %ecx
	cmpl	$450, %ecx		# ограничение
	jg	error			# если памяти не достаточно
	jmp	func1_loop

get:
	movl	$1, heap(%ecx)
	incl	%ecx
	leal	heap(%ecx), %eax
	ret

error:
	movl	$0, %eax
	ret
#################################################

.type newNode, @function	# %edi - $buffer
.globl newNode

newNode:
	call	getFreeSpace

	cmpl	$0, %eax
	je	error2

	movl	%edi, %esi	# поле 1
	movl	%eax, %edi
	call	strcpy

	movl	$0, 16(%eax)

	ret

error2:
	ret
#################################################

.type insertNode, @function
.globl insertNode

insertNode:
	call	newNode

	cmpl	$0, head
	jne	not_null
	movl	%eax, head
	ret

not_null:
	movl	head, %ecx
	movl	%ecx, 16(%eax)
	movl	%eax, head
	ret
##############################################

.globl printList

printList:
	movl	%edi, %ebx

	leal	msg, %edi
	call	puts

printf_loop:
	cmpl	$0, %ebx
	je	end

	movl	$fmt, %edi
	movl	%ebx, %esi
	xor	%rax, %rax
	call	printf

	movl	16(%ebx), %ebx
	jmp	printf_loop

end:
	ret
################################################
