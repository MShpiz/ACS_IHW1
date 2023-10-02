# 36
.data
sep:    .asciz  "--------\n"    
prompt_n: .asciz  "how many elements are you going to enter? "         # Подсказка для ввода n
prompt: .asciz  "enter number "         # Подсказка для ввода числа
error:  .asciz  "incorrect n!\n"  # Сообщение о некорректном вводе
n:	.word	0		# Число введенных элементов массива
.align  2 
arrayA: .space  40 	
endArrayA:
.align  2 
arrayB: .space  40 	
endArrayB:

.text 
	la 	a0, prompt_n      # Подсказка для ввода числа элементов массива
        li 	a7, 4           
        ecall
        
        li      a7 5            # Системный вызов №5 — ввести десятичное число
        ecall
        mv      t3 a0           # Сохраняем результат в t3 (это n)
        ble     t3 zero fail    # На ошибку, если меньше 0
        
        li      t4 10           # Максимальный размер массива
        bgt     t3 t4 fail      # На ошибку, если больше 10
        
        la	t4 n		# Адрес n в t4
        sw	t3 (t4)		# Загрузка n в память на хранение
        
        la      t0 arrayA        # Указатель элемента массива
        li      t2 1            # Число, которое мы будем записывать в массив
        
fill:
	la 	a0, prompt      # Подсказка для ввода числа элементов массива
        li 	a7, 4           
        ecall
	li      a7 5            # Считываем число для сожения 
        ecall
        mv      t2 a0
	sw      t2 (t0)         # Запись числа по адресу в t0
        addi    t0 t0 4         # Увеличим адрес на размер слова в байтах
        addi    t3 t3 -1        # Уменьшим количество оставшихся элементов на 1
        bnez    t3 fill
        
end:
        li      a7 10           # Останов
        ecall


fail:
        la 	a0, error       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4
        ecall
        li      a7 10           # Останов
        ecall