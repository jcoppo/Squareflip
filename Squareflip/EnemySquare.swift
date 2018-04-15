//
//  DamageSqure.swift
//  Squareflip
//
//  Created by Jayson Coppo on 4/14/18.
//  Copyright © 2018 Jayson Coppo. All rights reserved.
//


import Foundation
import SpriteKit

class EnemySquare: SKNode {
    
    var rectangle = SKShapeNode()
    var width = CGFloat()
    var xSpeed = CGFloat()
    
    init(width: CGFloat) {
        super.init()
        
        self.width = width 
        
        rectangle = SKShapeNode(rectOf: CGSize(width: width, height: width))
//        rectangle.fillColor = .red
        rectangle.strokeColor = UIColor(red: 0.7, green: 7.0, blue: 5.0, alpha: 1.0)
        rectangle.lineWidth = 7
        addChild(rectangle)
        
        let sprite = SKSpriteNode(imageNamed: "red face")
        sprite.size = CGSize(width: rectangle.frame.width-14, height: rectangle.frame.height-14)
        addChild(sprite)
        
        physicsBody = SKPhysicsBody(rectangleOf: rectangle.frame.size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = true
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.friction = 0.5
        physicsBody?.restitution = 0.3
        physicsBody?.categoryBitMask = BitMask.Enemy
        physicsBody?.collisionBitMask = BitMask.Player
        physicsBody?.contactTestBitMask = BitMask.Player
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
