//
//  Floor.swift
//  Squareflip
//
//  Created by Jayson Coppo on 4/12/18.
//  Copyright © 2018 Jayson Coppo. All rights reserved.

import Foundation
import SpriteKit

class Floor: SKNode {
    
    var rectangle = SKShapeNode()
    
    override init() {
        super.init()
        
        rectangle = SKShapeNode(rectOf: CGSize(width: 1000, height: 500))
        rectangle.fillColor = UIColor(red: 0.7, green: 0.4, blue: 0.5, alpha: 1.0)
        rectangle.strokeColor = UIColor(red: 0.6, green: 0.3, blue: 0.4, alpha: 1.0)
        rectangle.lineWidth = 10
        addChild(rectangle)
        
        physicsBody = SKPhysicsBody(rectangleOf: rectangle.frame.size)
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0.5
        physicsBody?.restitution = 0.2
//        physicsBody?.categoryBitMask = UInt32()
//        physicsBody?.collisionBitMask = UInt32()
//        physicsBody?.contactTestBitMask = UInt32()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
