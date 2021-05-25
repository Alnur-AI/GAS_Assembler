.section .bss
	.lcomm buffer, 42
	.lcomm filehandle, 4
.section .text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $5, %rax
	movq 8(%rbp), %rbx
	movq $00, %rcx
	movq $0444, %rdx
	int $0x80
	test %eax, %eax
	js badfile
	movq %rax, filehandle

	movq $3, %rax
	movq filehandle, %rbx
	movq $buffer, %rcx
	movq $42, %rdx
	int $0x80
	test %rax, %rax
	js badfile

	movq $4, %rax
	movq $1, %rbx
	movq $buffer, %rcx
	movq $42, %rdx
	int $0x80
	test %rax, %rax

	movq $6, %rax
	movq filehandle, %rbx
	int $0x80

badfile:
	movq %rax, %rbx
	movq $1, %rax
	int $0x80
