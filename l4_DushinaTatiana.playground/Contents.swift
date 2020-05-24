import UIKit

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//3. Взять из прошлого урока enum с действиями над автомобилем.

enum EngineState: String {
    case start = "запущен"
    case off = "заглушен"
}

enum WindowState: String {
    case open = "открыты"
    case close = "закрыты"
}

// класс автомобиль
class Car {
    let brand: String                // марка
    let year: Int                  // год выпуска
    var engineState: EngineState      // состояние двигателя
    var windowState: WindowState      // состояние окон
    init(brand: String, year: Int, engineState: EngineState, windowState: WindowState) {
        self.brand = brand
        self.year = year
        self.engineState = engineState
        self.windowState = windowState
    }
    
    func description() {
        print("Марка авто: \(self.brand), год выпуска: \(self.year), двигатель \(self.engineState.rawValue), окна \(self.windowState.rawValue)")
    }
}

//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

// наследник грузовое авто
class TrunkCar: Car {
    let carrying: Int           // грузоподъемность
    var bodyState: Int         // заполненный кузов
    init(brand: String, year: Int, engineState: EngineState, windowState: WindowState, carrying: Int, bodyState: Int) {
        self.carrying = carrying
        self.bodyState = bodyState
        super.init(brand: brand, year: year, engineState: engineState, windowState: windowState)
    }
    
    func loadBody(tons: Int) {
        self.bodyState += tons
    }
    
    func unloadBody(tons: Int) {
        self.bodyState -= tons
    }
    
    // переопределяем функцию
    override func description() {
        print("Марка грузового авто: \(self.brand), год выпуска: \(self.year), двигатель \(self.engineState.rawValue), окна \(self.windowState.rawValue), грузоподъёмность \(carrying) тонн, кузов заполнен на \(bodyState) тонн")
    }
}

// наследник спортивное авто
enum RoofState: String {
    case raise = "поднята"
    case lower = "опущена"
}

class SportСar: Car {
    let trunkVolume: Int             // объём багажника
    var trunkState: Int              // заполненный объём багажника
    var roofState: RoofState        // крыша
    init(brand: String, year: Int, engineState: EngineState, windowState: WindowState, trunkVolume: Int, trunkState: Int, roofState: RoofState) {
        self.trunkVolume = trunkVolume
        self.trunkState = trunkState
        self.roofState = roofState
        super.init(brand: brand, year: year, engineState: engineState, windowState: windowState)
    }
    
    func loadTrunk(liters: Int) {
        self.trunkState += liters
    }
    
    func unloadTrunk(liters: Int) {
        self.trunkState -= liters
    }
    
    // переопределяем функцию
    override func description() {
        print("Марка спортивного авто: \(self.brand), год выпуска: \(self.year), двигатель \(self.engineState.rawValue), окна \(self.windowState.rawValue), объём багажника \(trunkVolume) литров, багажник заполнен на \(trunkState) литров, крыша \(roofState.rawValue)")
    }
}

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

let car1 = Car(brand: "LADA", year: 2015, engineState: .start, windowState: .close)
let trunkCar1 = TrunkCar(brand: "MAN", year: 2015, engineState: .start, windowState: .open, carrying: 20, bodyState: 0)
trunkCar1.loadBody(tons: 10)
let sportСar1 = SportСar(brand: "Porsche", year: 2020, engineState: .off, windowState: .close, trunkVolume: 100, trunkState: 100, roofState: .raise)
sportСar1.unloadTrunk(liters: 100)

//6. Вывести значения свойств экземпляров в консоль.
car1.description()
trunkCar1.description()
sportСar1.description()
