.macro enter_array %x, %max_n		# �������� �� ������������ ���������� ��������� � ������ � 
				#��������� ���������� ������ � ���������� ���������� � ���������� 
				# %x - ����� �������, max_n - ���������� ��������� ����� ��������� �������
	.data
	prompt_n: .asciz  "how many elements are you going to enter? "         # ��������� ��� ����� n
	prompt: .asciz  "enter number "         # ��������� ��� ����� �����
	
	.text
	# ��������� ���������� �������� �� ���� � ����� ���������������� ����� ������� ����������,
	# �� �� �������� ����� ������ �������� ���� ��������� � ����� �� �������� ������ ��� ������������� ������ ���������.
	addi 	sp sp -4	
	sw 	%max_n (sp)
	
	addi 	sp sp -4
	sw 	%x (sp)
	
	lw	t0 (sp)
	addi	sp sp 4
	
	lw	t4 (sp)
	addi	sp sp 4
	
	addi	sp sp -4	# ��������� ��������� ��������� n (!��������� ����������) �� ����
	sw	zero (sp)
	
	la 	a0, prompt_n      # �������� ���������� ���������
        li 	a7, 4           
        ecall
        
        li      a7 5            
        ecall
        mv      t3 a0           
        ble     t3 zero fail    # �������� �� ������ ���� ��������� n <= 0
                  
        bgt     t3 t4 fail      # �������� �� ������  ���� ��������� n > max_n
        
        b fill_prep		# ��������� � ���������� � ����������.
        
        fail:
        la 	a0, error       # ��������� �� ������ ����� ����� ��������� �������
        li 	a7, 4           
        ecall
        b end_fill		# ���������� ���� �������
        
        fill_prep:
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
.end_macro

.macro print_array %x %y				# ������� ������, %x - ���������� ���������, %y - ����� �������
	.data
	arr:	.asciz	"Array:\n"
	space:	.asciz 	" "
	endl:	.asciz "\n"
	.text
				# ��� ��� �� ������� ����� ������ ��� ��������
				# �������� ���������� ��������� x � y �� ���� (!��������� ����������),
				# � ����� ������� � �� �������� � ������� ��� �������.
	addi 	sp sp -4	
	sw 	%x (sp)
	
	addi 	sp sp -4
	sw 	%y (sp)
	
	lw	t1 (sp)
	addi	sp sp 4
	
	lw	t2 (sp)
	addi	sp sp 4
	
	la 	a0, arr      	# ������� ������� � ����������
        li 	a7, 4           
        ecall
	
	li t3, 0
	printArr:
		lw	t4, (t1)	# ������� �����
		mv	a0, t4
		li	a7, 1
		ecall
		la 	a0, space      # ������� ������
        	li 	a7, 4           
        	ecall
		addi	t3, t3,  1	# �������� ������� ������ �� �����
		addi	t1, t1, 4
		bne 	t3, t2, printArr
	la 	a0, endl
	li	a7, 4
	ecall
.end_macro
