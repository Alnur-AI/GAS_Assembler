.section .data
fmt:
	.asciz	"%s --> "
msg:
	.asciz	"The list is:"
printf_out:
	.asciz "%d"
.section .bss
.lcomm	heap, 500
.lcomm	buffer, 9
.section .text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	xorq %rax, %rax
	xorq %rcx, %rcx
paste_till_end:
	call getchar
	movb %al, buffer(%rcx)
	cmpb $'.', %al
	je end
	inc %rcx
end:
	movq $buffer, %rdi
	call puts
	pop %rbp
	xorq %rax, %rax
	ret
