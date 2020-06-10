//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Татьяна Душина on 09.06.2020.
//  Copyright © 2020 Татьяна Душина. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    
    let diametr = 10
    
    //добавляем конструктор
    init(atPoint point: CGPoint) {
        super.init()
        
        //рисуем круглый элемент
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        //цвет рамки и заливки зелёный
        fillColor = UIColor.green
        strokeColor = UIColor.green
        //ширина рамки 5 поинтов
        lineWidth = 5
        
        //размещаем элемент в переданной точке
        self.position = point
        
        //создаём физическое тело
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center: CGPoint(x:5, y:5))
        //может перемещаться в пространстве
        self.physicsBody?.isDynamic = true
        
        //категория - змея
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        
        //пересекается с границами экрана и яблоком
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



