# 36
.data
sep:    .asciz  "--------\n"    

error:  .asciz  "incorrect n!\n"  # Сообщение о некорректном вводе
n:	.word	0		# Число введенных элементов массива
.align  2 
arrayA: .space  40 	
endArrayA:
.align  2 
arrayB: .space  40 	
endArrayB:

.text 
	addi 	sp sp -4		# передаем адрес начала массива А в качестве параметра
	la	t0, arrayA
	sw	t0, (sp)
	
	jal 	enter_array
	beqz	a0, fail		# если элементов 0, сообщаем об ошибке
	
	la	t0 n			# cохраняем n
	sw	a0 (t0)
	addi 	sp sp -4		# очищаем стек от аргументов
	
	
	addi 	sp sp -4		# передаем адрес начала массива B в качестве параметра
	la	t0, arrayB
	sw	t0, (sp)
	
	addi 	sp sp -4		# передаем адрес начала массива А в качестве параметра
	la	t0, arrayA
	sw	t0, (sp)
	
	addi 	sp sp -4		# количество элементов в массиве А
	sw	a0, (sp)
	jal 	fill_array_b		# заполняем массив В
	
	addi	sp sp 12		# очищаем стек от аргументов
	
	addi 	sp sp -4		# передаем адрес начала массива B в качестве параметра
	la	t0, arrayB
	sw	t0, (sp)
	
	addi 	sp sp -4		# передаем количество элементов в массиве B
	la	t0, n
	lw	t0, (t0)
	sw	t0, (sp)

	jal	print_array		# выводим массив В
	addi	sp sp 8			# очищаем стек от аргументов
	li      a7 10           
        ecall
        
fail:
        la 	a0, error       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           
        ecall
        li      a7 10           
        ecall



enter_array:		# заполняет переданный массив А элементами введенными с клавиатуры, кол-во элементов
	.data
	prompt_n: .asciz  "how many elements are you going to enter? "         # Подсказка для ввода n
	prompt: .asciz  "enter number "         # Подсказка для ввода числа
	
	.text
	addi	sp sp -4
	sw	ra (sp)
	
	addi	t0 sp 4		# получаем адрес массива А из аргументов на стеке
	lw	t0 (t0)
	
	addi	sp sp -4	# загружаем начальное значаение n (локальная переменная) на стек
	sw	zero (sp)
	
	la 	a0, prompt_n      # Получаем количество элементов
        li 	a7, 4           
        ecall
        
        li      a7 5            
        ecall
        mv      t3 a0           
        ble     t3 zero end_fill    # зканчиваем функцию если введенное n <= 0
        
        li      t4 10           
        bgt     t3 t4 end_fill      # зканчиваем функцию если введенное n > 10
        
        sw	t3 (sp)		# Загрузка значения n в стек  
        
fill:
	la 	a0, prompt      # Ввод элементов массива А
        li 	a7, 4           
        ecall
	li      a7 5           
        ecall
        mv      t2 a0
	sw      t2 (t0)         # Запись элемента
        addi    t0 t0 4         
        addi    t3 t3 -1        
        bnez    t3 fill
	
	end_fill:
	
	lw	a0 (sp)		# возвращаем количество элементов в массиве А (n)
	addi	sp sp 4
	
	lw	ra (sp)
	addi	sp sp 4
	ret
        
fill_array_b:				# заполнение массива В (в начале элементы массива А с четными индексами, в конце - с нечетными)

	addi	sp sp -4
	sw	ra (sp)
	
	addi	t3 sp 4		# количество элементов в массиве А из аргументов на стеке
	lw	t2 (t3)
	addi	t3 sp 4		# получаем адрес массива А из аргументов на стеке
	lw	t0 (t3)
	addi	t3 sp 4		# получаем адрес массива В из аргументов на стеке
	lw	t1 (t3)
	
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
		mul	t4, t4, t3	# индескс текущего элемента (с нечет индексом в А) в В отличается от индекса 
		add	t4, t1, t4	# предыдущего элемента (с чет индексом в А) на число четных элементов в А
		lw	t5, (t0)
		sw	t5, (t4)
		addi	t1, t1, 4	# смещаем индекс на следующий четный элемент
		
		endfillcheck:		# преходим на следующий элемент
		addi	t6, t6, 1
		addi	t0, t0, 4
		bne	t6, t2, fillB
	
	lw	ra (sp)
	addi	sp sp 4
	ret

print_array:				# вывод массива
	.data
	arr:	.asciz	"Array:\n"
	space:	.asciz 	" "
	.text
	addi	sp sp -4
	sw	ra (sp)
	
	addi	t3 sp 4		# количество элементов в массиве из аргументов на стеке
	lw	t2 (t3)
	
	addi	t3 t3 4		# получаем адрес массива из аргументов на стеке
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
