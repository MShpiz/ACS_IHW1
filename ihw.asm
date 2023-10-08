# 36
.data
sep:    .asciz  "--------\n"    

error:  .asciz  "incorrect n!\n"  # ��������� � ������������ �����
n:	.word	0		# ����� ��������� ��������� �������
.align  2 
arrayA: .space  40 	
endArrayA:
.align  2 
arrayB: .space  40 	
endArrayB:

.text 
	addi 	sp sp -4		# �������� ����� ������ ������� � � �������� ���������
	la	t0, arrayA
	sw	t0, (sp)
	
	jal 	enter_array
	beqz	a0, fail		# ���� ��������� 0, �������� �� ������
	
	la	t0 n			# c�������� n
	sw	a0 (t0)
	addi 	sp sp -4		# ������� ���� �� ����������
	
	
	addi 	sp sp -4		# �������� ����� ������ ������� B � �������� ���������
	la	t0, arrayB
	sw	t0, (sp)
	
	addi 	sp sp -4		# �������� ����� ������ ������� � � �������� ���������
	la	t0, arrayA
	sw	t0, (sp)
	
	addi 	sp sp -4		# ���������� ��������� � ������� �
	sw	a0, (sp)
	jal 	fill_array_b		# ��������� ������ �
	
	addi	sp sp 12		# ������� ���� �� ����������
	
	addi 	sp sp -4		# �������� ����� ������ ������� B � �������� ���������
	la	t0, arrayB
	sw	t0, (sp)
	
	addi 	sp sp -4		# �������� ���������� ��������� � ������� B
	la	t0, n
	lw	t0, (t0)
	sw	t0, (sp)

	jal	print_array		# ������� ������ �
	addi	sp sp 8			# ������� ���� �� ����������
	li      a7 10           
        ecall
        
fail:
        la 	a0, error       # ��������� �� ������ ����� ����� ��������� �������
        li 	a7, 4           
        ecall
        li      a7 10           
        ecall



enter_array:		# ��������� ���������� ������ � ���������� ���������� � ����������, ���-�� ���������
	.data
	prompt_n: .asciz  "how many elements are you going to enter? "         # ��������� ��� ����� n
	prompt: .asciz  "enter number "         # ��������� ��� ����� �����
	
	.text
	addi	sp sp -4
	sw	ra (sp)
	
	addi	t0 sp 4		# �������� ����� ������� � �� ���������� �� �����
	lw	t0 (t0)
	
	addi	sp sp -4	# ��������� ��������� ��������� n (��������� ����������) �� ����
	sw	zero (sp)
	
	la 	a0, prompt_n      # �������� ���������� ���������
        li 	a7, 4           
        ecall
        
        li      a7 5            
        ecall
        mv      t3 a0           
        ble     t3 zero end_fill    # ���������� ������� ���� ��������� n <= 0
        
        li      t4 10           
        bgt     t3 t4 end_fill      # ���������� ������� ���� ��������� n > 10
        
        sw	t3 (sp)		# �������� �������� n � ����  
        
fill:
	la 	a0, prompt      # ���� ��������� ������� �
        li 	a7, 4           
        ecall
	li      a7 5           
        ecall
        mv      t2 a0
	sw      t2 (t0)         # ������ ��������
        addi    t0 t0 4         
        addi    t3 t3 -1        
        bnez    t3 fill
	
	end_fill:
	
	lw	a0 (sp)		# ���������� ���������� ��������� � ������� � (n)
	addi	sp sp 4
	
	lw	ra (sp)
	addi	sp sp 4
	ret
        
fill_array_b:				# ���������� ������� � (� ������ �������� ������� � � ������� ���������, � ����� - � ���������)

	addi	sp sp -4
	sw	ra (sp)
	
	addi	t3 sp 4		# ���������� ��������� � ������� � �� ���������� �� �����
	lw	t2 (t3)
	addi	t3 sp 4		# �������� ����� ������� � �� ���������� �� �����
	lw	t0 (t3)
	addi	t3 sp 4		# �������� ����� ������� � �� ���������� �� �����
	lw	t1 (t3)
	
	la 	t0, arrayA
	la 	t1, arrayB
	la	t2, n			
	lw	t2, (t2)		# n
	li 	t4, 2			# 2
	div	t3,  t2, t4		#���������� ��������� � ������� ��������� (m)
	rem	t5, t2, t4
	beqz	t5, after_m_icr		# ���� ����� ��������� �������� ����� ����������� m
	addi	t3, t3, 1
	after_m_icr:
	li	t6, 0
	fillB:
		li 	t4, 2
		rem	t5, t6, t4
		bnez	t5 odd_index	# ��������� ������ � ���������� � ������� ���������
		lw	t5, (t0)
		sw	t5, (t1)
		b	endfillcheck
		
		odd_index:		# ��������� ������ � ���������� � ��������� ���������
		li	t4, 4
		mul	t4, t4, t3	# ������� �������� �������� (� ����� �������� � �) � � ���������� �� ������� 
		add	t4, t1, t4	# ����������� �������� (� ��� �������� � �) �� ����� ������ ��������� � �
		lw	t5, (t0)
		sw	t5, (t4)
		addi	t1, t1, 4	# ������� ������ �� ��������� ������ �������
		
		endfillcheck:		# �������� �� ��������� �������
		addi	t6, t6, 1
		addi	t0, t0, 4
		bne	t6, t2, fillB
	
	lw	ra (sp)
	addi	sp sp 4
	ret

print_array:				# ����� �������
	.data
	arr:	.asciz	"Array:\n"
	space:	.asciz 	" "
	.text
	addi	sp sp -4
	sw	ra (sp)
	
	addi	t3 sp 4		# ���������� ��������� � ������� �� ���������� �� �����
	lw	t2 (t3)
	
	addi	t3 t3 4		# �������� ����� ������� �� ���������� �� �����
	lw	t1 (t3)
	
	la 	a0, arr      
        li 	a7, 4           
        ecall
	
	li t3, 0
	printArr:
		lw	t4, (t1)
		mv	a0, t4
		li	a7, 1
		ecall
		la 	a0, space      
        	li 	a7, 4           
        	ecall
		addi	t3, t3,  1
		addi	t1, t1, 4
		bne 	t3, t2, printArr
	lw	ra (sp)
	addi	sp sp 4	
	ret

