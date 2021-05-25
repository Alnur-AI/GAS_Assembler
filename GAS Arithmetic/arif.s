	.file	"arif.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	# DEFINE
	movl	$17, -28(%rbp)//x0 = 17
	movl	$7, -24(%rbp)//x1 = 7
	# ADD
	movl	-28(%rbp), %edx// edx = x0
	movl	-24(%rbp), %eax// dax = x1
	addl	%edx, %eax// eax = x0 + x1
	movl	%eax, -20(%rbp)// a = eax = x1 + x0
	# SUB
	movl	-28(%rbp), %eax//eax = x0
	subl	-24(%rbp), %eax//eax = eax - x1 = x0 - x1
	movl	%eax, -16(%rbp)//b = x0 - x1
	# MUL
	movl	-28(%rbp), %eax//eax = x0
	imull	-24(%rbp), %eax//eax = eax*x1 = x0*x1
	movl	%eax, -12(%rbp)//c = x0 * x1
	# DIV
	movl	-28(%rbp), %eax//eax = x0
	cltd//(convert long to double)expand eax to edx:eax
	idivl	-24(%rbp)//eax = eax / x1 = x0 / x1
	movl	%eax, -8(%rbp)//d = eax = x0 / x1
	# MOD_DIV
	movl	-28(%rbp), %eax//eax = x0
	cltd
	idivl	-24(%rbp)
	movl	%edx, -4(%rbp)
	# EXIT
	movl	$	0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
