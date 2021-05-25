.section .data
string:
	.asciz "%d"
.section .text
.globl main
main:
	pushq %rbp			# OPEN  STACK intialize base stack
	movq %rsp, %rbp			# %rbp = %rsp (stack pointer point to base)

	leaq string(%rip), %rdi		# Put string to rdi for calling scanf
	leaq a(%rip), %rsi		# 
	call scanf			# call scanf and do scanf("%d", &a) [scanf(RDI,RSI)]

	movq $string, %rdi		# RDI = &string
	movq a, %rsi			# RSI = a
	call printf			# call scanf and do printf("%d",a)    printf(RDI, RSI)

	pop %rbp			# CLOSE STACK destroy base stack
	xor %rax, %rax			# %rax = 0
	ret				# END PROGRAM
.section .bss
	.lcomm a, 4 			# initialize int a;
