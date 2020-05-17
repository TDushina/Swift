import UIKit

//1. Написать функцию, которая определяет, четное число или нет.
func evenNumber(_ number: Int) {
    if number % 2 == 0 {
        print("Число чётное")
    } else {
        print("Число нечётное")
    }
}
evenNumber(100)

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func divisionBy3(_ number: Int) {
    if number % 3 == 0 {
        print("Число делится на 3")
    } else {
        print("Число не делится на 3")
    }
}
divisionBy3(99)

//3. Создать возрастающий массив из 100 чисел.
var lineArray =  Array(0...99)
print("------------------")
print("Возрастающий массив из 100 чисел: \n\(lineArray)")

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
for (_,element) in lineArray.enumerated() {
    if (element % 2 == 0) || (element % 3 != 0) {
        lineArray.remove(at: lineArray.firstIndex(of: element)!)
    }
}
print("------------------")
print("Возрастающий массив без чисел, кратных 2 и 3: \n\(lineArray)")
 
//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

// В случае использования целочисленного типа элементы массива превышают диапазон возможных хранимых в переменной значений
var fibonacciArray: [Double] = [0,1]
for _ in 1...98 {
    let fibonacciElement = fibonacciArray[fibonacciArray.count-1] + fibonacciArray[fibonacciArray.count-2]
    fibonacciArray.append(fibonacciElement)
}
print("------------------")
print("Числа Фибоначчи: \n\(fibonacciArray)")

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.

// создаём массив целых чисел от 2 до n, n = 1000
var numbersArray: [Int] = []
for number in 2...(1000) {
    numbersArray.append(number)
}

// первое простое число
var pNumber = numbersArray[0]
var simpleNumbersArray: [Int] = [pNumber]

// удаляем числа, кратные 2p, 3p, 4p, ...
// создаём массив простых чисел
func simpleNumbersArr() {
    for (_, _) in numbersArray.enumerated() {
        while simpleNumbersArray.count < 100 {
            numbersArray.removeAll(where: {($0 % pNumber) == 0})
            let nextNumber = numbersArray[0]
            simpleNumbersArray.append(nextNumber)
            numbersArray.removeFirst()
            pNumber += 1
        }; break
    }
}
simpleNumbersArr()
print("------------------")
print("Массив простых чисел: \n\(simpleNumbersArray)")
