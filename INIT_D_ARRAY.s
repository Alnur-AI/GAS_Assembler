	.file	"INIT_D_ARRAY.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc			# "BEGIN PROCESS"
	pushq	%rbp			# define stack base
	.cfi_def_cfa_offset 16		# "COMPILER DO SOMETHING"
	.cfi_offset 6, -16		# "COMPILER DO SOMETHING"
	movq	%rsp, %rbp		# define stack pointer
	.cfi_def_cfa_register 6		# "COMPILER DO SOMETHING"
	subq	$336, %rsp		# %rsp = %rsp - 336 	ORIG(char field [10][30] + 36 bytes for something else)
	movq	%fs:40, %rax		# %rax = %fs:40, 	fs - commence of memory segment. fs::40 shift to 40 bytes.
	movq	%rax, -8(%rbp)		# (%rbp - 8) = %rax
	xorl	%eax, %eax		# %eax = 0
	movl	$0, -328(%rbp)		# (%rbp - 328) = 0 	ORIG(y = 0)
	jmp	.L2			# //JUMP TO ".L2"
.L5:
	movl	$0, -324(%rbp)		# (%rbp - 324) = 0 	ORIG(x = 0)
	jmp	.L3			# //JUMP TO ".L3"
.L4:
	movl	-328(%rbp), %eax	# %eax = (%rbp - 328) OR y
	movslq	%eax, %rcx		# %rcx = %eax
	movl	-324(%rbp), %eax	# %eax = (%rbp - 324) OR x
	movslq	%eax, %rdx		# %rdx = %eax
	movq	%rdx, %rax		# %rax = %rdx
	salq	$4, %rax		# salq - shift left aripmetics and save sigh
	subq	%rdx, %rax		# %rax -= %rdx
	addq	%rax, %rax		# %rax += %rax
	addq	%rbp, %rax		# %rax += %rbp
	addq	%rcx, %rax		# %rax += %rcx
	subq	$320, %rax		# %rax -= 320
	movb	$65, (%rax)		# $%rax = 65 [char field[x][y] = 'A']  adress in  write poiter
	addl	$1, -324(%rbp)		# (%rbp - 324) OR x += 1
.L3:
	cmpl	$9, -324(%rbp)		# compare 9 and (rbp - 324)
	jle	.L4			# if (rbp - 324) OR x <= 9 //JUMP ".L4"
	addl	$1, -328(%rbp)		# (%rbp - 328) OR y += 1
.L2:
	cmpl	$29, -328(%rbp)		# compare 29 and (rbp - 328)
	jle	.L5			# if (rbp - 328) OR y < 29 //JUMP ".L5"
	movl	$0, %eax		# %eax = 0
	movq	-8(%rbp), %rsi		# %rsi = (%rbp - 8)
	xorq	%fs:40, %rsi		# %rsi = value from %fs:40
	je	.L7			# if cf_flag = 0 //JUMP ".L7"
	call	__stack_chk_fail@PLT	# "COMPILER DO SOMETHING"; CALL FUNCTION THAT STOP WORKING WITH STACK
.L7:
	leave				# start leaving program
	.cfi_def_cfa 7, 8		# "COMPILER DO SOMETHING"
	ret				# END PROCESS
	.cfi_endproc			# "END PROCESS"
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits

# include <stdio.h>
# int main(void){
# 	char field [10][30];
#	for (int y = 0; y < 30; y++)
#		for (int x = 0; x < 10; x++)
#			field[x][y] = 'A'
#	return 0;
# }
