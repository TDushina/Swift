import UIKit

//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.

// Перечисления с возможными действиями
// запустить/заглушить двигатель
enum EngineState: String {
    case start = "запущен"
    case off = "выключен"
}

// открыть/закрыть окнa
enum WindowState: String {
    case open = "открыты"
    case close = "закрыты"
}

// структура легковой автомобиль
struct car {
    let brand: String                // марка
    let year: Int                   // год выпуска
    let trunkVolume: Int             // объём багажника
    var trunkState: Int              // заполненный объём багажника
    var engineState: EngineState      // состояние двигателя
    var windowState: WindowState      // состояние окон
    
    func description() {
        print("Марка легкового авто: \(brand), год выпуска \(year) год, объём багажника \(trunkVolume) литров, заполненный объём багажника \(trunkState) литров, двигатель \(engineState.rawValue), окна \(windowState.rawValue)")
    }
    
    // метод, который будет менять свойства структуры
    mutating func loadTrunk(liters: Int) {
        self.trunkState += liters
    }
    
    mutating func unloadTrunk(liters: Int) {
        self.trunkState -= liters
    }
}

// структура грузовой авомобиль
struct truck {
    let brand: String
    let year: Int
    let carrying: Int           // грузоподъемность
    var bodyState: Int         // заполненный кузов
    var engineState: EngineState
    var windowState: WindowState
    
    func description() {
        print("Марка грузового авто: \(brand), год выпуска \(year) год, грузоподъёмность \(carrying) тонн, кузов заполнен на \(bodyState) тонн, двигатель \(engineState.rawValue), окна \(windowState.rawValue)")
    }
    
    // метод, который будет менять свойства структуры
    mutating func loadBody(tons: Int) {
        self.bodyState += tons
    }
    
    mutating func unloadBody(tons: Int) {
        self.bodyState -= tons
    }
}

//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
var tesla = car(brand: "Tesla", year: 2020, trunkVolume: 745, trunkState: 0, engineState: .off, windowState: .close)
tesla.loadTrunk(liters: 5)
var lada = car(brand: "ВАЗ", year: 1985, trunkVolume: 900, trunkState: 50, engineState: .start, windowState: .open)
var kamaz = truck(brand: "Камаз", year: 2015, carrying: 16, bodyState: 10, engineState: .off, windowState: .open)
var man = truck(brand: "MAN", year: 2018, carrying: 20, bodyState: 20, engineState: .start, windowState: .close)
man.unloadBody(tons: 20)

//6. Вывести значения свойств экземпляров в консоль.
tesla.description()
lada.description()
kamaz.description()
man.description()
