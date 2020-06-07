import UIKit

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

struct queue<Objects: Comparable> {
    
    var queue = [Objects]()
    
    mutating func addInQueue(_ object: Objects) {
        return queue.append(object)
    }
    
    mutating func reInQueue() -> Objects {
        if queue.count > 0 {
            return queue.removeFirst()
        } else {
            return "В очереди никого нет!" as! Objects
        }
    }
}

var queueOfString = queue<String>()

queueOfString.addInQueue("первый")
queueOfString.addInQueue("второй")
queueOfString.addInQueue("третий")
queueOfString.addInQueue("четвёртый")
queueOfString.addInQueue("пятый")

queueOfString.reInQueue()
queueOfString.reInQueue()
queueOfString.reInQueue()
queueOfString.reInQueue()
queueOfString.reInQueue()
queueOfString.reInQueue()

//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
// метод сортировки по алфавиту

extension queue {
    mutating func sortedQueue() -> [Objects] {
        return queue.sorted(by: <)
    }
}

queueOfString.addInQueue("первый")
queueOfString.addInQueue("второй")
queueOfString.addInQueue("третий")
queueOfString.addInQueue("четвёртый")
queueOfString.addInQueue("пятый")

queueOfString
queueOfString.sortedQueue()

//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

extension queue {
    
    subscript(index: Int) -> String? {
        if index < self.queue.count {
            return (self.queue[index] as! String)
        } else {
            return nil
        }
    }
}
queueOfString[0]
queueOfString[2]
queueOfString[4]
queueOfString[10]
