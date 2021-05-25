	.file	"arif_float.c"
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
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, -24(%rbp)
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, -20(%rbp)
	# ADD
	movss	-24(%rbp), %xmm0
	addss	-20(%rbp), %xmm0
	movss	%xmm0, -16(%rbp)
	# SUB
	movss	-24(%rbp), %xmm0
	subss	-20(%rbp), %xmm0
	movss	%xmm0, -12(%rbp)
	# MUL
	movss	-24(%rbp), %xmm0
	mulss	-20(%rbp), %xmm0
	movss	%xmm0, -8(%rbp)
	# DIV
	movss	-24(%rbp), %xmm0
	divss	-20(%rbp), %xmm0
	movss	%xmm0, -4(%rbp)
	# END
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1099431936 #//17.0
	.align 4
.LC1:
	.long	1088421888 #//7.0
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
