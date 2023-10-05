# 36
.data
sep:    .asciz  "--------\n"    
prompt_n: .asciz  "how many elements are you going to enter? "         # Подсказка для ввода n
prompt: .asciz  "enter number "         # Подсказка для ввода числа
error:  .asciz  "incorrect n!\n"  # Сообщение о некорректном вводе
arrb:	.asciz	"Array b:\n"
space:	.asciz 	" "
n:	.word	0		# Число введенных элементов массива
.align  2 
arrayA: .space  40 	
endArrayA:
.align  2 
arrayB: .space  40 	
endArrayB:

.text 
	jal 	fill_array_a
	jal 	fill_array_b
	jal	print_array_b
	li      a7 10           
        ecall



fill_array_a:
	la 	a0, prompt_n      # Подсказка для ввода числа элементов массива
        li 	a7, 4           
        ecall
        
        li      a7 5            
        ecall
        mv      t3 a0           
        ble     t3 zero fail    # На ошибку, если меньше 0
        
        li      t4 10           # Максимальный размер массива
        bgt     t3 t4 fail      # На ошибку, если больше 10
        
        la	t4 n		# n 
        sw	t3 (t4)		# Загрузка n в память на хранение
        
        la      t0 arrayA        
        
fill:
	la 	a0, prompt      # Подсказка для ввода числа элементов массива
        li 	a7, 4           
        ecall
	li      a7 5            # Считываем число для записи 
        ecall
        mv      t2 a0
	sw      t2 (t0)         # Загружаем число
        addi    t0 t0 4         # переходим на следующий элемент
        addi    t3 t3 -1        
        bnez    t3 fill
	
	ret
        
fill_array_b:
	la 	t0, arrayA
	la 	t1, arrayB
	la	t2, n			
	lw	t2, (t2)		# n
	li 	t4, 2			# 2
	div	t3,  t2, t4		#количество элементов с четными индексами (m)
	rem	t5, t2, t4
	beqz	t5, after_m_icr		# если всего элементво нечетное число увеличиваем m
	addi	t3, t3, 1
	after_m_icr:
	li	t6, 0
	fillB:
		li 	t4, 2
		rem	t5, t6, t4
		bnez	t5 odd_index	# заполняем массив В элементами с четными индексами
		lw	t5, (t0)
		sw	t5, (t1)
		b	endfillcheck
		
		odd_index:		# заполняем массив В элементами с нечетными индексами
		li	t4, 4
		mul	t4, t4, t3	
		add	t4, t1, t4
		lw	t5, (t0)
		sw	t5, (t4)
		addi	t1, t1, 4
		
		endfillcheck:		# преходим на следующий элемент
		addi	t6, t6, 1
		addi	t0, t0, 4
		bne	t6, t2, fillB
	ret

print_array_b:				# вывод массива
	la 	a0, arrb      
        li 	a7, 4           
        ecall
	la 	t1, arrayB
	la	t2, n			
	lw	t2, (t2)
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
	ret

fail:
        la 	a0, error       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           
        ecall
        li      a7 10           
        ecall
