.section .data
s_input:
	.asciz "%s"
sn_head:
	.asciz "@ "
sn_body:
	.asciz "# "
sn_empt:
	.asciz ". "
sn_food:
	.asciz "* "
nw_line:
	.asciz "\n"

.section .text
.globl main
main:
	movq $8, %rbx		# %rbx = 8
	movq %rbx, x		# x = %rbx
	movq %rbx, y		# y = %rbx
l1:
	movq $8, %rbx		# %rbx = 8
L:
	movq $s_input, %rdi	# input "%s"
	movq $sn_head, %rsi	# output "@"
	push %rbp		# define stack
	call printf		# CALL PRINTF
	pop %rbp		# delete stack

	dec %rbx		# %rbx--
	cmp $0, %rbx		# compare 0 and %rbx
	jne L			# //JUMP TO 'L'
new_line:
	movq $s_input, %rdi	# input "%s"
	movq $nw_line, %rsi	# output "\n"
	push %rbp		# define stack
	call printf		# CALL PRINTF
	pop %rbp		# delete stack

	decq y			# y--
	movq y, %rdx		# %rdx = y

	cmp $0, %rdx		# compare 0 and %rdx
	jne l1			# //JUMP TO 'l1'

	ret			# //END PROGRAM
.section .bss
	.lcomm x, 8
	.lcomm y, 8
