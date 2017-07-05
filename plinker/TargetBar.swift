//
//  TargetWall.swift
//  plinker
//
//  Created by Aaron Halvorsen on 7/3/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import SpriteKit

enum Direction {
    case up
    case down
    case right
    case left
}

class TargetBar: SKShapeNode, BrothersUIAutoLayout {
    
    var location1 = CGPoint()
    var location2 = CGPoint()
    var location3 = CGPoint()
    var targetOrientation = String()
    
    init(originCenter: CGPoint, orientation: Direction) {
        super.init()
        var rect = CGRect()
        switch orientation {
        case .up, .down:
             rect = CGRect(origin: CGPoint(x: originCenter.x - 102*sw, y: originCenter.y - 7*sw), size: CGSize(width: 204*sw, height: 14*sw))
        case .left, .right:
            rect = CGRect(origin: CGPoint(x: originCenter.x - 7*sw, y: originCenter.y - 102*sw), size: CGSize(width: 14*sw, height: 204*sw))
        }
        
        
       
        self.path = CGPath(rect: rect, transform: nil)
        self.strokeColor = CustomColor.boundaryColor
        self.fillColor = CustomColor.boundaryColor
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        
        switch orientation {
        case .up:
            location1 = CGPoint(x: originCenter.x - 96*sw, y: originCenter.y - 13*sw)
            location2 = CGPoint(x: originCenter.x - 30*sw, y: originCenter.y - 13*sw)
            location3 = CGPoint(x: originCenter.x + 36*sw, y: originCenter.y - 13*sw)
            
        case .down:
            location1 = CGPoint(x: originCenter.x - 96*sw, y: originCenter.y + 7*sw)
            location2 = CGPoint(x: originCenter.x - 30*sw, y: originCenter.y + 7*sw)
            location3 = CGPoint(x: originCenter.x + 36*sw, y: originCenter.y + 7*sw)
            
        case .left:
            location1 = CGPoint(x: originCenter.x - 13*sw, y: originCenter.y - 96*sw)
            location2 = CGPoint(x: originCenter.x - 13*sw, y: originCenter.y - 30*sw)
            location3 = CGPoint(x: originCenter.x - 13*sw, y: originCenter.y + 36*sw)
            
        case .right:
            location1 = CGPoint(x: originCenter.x + 7*sw, y: originCenter.y - 96*sw)
            location2 = CGPoint(x: originCenter.x + 7*sw, y: originCenter.y - 30*sw)
            location3 = CGPoint(x: originCenter.x + 7*sw, y: originCenter.y + 36*sw)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


