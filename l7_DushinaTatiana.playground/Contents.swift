import UIKit

//1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
//2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.

enum EngineState: String {
    case off = "двигатель заглушен"
    case start = "двигатель запущен"
}

enum WindowState: String {
    case opened = "окна открыты"
    case closed = "окна закрыты"
}

// Ошибки
enum CarError: Error {
    case overload
    case empty
}

class TrunkCar {
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

    func loadBody(tons: Int) throws {
        let maxTons = bodyState + tons
        // проверка на переполнение кузова
        guard maxTons < carrying else {
            throw CarError.overload
        }
        print("Загрузили \(tons) т, кузов загружен на \(bodyState) т")
        self.bodyState += tons
    }

    func unloadBody(tons: Int) throws {
        // проверка заполненности кузова
        guard (bodyState - tons) > 0 else {
            throw CarError.empty
        }
        print("Выгрузили \(tons) т, кузов загружен на \(bodyState) т")
        self.bodyState -= tons
    }
    
    func setEngineState(status: EngineState) {
        switch status {
        case .start:
            engineState = .start
        case .off:
            engineState = .off
        }
    }
    
    func setWindowState(status: WindowState) {
        switch status {
        case .opened:
            windowState = .opened
        case .closed:
            windowState = .closed
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    public var description: String {
        return "Марка грузового авто: \(self.brand), год выпуска \(year), грузоподъёмность \(carrying) тонн, кузов заполнен на \(bodyState) т, \(engineState.rawValue), \(windowState.rawValue)"
    }
    
    public var descriptionErrorOverload: String {
        return "Можно загрузить только \(carrying - bodyState) т, иначе перегруз"
    }
    
    public var descriptionErrorEmpty: String {
        return "Кузов заполнен только на  \(bodyState) т"
    }
}

var trunkCar1 = TrunkCar(brand: "MAN", year: 2015, engineState: .off, windowState: .closed, carrying: 20, bodyState: 15)

print(trunkCar1.description)

// перегруз
do {
    try trunkCar1.loadBody(tons: 5)
    print(trunkCar1.loadBody)
} catch CarError.overload {
    print(trunkCar1.descriptionErrorOverload)
}

// загружаем
do {
    try trunkCar1.loadBody(tons: 4)
    print(trunkCar1.loadBody)
} catch CarError.overload {
    print(trunkCar1.descriptionErrorOverload)
}

// выгружаем
do {
    try trunkCar1.unloadBody(tons: 15)
    print(trunkCar1.unloadBody)
} catch CarError.empty {
    print(trunkCar1.descriptionErrorEmpty)
}

// выгружаем больше, чем возможно
do {
    try trunkCar1.unloadBody(tons: 10)
    print(trunkCar1.unloadBody)
} catch CarError.empty {
    print(trunkCar1.descriptionErrorEmpty)
}

