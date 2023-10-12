.global fill_array_b

fill_array_b:				# ���������� ������� � (� ������ �������� ������� � � ������� ���������, � ����� - � ���������)

	addi	sp sp -4
	sw	ra (sp)
	
	addi	t3 sp 4		# ���������� ��������� � ������� � �� ���������� �� �����
	lw	t2 (t3)
	addi	t3 t3 4		# �������� ����� ������� � �� ���������� �� �����
	lw	t0 (t3)
	addi	t3 t3 4		# �������� ����� ������� � �� ���������� �� �����
	lw	t1 (t3)
			
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