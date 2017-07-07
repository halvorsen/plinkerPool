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
 
    var _origin = CGPoint()
    init(origin: CGPoint, scene: SKScene) {
        super.init()
        _origin = origin
        
        let rect = CGRect(origin: origin, size: CGSize(width: 60*sw, height: 6*sw))
        self.path = CGPath(rect: rect, transform: nil)
        self.strokeColor = CustomColor.gray
        self.fillColor = CustomColor.gray
        scene.addChild(self)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flash() {
        
    }
    
}

class TargetVertical: SKShapeNode, BrothersUIAutoLayout {
       var _origin = CGPoint()
    init(origin: CGPoint, scene: SKScene) {
        super.init()
        _origin = origin
        
        let rect = CGRect(origin: origin, size: CGSize(width: 6*sw, height: 60*sw))
        self.path = CGPath(rect: rect, transform: nil)
        self.strokeColor = CustomColor.gray
        self.fillColor = CustomColor.gray
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
    
    func flash() {
        
    }
}
