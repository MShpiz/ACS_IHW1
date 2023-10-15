.include "input_output_lib.asm"

main:
.data
endl:	.asciz "\n"
test_txt: .asciz "Test "
arrayA: .space  40 	
endArrayA:
.align  2 
arrayB: .space  40 	
endArrayB:

.text 

	la	t0 arrayA
	
	li	t1 10
	mv	t2 zero
loop:				# заполняем тестовый массив числами от 0 до 9
	
        sw	t2 (t0)
	addi	t0 t0 4
	addi	t2 t2 1
	bne	t2 t1 loop
	
	
	addi 	sp sp -4		# передаем адрес начала массива B в качестве параметра
	la	t0, arrayB
	sw	t0, (sp)
	
	addi 	sp sp -4		# передаем адрес начала массива А в качестве параметра
	la	t0, arrayA
	sw	t0, (sp)
	
test3:
	print_str ("Test 3\n")
	la	t0 arrayA
	li	t1, 1
	print_array t1, t0
	

	addi 	sp sp -4
	li	t1, 1		# количество элементов в массиве А
	sw	t1, (sp)
	jal 	fill_array_b		# В качестве аргументов принимает количество элементов в массиве А, адрес массива А,
	addi	sp sp 4                # адрес массива В. Возвращает - ничего.
	la	t0 arrayB
	li	t1, 1
	print_array t1, t0
	print_str ("\n")
	
test4:
	print_str ("Test 4\n")
	la	t0 arrayA
	li	t1, 2
	print_array t1, t0
	

	addi 	sp sp -4
	li	t1, 2		# количество элементов в массиве А
	sw	t1, (sp)
	jal 	fill_array_b		# В качестве аргументов принимает количество элементов в массиве А, адрес массива А,
	addi	sp sp 4				# адрес массива В. Возвращает - ничего.
	la	t0 arrayB
	li	t1, 2
	print_array t1, t0
	print_str ("\n")
	
test5:
	print_str ("Test 5\n")
	la	t0 arrayA
	li	t1, 5
	print_array t1, t0
	

	addi 	sp sp -4
	li	t1, 5		# количество элементов в массиве А
	sw	t1, (sp)
	jal 	fill_array_b		# В качестве аргументов принимает количество элементов в массиве А, адрес массива А,
	addi	sp sp 4				# адрес массива В. Возвращает - ничего.
	la	t0 arrayB
	li	t1, 5
	print_array t1, t0
	print_str ("\n")
	
test6:
	print_str ("Test 6\n")
        la	t0 arrayA
	li	t1, 6
	print_array t1, t0
	
	
	addi 	sp sp -4
	li	t1, 6		# количество элементов в массиве А
	sw	t1, (sp)
	jal 	fill_array_b		# В качестве аргументов принимает количество элементов в массиве А, адрес массива А,
	addi	sp sp 4				# адрес массива В. Возвращает - ничего.
	la	t0 arrayB
	li	t1, 6
	print_array t1, t0
	print_str ("\n")
	
test7:
	print_str ("Test 7\n")
	la	t0 arrayA
	li	t1, 10
	print_array t1, t0
	

	addi 	sp sp -4
	li	t1, 10		# количество элементов в массиве А
	sw	t1, (sp)
	jal 	fill_array_b		# В качестве аргументов принимает количество элементов в массиве А, адрес массива А,
	addi	sp sp 4				# адрес массива В. Возвращает - ничего.
	la	t0 arrayB
	li	t1, 10
	print_array t1, t0
	print_str ("\n")
	

la	t0 arrayA	# увеличиваем значение каждого элемента А на 1
li	t1 11
li	t2 1
loop2:				# заполняем тестовый массив числами от 0 до 9
	sw	t2 (t0)
	addi	t0 t0 4
	addi	t2 t2 1
	bne	t2 t1 loop2

test8:
	print_str ("Test 8\n")
	la	t0 arrayA
	li	t1, 10
	print_array t1, t0

	addi 	sp sp -4
	li	t1, 10		# количество элементов в массиве А
	sw	t1, (sp)
	jal 	fill_array_b		# В качестве аргументов принимает количество элементов в массиве А, адрес массива А,
	addi	sp sp 4				# адрес массива В. Возвращает - ничего.
	la	t0 arrayB
	li	t1, 10
	print_array t1, t0
	print_str ("\n")
	
	
	

li	a7 10
ecall
