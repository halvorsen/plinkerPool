//
//  Target.swift
//  plinker
//
//  Created by Aaron Halvorsen on 7/3/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import Foundation
import SpriteKit

class TargetHorizontal: SKShapeNode, BrothersUIAutoLayout {
    
    
    init(origin: CGPoint, scene: SKScene) {
        super.init()  //(rect: CGRect(origin: origin, size: size))
        let rect = CGRect(origin: origin, size: CGSize(width: 60*sw, height: 6*sh))
        self.path = CGPath(rect: rect, transform: nil)
        self.strokeColor = CustomColor.color1
        self.fillColor = CustomColor.color1
        scene.addChild(self)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TargetVertical: SKShapeNode, BrothersUIAutoLayout {
    
    init(origin: CGPoint, scene: SKScene) {
        super.init()  //(rect: CGRect(origin: origin, size: size))
        let rect = CGRect(origin: origin, size: CGSize(width: 6*sw, height: 60*sh))
        self.path = CGPath(rect: rect, transform: nil)
        self.strokeColor = CustomColor.color1
        self.fillColor = CustomColor.color1
        scene.addChild(self)
       // self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.categoryBitMask = 8
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
