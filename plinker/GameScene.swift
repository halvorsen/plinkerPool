//
//  GameScene.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/24/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol refreshDelegate: class {
    func refresh(start: CGPoint, end: CGPoint)
    func turn(on: Bool)
}

class GameScene: SKScene, BrothersUIAutoLayout {
    var viewController: GameViewController!
    var delegateRefresh: refreshDelegate?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private let color1: UIColor = UIColor(colorLiteralRed: 252/255, green: 52/255, blue: 104/255, alpha: 1.0)
    private let color2: UIColor = UIColor(colorLiteralRed: 255/255, green: 194/255, blue: 205/255, alpha: 1.0)
    private let color3: UIColor = UIColor(colorLiteralRed: 255/255, green: 147/255, blue: 172/255, alpha: 1.0)
    private let color4: UIColor = UIColor(colorLiteralRed: 255/255, green: 8/255, blue: 74/255, alpha: 1.0)
    private let cueColor: UIColor = UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 1.0)
    private let boundaryColor: UIColor = UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 0.6)
    var cue = SKShapeNode()
    var cueLocation = CGPoint()
    private let ballRadius:CGFloat = 12
    var balls = [SKShapeNode]()
    var boundaries = [SKShapeNode]()
    let initialDamping: CGFloat = 0.1
    var startTouchLocation = CGPoint(x: 0, y: 0)
    var endTouchLocation = CGPoint(x: 0, y: 0)
    
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.white
        
        let boundaryDictionary : [(CGFloat,CGFloat,CGFloat,CGFloat)] = [
            (0,0,6,667),
            (369,0,6,667),
            (0,0,375,6),
            (0,661,375,6),
            ]
        for (x,y,width,height) in boundaryDictionary {
            let boundary = SKShapeNode(rect: CGRect(x: x*sw, y: y*sh, width: width*sw, height: height*sh))
            boundary.strokeColor = boundaryColor
            boundary.fillColor = boundaryColor
            boundary.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: x*sw, y: y*sh, width: width*sw, height: height*sh))
            boundary.physicsBody?.isDynamic = false
            boundary.alpha = 0.0
            self.addChild(boundary)
            boundaries.append(boundary)
        }
        
        
        
        addBalls()
        
        delay(bySeconds: 1.0) {
            for ball in self.balls {
                ball.physicsBody?.linearDamping = 100000
            }
            self.cue.physicsBody?.linearDamping = 100000
            self.delay(bySeconds: 0.5) {
                for ball in self.balls {
                    ball.physicsBody?.linearDamping = self.initialDamping
                }
                self.cue.physicsBody?.linearDamping = self.initialDamping
            }
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
    
    func addBalls() {
        
        for i in 0...8 {
            delay(bySeconds: 0.1*Double(i)) {
                let colors = [self.color1, self.color2, self.color3, self.color4]
                let circle = SKShapeNode(circleOfRadius: self.ballRadius*self.sw ) // Create circle
                circle.position = CGPoint(x: 375*self.sw/2, y: 667*self.sh/2)//CGPoint(x: sw*(CGFloat(i%2)*5 - 2.5), y: sh*5*CGFloat(i))  // Center (given scene anchor point is 0.5 for x&y)
                //circle.glowWidth = 1.0
                let select = colors[Int(arc4random_uniform(4))]
                circle.strokeColor = select
                circle.fillColor = select
                circle.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius*self.sw)
                circle.physicsBody?.affectedByGravity = false
                circle.physicsBody?.mass = 1
                circle.physicsBody?.restitution = 0.9
                circle.physicsBody?.linearDamping = self.initialDamping
                self.addChild(circle)
                self.balls.append(circle)
                circle.alpha = 0.0
                let dx = Int(arc4random_uniform(10000)) + 10000
                let dy = Int(arc4random_uniform(10000)) + 10000
                circle.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
                
            }
        }
        delay(bySeconds: 2.0) {
            self.cue = SKShapeNode(circleOfRadius: self.ballRadius*self.sw ) // Create circle
            self.cue.position = CGPoint(x: 375*self.sw/2, y: 667*self.sh/2)  // Center (given scene anchor point is 0.5 for x&y)
            //circle.glowWidth = 1.0
            self.cue.strokeColor = self.cueColor
            self.cue.fillColor = self.cueColor
            self.cue.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius*self.sw)
            self.cue.physicsBody?.affectedByGravity = false
            self.cue.physicsBody?.mass = 10
            self.cue.physicsBody?.restitution = 0.9
            self.cue.physicsBody?.linearDamping = self.initialDamping
            self.cue.alpha = 0.0
            self.addChild(self.cue)
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        startTouchLocation = pos
        delegateRefresh?.turn(on: true)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        endTouchLocation = pos
        print("touchmoved")
        delegateRefresh?.refresh(start: startTouchLocation, end: endTouchLocation)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        endTouchLocation = pos
        let dx = startTouchLocation.x - endTouchLocation.x
        let dy = startTouchLocation.y - endTouchLocation.y
        let amplitude = CGFloat(sqrt(Double(dx*dx + dy*dy)))
        cue.physicsBody?.applyImpulse(CGVector(dx: -10000*dx/amplitude, dy: -10000*dy/amplitude))
        delay(bySeconds: 1.5) {
            
            for ball in self.balls {
                ball.physicsBody?.linearDamping = 3
            }
            self.cue.physicsBody?.linearDamping = 3
            
            self.delay(bySeconds: 1.0) {
                for ball in self.balls {
                    ball.physicsBody?.linearDamping = 10
                }
                self.cue.physicsBody?.linearDamping = 10
                self.delay(bySeconds: 0.5) {
                    for ball in self.balls {
                        ball.physicsBody?.linearDamping = self.initialDamping
                    }
                    self.cue.physicsBody?.linearDamping = self.initialDamping
                }
            }
        }
        delegateRefresh?.turn(on: false)
    }
    
    func drawLine() {
        
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

extension SKScene {
    func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
}


