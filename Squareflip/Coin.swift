//
//  Coin.swift
//  Squareflip
//
//  Created by Jayson Coppo on 4/14/18.
//  Copyright © 2018 Jayson Coppo. All rights reserved.
//
import SpriteKit

class Coin: SKNode {
    
    var circle = SKShapeNode()
    let radius: CGFloat = 35
    var xSpeed = CGFloat()
    
    override init() {
        super.init()
        
        circle = SKShapeNode(circleOfRadius: radius)
        circle.fillColor = UIColor(hue: 0.14, saturation: 0.3, brightness: 1, alpha: 1)
        circle.strokeColor = UIColor(hue: 0.14, saturation: 1.0, brightness: 1, alpha: 1)
        circle.lineWidth = 10
        addChild(circle)
        
        let sprite = SKSpriteNode(imageNamed: "face")
        sprite.size = CGSize(width: radius, height: radius)
        addChild(sprite)
        
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = true
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.friction = 0.5
        physicsBody?.restitution = 0.5
        physicsBody?.categoryBitMask = BitMask.Coin
        physicsBody?.collisionBitMask = UInt32()
        physicsBody?.contactTestBitMask = BitMask.Player
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
