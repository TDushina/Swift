import UIKit

//1. Решить квадратное уравнение.
//Уравнение имеет вид ax2 + bx + c = 0

let a:Float = 1
let b:Float = -6
let c:Float = 9

//Находим дискриминант
let discriminant:Float = b * b - 4 * a * c

//Находим корень
if discriminant < 0 {
    print("Дискриминант меньше 0. Корней нет")
} else if discriminant == 0 {
    let answer:Float = (-b + sqrtf(discriminant)) / 2 * a
    print("Дискриминант равен 0. Уравнение имеет один корень: x = \(answer)")
} else if discriminant > 0 {
    let answerFirst:Float = (-b + sqrtf(discriminant)) / (2 * a)
    let answerSecond:Float = (-b - sqrtf(discriminant)) / (2 * a)
    print("Дискриминант больше 0. Уравнение имеет два корня.\n x1 = \(answerFirst), x2 = \(answerSecond)")
}


//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
let cathetusFirst = 1
let cathetusSecond = 3

//Находим площадь
let areaOfTriangle:Double = 0.5 * Double(cathetusFirst) * Double(cathetusSecond)
print("Площадь треугольника равна \(round(areaOfTriangle * 10) / 10)")

//Находим гипотенузу
let gipotenuse:Double = Double((sqrtf(Float(pow(Double(cathetusFirst), 2) + pow(Double(cathetusSecond), 2)))))
print("Гипотенуза равна \(round(gipotenuse * 10) / 10)")

//Находим периметр
let perimetr = Double(cathetusFirst) + Double(cathetusSecond) + gipotenuse
print("Периметр равен \(round(perimetr * 10) / 10)")


//3. *Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
var summ:Double = 10000 // сумма вклада
var percent:Double = 9 // процент начисления

percent = percent / 100

for i in 1...5 {
    summ = round(summ + summ * percent)
    print("\(i) год: \(summ) руб.")
}
