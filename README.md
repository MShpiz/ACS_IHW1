# ИДЗ по АВС №1
**Вариант:** 36 \
**Выполнила:** Панфилова Мария Денисовна \
**Группа:** БПИ226

## Текст варианта
Сформировать массив B из элементов массива A сгруппировав элементы с четными индексами в начале массива , а элементы с нечетными индексами сгруппировать в конце массива В.

## Решение на 6-7
1) В программе используются подпрограммы с передачей аргументов через параметры, отображаемые на стек. 
2) Внутри подпрограммы enter_array используется локальная переменная, которая при компиляции отображается на стек. В остальных подпрограммах локальные переменные, отображаемые на стек, не используются из-за избытка свободных регистров. 
3) В местах вызова функции добавлены комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата и отмечено, какая переменная или результат какого выражения соответствует тому или иному фактическому параметру. 
4) Информаця о проведенных изменениях отображена в отчете наряду с информацией, необходимой на предыдущую оценку. 

## Решение на 4-5 
1) Приведено [решение задачи на ассемблере](https://github.com/MShpiz/ACS_IHW1/tree/main/code). Ввод данных осуществляется с клавиатуры. Вывод данных осуществляется на дисплей.
2) В программе присутствуют комментарии, поясняющие выполняемые действия.
3) В следующем разделе отчета представлено полное тестовое покрытие. Приведены [результаты тестовых прогонов]().

## Тестирование
| № | N | массив А | массив B | сообщение об ошибке |
|---|---|----------|-----------|---------------------|
|1|0|| - | не верное N |
|2|11|1 2 3 4 5 6 7 8 9 10 11| - | не верное N |
|3|1|0| 0 | ✔ |
|4|2|0 1| 0 1 | ✔ |
|5|5|0 1 2 3 4| 0 2 4 1 3 | ✔ |
|6|6|0 1 2 3 4 5| 0 2 4 1 3 5 | ✔ |
|7|10|0 1 2 3 4 5 6 7 8 9| 0 2 4 6 8 1 3 5 7 9 | ✔ |
|7|10|1 2 3 4 5 6 7 8 9 10| 1 3 5 7 9 2 4 6 8 10 | ✔ |
мяу