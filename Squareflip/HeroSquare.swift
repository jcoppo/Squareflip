//
//  Square.swift
//  Squareflip
//
//  Created by Jayson Coppo on 4/12/18.
//  Copyright © 2018 Jayson Coppo. All rights reserved.
//

import Foundation
import SpriteKit

class HeroSquare: SKNode {
    
    var rectangle = SKShapeNode()
    
    override init() {
        super.init()
        
        rectangle = SKShapeNode(rectOf: CGSize(width: 80, height: 80))
        rectangle.fillColor = .white
        rectangle.strokeColor = UIColor(red: 0.7, green: 7.0, blue: 5.0, alpha: 1.0)
        rectangle.lineWidth = 10
        addChild(rectangle)
        
        let sprite = SKSpriteNode(imageNamed: "face")
        sprite.size = rectangle.frame.size
        addChild(sprite)
        
        physicsBody = SKPhysicsBody(rectangleOf: rectangle.frame.size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = true
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.friction = 0.5
        physicsBody?.restitution = 0.3
        physicsBody?.categoryBitMask = BitMask.Player
        physicsBody?.collisionBitMask = BitMask.Wall | BitMask.Enemy
        physicsBody?.contactTestBitMask = BitMask.Enemy | BitMask.Coin
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
