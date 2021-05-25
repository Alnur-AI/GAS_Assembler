	.file	"arif_pos.c"
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
	movl	$17, -28(%rbp)
	movl	$7, -24(%rbp)
	# ADD
	movl	-28(%rbp), %edx
	movl	-24(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -20(%rbp)
	# SUB
	movl	-28(%rbp), %eax
	subl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	# MUL
	movl	-28(%rbp), %eax
	imull	-24(%rbp), %eax
	movl	%eax, -12(%rbp)
	# DIV
	movl	-28(%rbp), %eax
	movl	$0, %edx
	divl	-24(%rbp)
	movl	%eax, -8(%rbp)
	# MOD DIV
	movl	-28(%rbp), %eax
	movl	$0, %edx
	divl	-24(%rbp)
	movl	%edx, -4(%rbp)
	# END
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
