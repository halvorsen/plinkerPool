//
//  GameScene.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/24/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, BrothersUIAutoLayout {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private let color1: UIColor = UIColor(colorLiteralRed: 252/255, green: 52/255, blue: 104/255, alpha: 1.0)
    private let color2: UIColor = UIColor(colorLiteralRed: 255/255, green: 194/255, blue: 205/255, alpha: 1.0)
    private let color3: UIColor = UIColor(colorLiteralRed: 255/255, green: 147/255, blue: 172/255, alpha: 1.0)
    private let color4: UIColor = UIColor(colorLiteralRed: 255/255, green: 8/255, blue: 74/255, alpha: 1.0)
    private let cueColor: UIColor = UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 1.0)
    private let boundaryColor: UIColor = UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 0.6)
    var cue = SKShapeNode()
    private let ballRadius:CGFloat = 23
    
    override func didMove(to view: SKView) {
        let boundaryDictionary : [(CGFloat,CGFloat,CGFloat,CGFloat)] = [
        (-375,-667,12,1334),
        (363,-667,12,1334),
        (-375,-667,750,12),
        (-375,655,750,12),
        
        
        
        ]
        for (x,y,width,height) in boundaryDictionary {
        let boundary = SKShapeNode(rect: CGRect(x: x*sw, y: y*sh, width: width*sw, height: height*sh))
        boundary.strokeColor = boundaryColor
        boundary.fillColor = boundaryColor
        boundary.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: boundary.frame.minX, y: boundary.frame.minY), to: CGPoint(x: boundary.frame.maxX, y: boundary.frame.maxY))
        boundary.physicsBody?.isDynamic = false
        self.addChild(boundary)
        }
        
        cue = SKShapeNode(circleOfRadius: ballRadius*sw ) // Create circle
        cue.position = CGPoint(x: 0, y: -300*sh)  // Center (given scene anchor point is 0.5 for x&y)
        //circle.glowWidth = 1.0
        cue.strokeColor = cueColor
        cue.fillColor = cueColor
        cue.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius*sw)
        cue.physicsBody?.affectedByGravity = false
        self.addChild(cue)
        
        for i in 0...8 {
        let colors = [color1, color2, color3, color4]
        let circle = SKShapeNode(circleOfRadius: ballRadius*sw ) // Create circle
        circle.position = CGPoint(x: sw*(CGFloat(i%2)*50 - 25), y: sh*50*CGFloat(i))  // Center (given scene anchor point is 0.5 for x&y)
        //circle.glowWidth = 1.0
        let select = colors[Int(arc4random_uniform(4))]
        circle.strokeColor = select
        circle.fillColor = select
        circle.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius*sw)
        circle.physicsBody?.affectedByGravity = false
        self.addChild(circle)
        }
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        cue.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
