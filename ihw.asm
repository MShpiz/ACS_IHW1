# 36
.data
sep:    .asciz  "--------\n"    
prompt_n: .asciz  "how many elements are you going to enter? "         # ��������� ��� ����� n
prompt: .asciz  "enter number "         # ��������� ��� ����� �����
error:  .asciz  "incorrect n!\n"  # ��������� � ������������ �����
n:	.word	0		# ����� ��������� ��������� �������
.align  2 
arrayA: .space  40 	
endArrayA:
.align  2 
arrayB: .space  40 	
endArrayB:

.text 
	la 	a0, prompt_n      # ��������� ��� ����� ����� ��������� �������
        li 	a7, 4           
        ecall
        
        li      a7 5            # ��������� ����� �5 � ������ ���������� �����
        ecall
        mv      t3 a0           # ��������� ��������� � t3 (��� n)
        ble     t3 zero fail    # �� ������, ���� ������ 0
        
        li      t4 10           # ������������ ������ �������
        bgt     t3 t4 fail      # �� ������, ���� ������ 10
        
        la	t4 n		# ����� n � t4
        sw	t3 (t4)		# �������� n � ������ �� ��������
        
        la      t0 arrayA        # ��������� �������� �������
        li      t2 1            # �����, ������� �� ����� ���������� � ������
        
fill:
	la 	a0, prompt      # ��������� ��� ����� ����� ��������� �������
        li 	a7, 4           
        ecall
	li      a7 5            # ��������� ����� ��� ������� 
        ecall
        mv      t2 a0
	sw      t2 (t0)         # ������ ����� �� ������ � t0
        addi    t0 t0 4         # �������� ����� �� ������ ����� � ������
        addi    t3 t3 -1        # �������� ���������� ���������� ��������� �� 1
        bnez    t3 fill
        
end:
        li      a7 10           # �������
        ecall


fail:
        la 	a0, error       # ��������� �� ������ ����� ����� ��������� �������
        li 	a7, 4           # ��������� ����� �4
        ecall
        li      a7 10           # �������
        ecall