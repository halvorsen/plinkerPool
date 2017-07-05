//
//  TargetWall.swift
//  plinker
//
//  Created by Aaron Halvorsen on 7/3/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import SpriteKit

class TargetSquare: SKShapeNode, BrothersUIAutoLayout {
    
    var horizontal1Location = CGPoint()
    var horizontal2Location = CGPoint()
    var vertical1Location = CGPoint()
    var vertical2Location = CGPoint()

    init(originCenter: CGPoint) {
        super.init()  //(rect: CGRect(origin: origin, size: size))
        let rect = CGRect(origin: CGPoint(x: originCenter.x - 33*sw, y: originCenter.y - 33*sw), size: CGSize(width: 66*sw, height: 66*sw))
        self.path = CGPath(rect: rect, transform: nil)
        self.strokeColor = CustomColor.boundaryColor
        self.fillColor = CustomColor.boundaryColor
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        
        horizontal1Location = CGPoint(x: originCenter.x - 30*sw, y: originCenter.y + 33*sw)
        horizontal2Location = CGPoint(x: originCenter.x - 30*sw, y: originCenter.y - 39*sw)
        vertical1Location = CGPoint(x: originCenter.x - 39*sw, y: originCenter.y - 30*sw)
        vertical2Location = CGPoint(x: originCenter.x + 33*sw, y: originCenter.y - 30*sw)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


