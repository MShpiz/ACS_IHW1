.macro enter_array %x		# получает от пользователя количество элементов в массив и 
				#заполняет переданный массив А элементами введенными с клавиатуры 
				# %x - адрес массива
	.data
	prompt_n: .asciz  "how many elements are you going to enter? "         # Подсказка для ввода n
	prompt: .asciz  "enter number "         # Подсказка для ввода числа
	
	.text
	
	
	mv	t0 %x		# получаем адрес массива А из аргументов на стеке
	
	addi	sp sp -4	# загружаем начальное значаение n (локальная переменная) на стек
	sw	zero (sp)
	
	la 	a0, prompt_n      # Получаем количество элементов
        li 	a7, 4           
        ecall
        
        li      a7 5            
        ecall
        mv      t3 a0           
        ble     t3 zero fail    # сообщаем об ошибке если введенное n <= 0
        
        li      t4 10           
        bgt     t3 t4 fail      # сообщаем об ошибке  если введенное n > 10
        
        b fill_prep		# переходим к подготовке к заполнению.
        
        fail:
        la 	a0, error       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           
        ecall
        b end_fill		# Пропускаем ввод массива
        
        fill_prep:
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
.end_macro

.macro print_array %x %y				# выводит массив, %x - количество элементов, %y - адрес массива
	.data
	arr:	.asciz	"Array:\n"
	space:	.asciz 	" "
	endl:	.asciz "\n"
	.text
				# так как не изветно какие именно это регистры
				# сохраним содержимое регистров x и y на стек (!локальные переменные),
				# а затем положим в те регистры в которые мне удобнее.
	addi 	sp sp -4	
	sw 	%x (sp)
	
	addi 	sp sp -4
	sw 	%y (sp)
	
	lw	t1 (sp)
	addi	sp sp 4
	lw	t2 (sp)
	addi	sp sp 4
	
	la 	a0, arr      	# выводим строчку с подсказкой
        li 	a7, 4           
        ecall
	
	li t3, 0
	printArr:
		lw	t4, (t1)	# выводим число
		mv	a0, t4
		li	a7, 1
		ecall
		la 	a0, space      # выводим пробел
        	li 	a7, 4           
        	ecall
		addi	t3, t3,  1	# проверка условия выходя из цикла
		addi	t1, t1, 4
		bne 	t3, t2, printArr
	la 	a0, endl
	li	a7, 4
	ecall
.end_macro