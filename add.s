.section .data
output:
	.asciz "%d\n"
input:
	.asciz "%d"
.section .text
.globl main
main:
	###ADDITION###
	push %rbp
	movq $input, %rdi
	movq $a,%rsi
	call scanf
	pop %rbp

	push %rbp
	movq $input, %rdi
	movq $b,%rsi
	call scanf
	pop %rbp

	movq a, %rax
	movq b, %rbx
	addq %rax, %rbx
	movq %rbx, s

	push %rbp
	movq $output, %rdi
	movq s,%rsi
	call printf
	pop %rbp

	###MULTIPLY###
	push %rbp
	movq $input, %rdi
	movq $a,%rsi
	call scanf
	pop %rbp

	push %rbp
	movq $input, %rdi
	movq $b,%rsi
	call scanf
	pop %rbp

	movq a, %rax
	movq b, %rbx
	imulq %rax, %rbx
	movq %rbx, s

	push %rbp
	movq $output, %rdi
	movq s,%rsi
	call printf
	pop %rbp

	xor %rax, %rax
	ret
.section .bss
.lcomm a, 8
.lcomm b, 8
.lcomm s, 8

