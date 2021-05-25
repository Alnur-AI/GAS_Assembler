	.file	"for_cycle.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc		# "START PROCESS"
	pushq	%rbp		# define stack base
	.cfi_def_cfa_offset 16	# "COMPILER DID SOMETHING"
	.cfi_offset 6, -16	# "COMPILER DID SOMETHING"
	movq	%rsp, %rbp	# define stack point
	.cfi_def_cfa_register 6	# "COMPILER DID SOMETHING"
	movl	$5, -8(%rbp)	# (%rbp - 8) = 5	||| a = 5
	movl	$0, -4(%rbp)	# (%rbp - 4) = 0	||| i = 0
	jmp	.L2		# //JUMP TO ".L2"
.L3:
	addl	$80, -8(%rbp)	# (%rbp - 8) += 80	||| a += 80
	addl	$1, -4(%rbp)	# (%rbp - 4) += 1	||| i += 1
.L2:
	cmpl	$9, -4(%rbp)	# compare 9 and (%rbp - 4)
	jle	.L3		# if 9 > (%rbp - 4) then //JUMP TO ".L3"
	movl	$0, %eax	# %eax = 0
	popq	%rbp		# delete stack
	.cfi_def_cfa 7, 8	# "COMPILER DID SOMETHING"
	ret			# EXIT PROGRAM
	.cfi_endproc		# "END PROCESS"
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
