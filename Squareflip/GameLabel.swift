//
//  Label.swift
//  Squareflip
//
//  Created by Jayson Coppo on 4/15/18.
//  Copyright © 2018 Jayson Coppo. All rights reserved.
//

import Foundation
import SpriteKit

class GameLabel: SKNode {
    
    var label = SKLabelNode()
    
    override init() {
        super.init()
        
        label.fontName = "Verdana"
        label.fontSize = 70
        addChild(label)
    }
    
    func pulse() {
        
        run(SKAction.sequence([
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1),
            ]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
