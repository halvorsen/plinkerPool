//
//  TargetWall.swift
//  plinker
//
//  Created by Aaron Halvorsen on 7/3/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import SpriteKit

class TargetCross: SKShapeNode, BrothersUIAutoLayout {
    
    var horizontal1Location = CGPoint()
    var horizontal2Location = CGPoint()
    var horizontal3Location = CGPoint()
    var horizontal4Location = CGPoint()
    
    init(originCenter: CGPoint) {
        super.init() // 14 x 134
        let points : [CGPoint] = [
           
            CGPoint(x: originCenter.x - 7*sw, y: originCenter.y - 7*sw),
            CGPoint(x: originCenter.x - 7*sw, y: originCenter.y - 67*sw),
            CGPoint(x: originCenter.x + 7*sw, y: originCenter.y - 67*sw),
            CGPoint(x: originCenter.x + 7*sw, y: originCenter.y - 67*sw),
            CGPoint(x: originCenter.x + 7*sw, y: originCenter.y - 7*sw),
            CGPoint(x: originCenter.x + 67*sw, y: originCenter.y - 7*sw),
            CGPoint(x: originCenter.x + 67*sw, y: originCenter.y + 7*sw),
            CGPoint(x: originCenter.x + 7*sw, y: originCenter.y + 7*sw),
            CGPoint(x: originCenter.x + 7*sw, y: originCenter.y + 67*sw),
            CGPoint(x: originCenter.x - 7*sw, y: originCenter.y + 67*sw),
            CGPoint(x: originCenter.x - 7*sw, y: originCenter.y + 7*sw),
            CGPoint(x: originCenter.x - 67*sw, y: originCenter.y + 7*sw),
            CGPoint(x: originCenter.x - 67*sw, y: originCenter.y - 7*sw),
        ]
        
        let path = UIBezierPath()
        path.move(to: points.last!)
        for point in points {
            path.addLine(to: point)
        }
        path.close()
        self.path = path.cgPath
       
        self.strokeColor = CustomColor.boundaryColor
        self.fillColor = CustomColor.boundaryColor
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: path.cgPath)
        
        horizontal1Location = CGPoint(x: originCenter.x - 67*sw, y: originCenter.y + 7*sw)
        horizontal2Location = CGPoint(x: originCenter.x - 67*sw, y: originCenter.y - 13*sw)
        horizontal3Location = CGPoint(x: originCenter.x + 7*sw, y: originCenter.y + 7*sw)
        horizontal4Location = CGPoint(x: originCenter.x + 7*sw, y: originCenter.y - 13*sw)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


