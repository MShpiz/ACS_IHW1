.macro enter_array %x, %max_n		# получает от пользовател€ количество элементов в массив и 
				#заполн€ет переданный массив ј элементами введенными с клавиатуры 
				# %x - адрес массива, max_n - наибольшее возможное число элементов массива
	.data
	prompt_n: .asciz  "how many elements are you going to enter? "         # ѕодсказка дл€ ввода n
	prompt: .asciz  "enter number "         # ѕодсказка дл€ ввода числа
	
	.text
	# загружаем переданные значени€ на стек и затем перераспредел€ем между нужными регистрами,
	# тк не известно какие именно регистры были переданны и чтобы не затереть данные при использовании других регистров.
	addi 	sp sp -4	
	sw 	%max_n (sp)
	
	addi 	sp sp -4
	sw 	%x (sp)
	
	lw	t0 (sp)
	addi	sp sp 4
	
	lw	t4 (sp)
	addi	sp sp 4
	
	addi	sp sp -4	# загружаем начальное значаение n (!локальна€ переменна€) на стек
	sw	zero (sp)
	
	la 	a0, prompt_n      # ѕолучаем количество элементов
        li 	a7, 4           
        ecall
        
        li      a7 5            
        ecall
        mv      t3 a0           
        ble     t3 zero fail    # сообщаем об ошибке если введенное n <= 0
                  
        bgt     t3 t4 fail      # сообщаем об ошибке  если введенное n > max_n
        
        b fill_prep		# переходим к подготовке к заполнению.
        
        fail:
        la 	a0, error       # —ообщение об ошибке ввода числа элементов массива
        li 	a7, 4           
        ecall
        b end_fill		# ѕропускаем ввод массива
        
        fill_prep:
        sw	t3 (sp)		# «агрузка значени€ n в стек  
        
fill:
	la 	a0, prompt      # ¬вод элементов массива ј
        li 	a7, 4           
        ecall
	li      a7 5           
        ecall
        mv      t2 a0
	sw      t2 (t0)         # «апись элемента
        addi    t0 t0 4         
        addi    t3 t3 -1        
        bnez    t3 fill
	
	end_fill:
	
	lw	a0 (sp)		# возвращаем количество элементов в массиве ј (n)
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
		addi	t3, t3,  1	# проверка услови€ выход€ из цикла
		addi	t1, t1, 4
		bne 	t3, t2, printArr
	la 	a0, endl
	li	a7, 4
	ecall
.end_macro
