import UIKit

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

protocol Car {
    var brand: String {get}
    var year: Int {get}
    var engineState: EngineState {get set}
    var windowState: WindowState {get set}
}

//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

enum EngineState: String {
    case off = "двигатель заглушен"
    case start = "двигатель запущен"
}

enum WindowState: String {
    case opened = "окна открыты"
    case closed = "окна закрыты"
}

extension Car {

    mutating func engineOff() {
        engineState = .off
    }

    mutating func engineStart() {
        engineState = .start
    }

    mutating func windowClosed() {
        self.windowState = .closed
    }

    mutating func windowOpened() {
        self.windowState = .opened
    }
}

//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class TrunkCar: Car {
    var brand: String
    var year: Int
    var engineState: EngineState
    var windowState: WindowState
    var carrying: Int
    var bodyState: Int
    init(brand: String, year: Int, engineState: EngineState, windowState: WindowState, carrying: Int, bodyState: Int) {
        self.brand = brand
        self.year = year
        self.engineState = engineState
        self.windowState = windowState
        self.carrying = carrying
        self.bodyState = bodyState
        }

    func loadBody(tons: Int) {
        self.bodyState += tons
    }

    func unloadBody(tons: Int) {
        self.bodyState -= tons
    }
}

enum RoofState: String {
    case raise = "крыша поднята"
    case lower = "крыша опущена"
}

class SportСar: Car {
    var brand: String
    var year: Int
    var engineState: EngineState
    var windowState: WindowState
    let trunkVolume: Int
    var trunkState: Int
    var roofState: RoofState
    
    init(brand: String, year: Int, engineState: EngineState, windowState: WindowState, trunkVolume: Int, trunkState: Int, roofState: RoofState) {
        self.brand = brand
        self.year = year
        self.engineState = engineState
        self.windowState = windowState
        self.trunkVolume = trunkVolume
        self.trunkState = trunkState
        self.roofState = roofState
    }

    func loadTrunk(liters: Int) {
        self.trunkState += liters
    }

    func unloadTrunk(liters: Int) {
        self.trunkState -= liters
    }
}

//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension TrunkCar: CustomStringConvertible {
    public var description: String {
        return "Марка грузового авто: \(self.brand), год выпуска \(year), грузоподъёмность \(carrying) тонн, кузов заполнен на \(bodyState) тонн, \(engineState.rawValue), \(windowState.rawValue)"
    }
}

extension SportСar: CustomStringConvertible {
    public var description: String {
        return "Марка спортивного авто: \(self.brand), год выпуска \(self.year), объём багажника \(trunkVolume) литров, багажник заполнен на \(trunkState) литров, \(engineState.rawValue), \(windowState.rawValue), \(roofState.rawValue)"
    }
}

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
var trunkCar1 = TrunkCar(brand: "MAN", year: 2015, engineState: .off, windowState: .closed, carrying: 20, bodyState: 0)
trunkCar1.loadBody(tons: 10)
trunkCar1.engineStart()
trunkCar1.windowOpened()

var sportСar1 = SportСar(brand: "Porsche", year: 2020, engineState: .off, windowState: .opened, trunkVolume: 100, trunkState: 100, roofState: .lower)
sportСar1.unloadTrunk(liters: 100)
sportСar1.engineStart()
sportСar1.windowOpened()

//6. Вывести сами объекты в консоль.
print(trunkCar1.description)
print(sportСar1.description)
