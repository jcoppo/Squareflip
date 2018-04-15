//
//  GameScene.swift
//  Squareflip
//
//  Created by Jayson Coppo on 4/12/18.
//  Copyright © 2018 Jayson Coppo. All rights reserved.
//

import SpriteKit
import GameplayKit

struct BitMask {
    static let Player: UInt32 = 0x1 << 0
    static let Enemy: UInt32  = 0x1 << 1
    static let Wall: UInt32 = 0x1 << 2
    static let Coin: UInt32 = 0x1 << 3

}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var points = 0
    var hero = HeroSquare()
    var floorHeight = CGFloat()
    var spawnPoint = CGPoint()
    let outOfScreenMargin: CGFloat = 100
    let jumpSpeed_Y: CGFloat = 800
    let jumpSpeed_X: CGFloat = 300
    let minEnemySpeed: CGFloat = 2
    let maxEnemySpeed: CGFloat = 6
    var score = 0
    var best = 0
    let scoreLabel = GameLabel()
    let bestLabel = GameLabel()

    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -12)
        physicsWorld.contactDelegate = self

        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        physicsBody?.categoryBitMask = BitMask.Wall
        physicsBody?.collisionBitMask = BitMask.Enemy
        
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height-80)
        addChild(scoreLabel)
        scoreLabel.label.text = "\(score)"
        
        bestLabel.position = CGPoint(x: 10, y: size.height-40)
        addChild(bestLabel)
        bestLabel.label.fontSize = 40
        bestLabel.label.horizontalAlignmentMode = .left
        bestLabel.label.text = "Best: \(score)"
        
        let floor = Floor()
        floor.position = CGPoint(x: size.width/2, y: 0)
        addChild(floor)
        
        floorHeight = floor.rectangle.frame.height/2
        
        spawnPoint = CGPoint(x: size.width/2, y: floorHeight)
        
        hero.position = spawnPoint
        addChild(hero)
        
        let enemyWidths: [CGFloat] = [50, 100, 150]
        
        for i in 0..<3 {
            let enemy = EnemySquare(width: enemyWidths[i])
            enemy.position.x = random(0, size.width)
            enemy.position.y = random(floorHeight+100, size.height)
            addChild(enemy)
            enemy.xSpeed = random(minEnemySpeed, maxEnemySpeed)
        }
        
        newCoin()
    }
    
    func newCoin() {
        let coin = Coin()
        coin.position.x = size.width + outOfScreenMargin
        coin.position.y = random(floorHeight, size.height)
        addChild(coin)
        coin.xSpeed = random(minEnemySpeed, maxEnemySpeed)
    }
    
    func playerScores() {
        score += 1
        scoreLabel.label.text = "\(score)"
    }
    
    func playerDied() {
        
        hero.removeFromParent()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block:{_ in
            let newHero = HeroSquare()
            self.hero = newHero
            self.addChild(newHero)
            newHero.position = self.spawnPoint
        })
        
        if score > best {
            best = score
            bestLabel.label.text = "Best: \(best)"
            bestLabel.pulse()
        }
        
        score = 0
        scoreLabel.label.text = "\(score)"
    }
    
    func deathEffect(position: CGPoint) {
        
        let burstPath = Bundle.main.path(
            forResource: "Spark", ofType: "sks")
        let burstNode =
            NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!)
                as! SKEmitterNode
        burstNode.position = position
        addChild(burstNode)
    }
    
    func coinEffect(position: CGPoint) {
        
        let burstPath = Bundle.main.path(
            forResource: "CoinSpark", ofType: "sks")
        let burstNode =
            NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!)
                as! SKEmitterNode
        burstNode.position = position
        addChild(burstNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for t in touches {
            let location = t.location(in: self)
            
            if location.x < size.width/2 {
                hero.physicsBody?.velocity = CGVector(dx: -jumpSpeed_X, dy: jumpSpeed_Y)
                hero.physicsBody?.angularVelocity = random(2, 10)
            } else {
                hero.physicsBody?.velocity = CGVector(dx: jumpSpeed_X, dy: jumpSpeed_Y)
                hero.physicsBody?.angularVelocity = random(-2, -10)

            }
        }
    }

    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        switch contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask {
            
        case BitMask.Player | BitMask.Enemy:
            
            //doesn't matter which is which
            print("hit")
            playerDied()
            deathEffect(position: hero.position)
        
        case BitMask.Player | BitMask.Coin:

            //distinguish which is which

            if contact.bodyA.categoryBitMask == BitMask.Player {
                firstBody = contact.bodyA
                secondBody = contact.bodyB
            }
            if contact.bodyB.categoryBitMask == BitMask.Player {
                firstBody = contact.bodyB
                secondBody = contact.bodyA
            }

            if let coin = secondBody.node as? Coin {
                coinEffect(position: coin.position)
                coin.removeFromParent()
                newCoin()
                playerScores()
            }
            
        default:
            break
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is renderedy
        for case let enemy as EnemySquare in children {
            enemy.position.x -= enemy.xSpeed
            if enemy.position.x < -outOfScreenMargin {
                enemy.position.x = size.width + outOfScreenMargin
                enemy.position.y = random(floorHeight+100, size.height)
                enemy.xSpeed = random(minEnemySpeed, maxEnemySpeed)
            }
        }
        
        for case let coin as Coin in children {
            coin.position.x -= coin.xSpeed
            if coin.position.x < -outOfScreenMargin {
                coin.position.x = size.width + outOfScreenMargin
                coin.position.y = random(floorHeight+100, size.height)
                coin.xSpeed = random(minEnemySpeed, maxEnemySpeed)
            }
        }
        
        if hero.position.y < 0 {
            playerDied()
        }
    }
  

}

func random(_ lowerLimit: CGFloat, _ upperLimit: CGFloat) -> CGFloat {
    return lowerLimit + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upperLimit - lowerLimit)
}
