//
//  GameScene.swift
//  Snake
//
//  Created by Татьяна Душина on 08.06.2020.
//  Copyright © 2020 Татьяна Душина. All rights reserved.
//

import SpriteKit
import GameplayKit

//Категория пересечения объектов
struct CollisionCategories {
    //тело змеи
    static let Snake: UInt32 = 0x1 << 0
    //голова змеи
    static let SnakeHead: UInt32 = 0x1 << 1
    //яблоко
    static let Apple: UInt32 = 0x1 << 2
    //край сцены (экрана)
    static let EdgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var snake: Snake?

    //вызывается при первом запуске сцены
    override func didMove(to view: SKView) {
        
        //цвет фона сцены
        backgroundColor = SKColor.black
        //вектор и сила гравитации
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        //добавляем поддержку физики
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        //выключаем внешние воздействия на игру
        self.physicsBody?.allowsRotation = false
        //включаем отображение отладочной информации
        view.showsPhysics = true
        
        //делаем нашу сцену делегатом соприкосновения
        self.physicsWorld.contactDelegate = self
        
        //Повор против часовой стрелки
        //создаём ноду (объект)
        let counterClockwiseButton = SKShapeNode()
        //задаём форму круга
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        //указываем координаты размещения
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        //цвет заливки
        counterClockwiseButton.fillColor = UIColor.gray
        //цвет рамки
        counterClockwiseButton.strokeColor = UIColor.gray
        //толщина рамки
        counterClockwiseButton.lineWidth = 10
        
        //имя объекта для взаимодействия
        counterClockwiseButton.name = "counterClockwiseButton"
        
        //добавляем на сцену
        self.addChild(counterClockwiseButton)
        
        //Поворот по часовой стрелке
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX-80, y: view.scene!.frame.minY+30)
        clockwiseButton.fillColor = UIColor.gray
        clockwiseButton.strokeColor = UIColor.gray
        clockwiseButton.lineWidth = 10
        
        clockwiseButton.name = "clockwiseButton"
        
        self.addChild(clockwiseButton)
        
        //метод создания яблока
        createApple()
        //создаём змею по центру экрана и добавляем её на сцену
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        //устанавливаем категорию взаимодействия с другими объектами
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        //устанавливаем категории, с которыми будут соприкосаться края сцены
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
    }
    
    //создаём яблоко в случайной точке сцены
    func createApple() {
        
        //случайная точка на экране
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)) + 1)
        
        //создаём яблоко
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        //добавляем яблоко на сцену
        self.addChild(apple)
    }
    
    //вызывается при нажатии на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //перебираем все точки, куда прикоснулся палец
        for touch in touches {
            
            //определяем координаты касания для точки
            let touchLocation = touch.location(in: self)
            //проверяем, есть ли объект по этим координатам, и если есть, то не наша ли это кнопка
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,touchNode.name == "counterClockwiseButton" || touchNode.name == "clockwiseButton" else {
                return
            }
            
            //если это наша кнопка, заливаем её зелёным
            touchNode.fillColor = .green
            
            //определяем какая точка нажата, и поворачиваем в нужную сторону
            if touchNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
    }
    
    //вызывается при прекращении нажатия на экран
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //повторяем всё тоже самое для действия, когда палец отрывается от экрана
        for touch in touches {
            
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,touchNode.name == "counterClockwiseButton" || touchNode.name == "clockwiseButton" else {
                return
            }
            //но делаем цвет снова серым
            touchNode.fillColor = .gray
        }
    }
    
    //вызывается при обрыве нажатия на экран, например, если телефон примет звонок и свернет приложение
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    //вызывается при обработке кадров сцены
    override func update(_ currentTime: TimeInterval) {
        //вызываем метод движения змейки
        snake!.move()
    }
}
//имплементируем протокол взаимодействия (соприкосновения)
extension GameScene: SCNPhysicsContactDelegate {
    
    //добавляем метод отслеживания начала столкновения
    func didBegin(_ contact: SKPhysicsContact) {
        
        //логическая сумма масок, соприкоснувшихся объектов
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        //вычитаем из суммы голову змеи и у нас остаётся маска второго объекта
        let collisionObject = bodyes - CollisionCategories.SnakeHead
        
        //проверяем что это за второй объект
        switch collisionObject {
        case CollisionCategories.Apple: //проверяем, что это яблоко
            //яблоко это один из двух объектов, которые соприкоснулись. Используем тернарный оператор, чтобы вычеслить какой именно
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            //добавляем к змее ещё одну секцию
            snake?.addBodyPart()
            //удаляем съеденное яблоко со сцены
            apple?.removeFromParent()
            //создаём новое яблоко
            createApple()
        case CollisionCategories.EdgeBody: //проверяем, что это стенка экрана
            //соприкосновение со стенкой - ДЗ
            break
        default:
            break
        }
    }
}
