.include "input_output_lib.asm"

main:
.data
arrayA: .space  40 	
endArrayA:
.align  2 
arrayB: .space  40 	
endArrayB:

.text 

	la	t0 arrayA
	
	li	t1 10
	mv	t2 zero
loop:				# ��������� �������� ������ ������� �� 0 �� 9
	sw	t2 (t0)
	addi	t0 t0 4
	addi	t2 t2 1
	bne	t2 t1 loop
	
	
	addi 	sp sp -4		# �������� ����� ������ ������� B � �������� ���������
	la	t0, arrayB
	sw	t0, (sp)
	
	addi 	sp sp -4		# �������� ����� ������ ������� � � �������� ���������
	la	t0, arrayA
	sw	t0, (sp)
	
test3:
	
	addi 	sp sp -4
	li	t1, 1		# ���������� ��������� � ������� �
	sw	t1, (sp)
	jal 	fill_array_b		# � �������� ���������� ��������� ���������� ��������� � ������� �, ����� ������� �,
					# ����� ������� �. ���������� - ������.
	la	t0 arrayB
	li	t1, 1
	print_array t1, t0
	addi	sp sp 4
test4:
	
	addi 	sp sp -4
	li	t1, 2		# ���������� ��������� � ������� �
	sw	t1, (sp)
	jal 	fill_array_b		# � �������� ���������� ��������� ���������� ��������� � ������� �, ����� ������� �,
					# ����� ������� �. ���������� - ������.
	la	t0 arrayB
	li	t1, 2
	print_array t1, t0
	addi	sp sp 4
test5:
	
	addi 	sp sp -4
	li	t1, 5		# ���������� ��������� � ������� �
	sw	t1, (sp)
	jal 	fill_array_b		# � �������� ���������� ��������� ���������� ��������� � ������� �, ����� ������� �,
					# ����� ������� �. ���������� - ������.
	la	t0 arrayB
	li	t1, 5
	print_array t1, t0
	addi	sp sp 4
test6:
	
	addi 	sp sp -4
	li	t1, 6		# ���������� ��������� � ������� �
	sw	t1, (sp)
	jal 	fill_array_b		# � �������� ���������� ��������� ���������� ��������� � ������� �, ����� ������� �,
					# ����� ������� �. ���������� - ������.
	la	t0 arrayB
	li	t1, 6
	print_array t1, t0
	addi	sp sp 4
test7:
	
	addi 	sp sp -4
	li	t1, 10		# ���������� ��������� � ������� �
	sw	t1, (sp)
	jal 	fill_array_b		# � �������� ���������� ��������� ���������� ��������� � ������� �, ����� ������� �,
					# ����� ������� �. ���������� - ������.
	la	t0 arrayB
	li	t1, 10
	print_array t1, t0
	addi	sp sp 4

la	t0 arrayA	# ����������� �������� ������� �������� � �� 1
li	t1 11
li	t2 1
loop2:				# ��������� �������� ������ ������� �� 0 �� 9
	sw	t2 (t0)
	addi	t0 t0 4
	addi	t2 t2 1
	bne	t2 t1 loop2

test8:
	
	addi 	sp sp -4
	li	t1, 10		# ���������� ��������� � ������� �
	sw	t1, (sp)
	jal 	fill_array_b		# � �������� ���������� ��������� ���������� ��������� � ������� �, ����� ������� �,
					# ����� ������� �. ���������� - ������.
	la	t0 arrayB
	li	t1, 10
	print_array t1, t0
	addi	sp sp 4

li	a7 10
ecall