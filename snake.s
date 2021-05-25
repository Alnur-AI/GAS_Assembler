	.file	"snake.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"%c "
	.align 8
.LC2:
	.string	"1 - move up\n2 - move right\n3 - move down\n4 - move left\n5 - stop program"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc			# "START PROCESS"
	pushq	%rbp			# define stack base
	.cfi_def_cfa_offset 16		# "COMPILER DO SOMETHING"
	.cfi_offset 6, -16		# "COMPILER DO SOMETHING"
	movq	%rsp, %rbp		# define stack pointer
	.cfi_def_cfa_register		# "COMPILER DO SOMETHING"
	subq	$112, %rsp		# rsp = rsp - 112 bytes (initialise all integers and chars for program in stack)
	movq	%fs:40, %rax		# 
	movq	%rax, -8(%rbp)		# (rbp - 8) = rax
	xorl	%eax, %eax		# eax = 0
	movl	$0, -108(%rbp)		# (rbp - 108) = 0
	jmp	.L2			# //JUMP TO '.L2'
.L5:
	movl	$0, -104(%rbp)		# (rbp - 104) = 0
	jmp	.L3			# //JUMP TO '.L3'
.L4:
	movl	-108(%rbp), %eax	# %eax = rbp - 108
	cltq				# WTF
	movl	-104(%rbp), %edx	# %edx = rbp - 104
	movslq	%edx, %rdx		# %rdx = %edx
	salq	$3, %rdx		# %rdx = 3
	addq	%rbp, %rdx		# %rdx = %rbp
	addq	%rdx, %rax		# %rax = %rdx
	subq	$80, %rax		# %rax = rax - 80
	movb	$46, (%rax)		# &(%rax) = 46
	addl	$1, -104(%rbp)		# (%rbp - 104) = (%rbp - 104) + 1
.L3:
	cmpl	$7, -104(%rbp)		# compare 7 and (%rbp - 104)
	jle	.L4			# if not equal //JUMP TO .L4
	addl	$1, -108(%rbp)		# (%rbp - 108) = (%rbp - 108) + 1;
.L2:
	cmpl	$7, -108(%rbp)		# compare 7 and (%rbp - 108)
	jle	.L5			# //JUMP TO ".L5"
	movl	$4, -100(%rbp)		# (%rbp - 100) = 4;
	movl	$4, -96(%rbp)		# (%rbp - 96) = 4;
	jmp	.L6			# //JUMP TO ".L6"
.L17:
	leaq	-112(%rbp), %rax	# %rax = $(%rbp - 112)
	movq	%rax, %rsi		# %rsi = %rax
	leaq	.LC0(%rip), %rdi	# %rdi = $()
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-96(%rbp), %eax
	cltq
	movl	-100(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rbp, %rdx
	addq	%rdx, %rax
	subq	$80, %rax
	movb	$46, (%rax)
	movl	-112(%rbp), %eax
	cmpl	$1, %eax
	jne	.L7
	subl	$1, -96(%rbp)
.L7:
	movl	-112(%rbp), %eax
	cmpl	$2, %eax
	jne	.L8
	addl	$1, -100(%rbp)
.L8:
	movl	-112(%rbp), %eax
	cmpl	$3, %eax
	jne	.L9
	addl	$1, -96(%rbp)
.L9:
	movl	-112(%rbp), %eax
	cmpl	$4, %eax
	jne	.L10
	subl	$1, -100(%rbp)
.L10:
	movl	-96(%rbp), %eax
	cltq
	movl	-100(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rbp, %rdx
	addq	%rdx, %rax
	subq	$80, %rax
	movb	$64, (%rax)
	movl	$0, -92(%rbp)
	jmp	.L11
.L14:
	movl	$0, -88(%rbp)
	jmp	.L12
.L13:
	movl	-92(%rbp), %eax
	cltq
	movl	-88(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rbp, %rdx
	addq	%rdx, %rax
	subq	$80, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -88(%rbp)
.L12:
	cmpl	$7, -88(%rbp)
	jle	.L13
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -92(%rbp)
.L11:
	cmpl	$7, -92(%rbp)
	jle	.L14
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -84(%rbp)
	jmp	.L15
.L16:
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -84(%rbp)
.L15:
	cmpl	$19, -84(%rbp)
	jle	.L16
.L6:
	movl	-112(%rbp), %eax
	cmpl	$5, %eax
	jne	.L17
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L19
	call	__stack_chk_fail@PLT
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
