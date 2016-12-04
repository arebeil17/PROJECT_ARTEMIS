vbsme:  	li		$v0, 0					# 0 Set v0 = 0
			li		$v1, 0					# 4 Set v1 = 0
			lui		$s7, 0x7fff				# 8	Set SAD to Largest Possible
			ori		$s7, $s7, 0xffff		# 12
			lw		$s0,  0($a0)			# 16 Frame Rows
			lw		$s1,  4($a0)			# 20 Frame Cols
			lw		$s2,  8($a0)			# 24 Window Rows
			lw		$s3, 12($a0)			# 28 Window Cols
			sll		$s6, $s1, 2				# 32 Frame Row Jump
			mul		$a3, $s2, $s3			# 36 End of Window
			sll		$a3, $a3, 2				# 40
			add		$a3, $a3, $a2			# 44 
			addi	$a3, $a3, -4			# 48
			sub		$a0, $s1, $s3			# 52 Next Frame-Window Row Offset
			addi	$a0, $a0, 1				# 56
			sll		$a0, $a0, 2				# 60
			sub		$s4, $s1, $s3			# 64 Max Frame Columns
			sub		$s5, $s0, $s2			# 68 Max Frame Rows
			addi	$t9, $0, 0				# 72 Current Row
			addi	$t8, $0, 0				# 76 Current Column	
			addi	$t0, $a1, 0				# 80 Current Frame Cell
			sll		$t6, $s2, 2				# 84 Current Frame-Window Row End
			add		$t6, $t6, $t0			# 88
			addi	$t6, $t6, -4			# 92
			addi	$s0, $a1,  0			# 96 Current Frame-Window Start
SADLoop:	li		$t5, 0					# Reset Window SAD
			addi	$t1, $a2, 0				# Reset Window Address
			addi	$t2, $s3, -1			# Set Frame-Window Row End
			sll		$t2, $t2, 2				#
			add		$t6, $t0, $t2			#
WindowLoop:	lw		$t2, 0($t0)				# Current Frame Cell Value
			lw		$t3, 0($t1)				# Current Window Cell Value
			sub		$t4, $t2, $t3			# Cell SAD Value
			bgez	$t4, gteZero			# if Cell SAD < 0 perform abs()
			nor		$t4, $t4, $0			#
			addi	$t4, $t4, 1				#
gteZero:	add		$t5, $t5, $t4			# Add Cell SAD to Window SAD
			beq		$t1, $a3, CheckSAD		# GoTo CheckSAD if at the end of the Window
			beq		$t0, $t6, NextFWRow		# GoTo NextWinRow if at the end of the Frame Window Row
			addi	$t0, $t0, 4				# Move to Next Frame Element
			addi	$t1, $t1, 4				# Move to Next Window Element
			j		WindowLoop
NextFWRow:	add		$t0, $t0, $a0			# Move Frame-Window
			addi	$t1, $t1, 4				# Move to Next Window Element
			add		$t6, $t6, $s6			# Move Frame-Window Row End
			j		WindowLoop
CheckSAD:	slt		$t2, $t5, $s7			# Chcek if Current Window SAD < Min SAD
			beq		$t2, $0, CheckExit		#
			addi	$s7, $t5, 0				# Set New Min SAD
			addi	$v0, $t9, 0				# Set New Min SAD Row
			addi	$v1, $t8, 0				# Set New Min SAD Col
CheckExit:	bne		$t8, $s4, Move			# Check if at Last (Possible) Column
			bne		$t9, $s5, Move			# Check if at Last (Possible) Row
			#jr		$ra						
			j		end
Move:		beq		$t8, $s4, MoveNextRow	# Check if at Last (Possible) Column
MoveRight:	addi	$t8, $t8, 1				# Move Next Column Index
			addi	$s0, $s0, 4				# Move Frame-Window Start
			addi	$t0, $s0, 0
			j 		SADLoop
MoveNextRow:addi	$t9, $t9, 1				# Move Row +1
			addi	$t8, $0,  0				# Move Col 0
			sll		$t2, $s3, 2				# Move Frame-Window To Begining of Next Row
			add		$s0, $s0, $t2			#
			addi	$t0, $s0, 0				#
			j		SADLoop
end:		j		endLoop
endLoop:	j		end