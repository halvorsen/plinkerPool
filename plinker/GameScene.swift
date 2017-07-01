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

class GameScene: SKScene, BrothersUIAutoLayout, SKPhysicsContactDelegate {
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
    
    enum CollisionTypes: UInt32 {
        
        case ball1 = 1
        case ball2 = 2
        case ball3 = 3
        case ball4 = 4
        case ball5 = 5
        case ball6 = 6
        case ball7 = 7
        case ball8 = 8
        case ball9 = 9
        case cue = 10
        case boundary = 11
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor.white
        
        //        CGPoint(x: 118*sw, y: 0),
        //        CGPoint(x: 375*sw, y: 270*sh),
        //        CGPoint(x: 375*sw, y: 523*sh),
        //        CGPoint(x: 257*sw, y: 667*sh),
        //        CGPoint(x: 0, y: 396*sh),
        //        CGPoint(x: 0, y: 144*sh)
        
        let boundaryDictionary : [(CGFloat,CGFloat,CGFloat,CGFloat)] = [
            (94,0,60,6),
            (369,251,6,60),
            (369,503,6,60),
            (221,661,60,6),
            (0,366,6,60),
            (0,114,6,60),
            (0,0,6,114),
            (0,174,6,192),
            (0,426,6,251),
            (369,563,6,114),
            (369,311,6,192),
            (369,0,6,251),
            (6,0,88,6),
            (154,0,215,6),
            (6,661,215,6),
            (281,661,88,6)
        ]
        var j = 0
        for (x,y,width,height) in boundaryDictionary {
            let boundary = SKShapeNode(rect: CGRect(x: x*sw, y: y*sh, width: width*sw, height: height*sh))
            boundary.strokeColor = boundaryColor
            boundary.fillColor = boundaryColor
            boundary.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: x*sw, y: y*sh, width: width*sw, height: height*sh))
            boundary.physicsBody?.isDynamic = true
            boundary.physicsBody?.allowsRotation = false

            if j < 7 {
                boundary.physicsBody?.categoryBitMask = CollisionTypes.boundary.rawValue
                for i in 1...9 {
                boundary.physicsBody?.contactTestBitMask = UInt32(i)
                }
            }
            j += 1
            boundary.alpha = 0.0
            self.addChild(boundary)
            boundaries.append(boundary)
        }
        
        
        
        addBalls()
        
        delay(bySeconds: 2.0) {
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("CONTACT")
        print(contact)
        print("bodyA: \(contact.bodyA.categoryBitMask)")
        print("bodyB: \(contact.bodyB.categoryBitMask)")
    }
    
    func moveSprite(sprite: SKShapeNode, location: CGPoint) {
        let action = SKAction.move(to: location, duration: 0.0)
        sprite.run(action)
    }
    
    func lockSprite(sprite: SKShapeNode, isDynamic: Bool) {
        sprite.physicsBody?.isDynamic = isDynamic
    }
    
    func colorSprite(sprite: SKShapeNode, colorString: String) {
        switch colorString {
        case "color1":
            sprite.fillColor = color1
        case "color2":
            sprite.fillColor = color2
        case "color3":
            sprite.fillColor = color3
        case "color4":
            sprite.fillColor = color4
        case "boundaryColor":
            sprite.fillColor = boundaryColor
        default:
            break
        }
    }
    
    func addBalls() {
        
        for i in 1...9 {
            
            let colors = [self.color1, self.color2, self.color3, self.color4]
            let circle = SKShapeNode(circleOfRadius: self.ballRadius*self.sw ) // Create circle
            circle.position = CGPoint(x: 375*self.sw/2, y: 667*self.sh/2 + CGFloat(i)*30*sh)//
            let select = colors[Int(arc4random_uniform(4))]
            circle.strokeColor = select
            circle.fillColor = select
            circle.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius*self.sw)
            circle.physicsBody?.affectedByGravity = false
            circle.physicsBody?.mass = 1
            circle.physicsBody?.restitution = 0.9
            circle.physicsBody?.linearDamping = self.initialDamping
            circle.physicsBody?.categoryBitMask = UInt32(i)
            circle.physicsBody?.contactTestBitMask = CollisionTypes.boundary.rawValue
            self.addChild(circle)
            self.balls.append(circle)
            circle.alpha = 0.0
            
            
            
        }
        
        cue = SKShapeNode(circleOfRadius: ballRadius*sw ) // Create circle
        cue.position = CGPoint(x: 375*sw/2, y: 667*sh/2)  // Center (given scene anchor point is 0.5 for x&y)
        //circle.glowWidth = 1.0
        cue.strokeColor = cueColor
        cue.fillColor = cueColor
        cue.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius*sw)
        cue.physicsBody?.affectedByGravity = false
        cue.physicsBody?.mass = 10
        cue.physicsBody?.restitution = 0.9
        cue.physicsBody?.linearDamping = initialDamping
        cue.physicsBody?.categoryBitMask = CollisionTypes.cue.rawValue
       // cue.physicsBody?.collisionBitMask = CollisionTypes.boundary.rawValue
        cue.physicsBody?.contactTestBitMask = CollisionTypes.boundary.rawValue
        cue.alpha = 0.0
        addChild(cue)
        
        
        let dx = Int(arc4random_uniform(10000)) + 10000
        let dy = Int(arc4random_uniform(10000)) + 10000
        cue.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        startTouchLocation = pos
        delegateRefresh?.turn(on: true)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        endTouchLocation = pos
        
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


