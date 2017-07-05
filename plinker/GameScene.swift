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
    func pointScored()
}

class GameScene: SKScene, BrothersUIAutoLayout, SKPhysicsContactDelegate {
    var viewController: GameViewController!
    var delegateRefresh: refreshDelegate?
    var on = false
    var cue = SKShapeNode()
    var cueLocation = CGPoint()
    private let ballRadius:CGFloat = 12
    var balls = [SKShapeNode]()
    var boundaries = [SKShapeNode]()
    let initialDamping: CGFloat = 0.05
    var startTouchLocation = CGPoint(x: 0, y: 0)
    var endTouchLocation = CGPoint(x: 0, y: 0)
    var boundary = SKShapeNode()

    enum CollisionTypes: UInt32 {
        
        case ball1 = 1
        case cue = 10
        case boundary = 2
    }
    
    enum TargetKind {
        case TargetHorizontal
        case TargetVertical
    }

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor.white
        
        let targetLocationsSingle : [(CGPoint, String)] = [
            (CGPoint(x:0,y:0),"h"),
            (CGPoint(x:157.5*sw,y:0),"h"),
            (CGPoint(x:315*sw,y:0),"h"),
            (CGPoint(x:0,y:661*sh),"h"),
            (CGPoint(x:157.5,y:661*sh),"h"),
            (CGPoint(x:315*sw,y:661*sh),"h"),
            (CGPoint(x:0,y:0),"v"),
            (CGPoint(x:0,y:148.75*sh),"v"),
            (CGPoint(x:0,y:297.5*sh),"v"),
            (CGPoint(x:0,y:446.25*sh),"v"),
            (CGPoint(x:0,y:607*sh),"v"),
            (CGPoint(x:369*sw,y:0),"v"),
            (CGPoint(x:369*sw,y:157.75*sh),"v"),
            (CGPoint(x:369*sw,y:306.5*sh),"v"),
            (CGPoint(x:369*sw,y:455.25*sh),"v"),
            (CGPoint(x:369*sw,y:607*sh),"v")
        ]
        
        let targetLocationsSquare : [CGPoint] = [
            CGPoint(x: 375*sw/2,y: 667*sh/2),
            CGPoint(x: 375*sw/2,y: 667*2*sh/3),
            CGPoint(x: 375*sw/2,y: 667*sh/3),
            
            ]
        let targetLocationsCross : [CGPoint] = [
            CGPoint(x: 375*sw/2,y: 667*sh/2),
            CGPoint(x: 375*sw/2,y: 667*2*sh/3),
            CGPoint(x: 375*sw/2,y: 667*sh/3),
            
            ]
        
        let targetLocationsBar : [CGPoint] = [
            CGPoint(x: 375*sw/2,y: 93*sh),
            CGPoint(x: 375*sw/2,y: 77*sh),
            CGPoint(x: 375*sw/2,y: 561*sh),
            CGPoint(x: 96*sw,y: 120*sh),
            CGPoint(x: 266*sw,y: 120*sh),
            CGPoint(x: 266*sw,y: 322*sh),
            CGPoint(x: 266*sw,y: 520*sh),
            ]
        
        let targetLocationsBarDirection: [Direction] = [
        .up,
        .down,
        .down,
        .left,
        .right,
        .right,
        .right
        ]
        
        let structureDictionary : [Int:([CGPoint],Int,String)] = [
            0:(targetLocationsSquare,4,"square"),
            1:(targetLocationsCross,4,"cross"),
            2:(targetLocationsBar,3,"bar"),
            
        ]
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.physicsBody?.categoryBitMask = 4
        let randomUseCenterStructure = Int(arc4random_uniform(3))
        
        switch randomUseCenterStructure {
        case 1,2:
        
            let structureKey = Int(arc4random_uniform(3))
            let randomPlace = Int(arc4random_uniform(UInt32(structureDictionary[structureKey]!.0.count)))
            let locationOfStructure = structureDictionary[structureKey]!.0[randomPlace]
            var myStructure: Any?
            let targetsOnStructure = structureDictionary[structureKey]!.1
            switch structureDictionary[structureKey]!.2 {
            case "square":
                myStructure = TargetSquare(originCenter: locationOfStructure)
                for (location,orientation) in [((myStructure! as! TargetSquare).horizontal1Location,"h"),((myStructure! as! TargetSquare).horizontal2Location,"h"),((myStructure! as! TargetSquare).vertical1Location,"v"),((myStructure! as! TargetSquare).vertical2Location,"v")] {
                    
                    if orientation == "h" {
                        let _ = TargetHorizontal(origin: location, scene: self)
                     
                    } else {
                       let _ = TargetVertical(origin: location, scene: self)
                      
                    }
                    
                }
                self.addChild(myStructure! as! TargetSquare)
                
            case "cross":
                myStructure = TargetCross(originCenter: locationOfStructure)
                for (location) in [((myStructure! as! TargetCross).horizontal1Location),((myStructure! as! TargetCross).horizontal2Location),((myStructure! as! TargetCross).horizontal3Location),((myStructure! as! TargetCross).horizontal4Location)] {
                    
                    let _ = TargetHorizontal(origin: location, scene: self)
                }
                self.addChild(myStructure! as! TargetCross)
            case "bar":
                myStructure = TargetBar(originCenter: locationOfStructure, orientation: targetLocationsBarDirection[randomPlace])
                for (location) in [((myStructure! as! TargetBar).location1),((myStructure! as! TargetBar).location2),((myStructure! as! TargetBar).location3)] {
                    if targetLocationsBarDirection[randomPlace] == .down || targetLocationsBarDirection[randomPlace] == .up {
                    let _ = TargetHorizontal(origin: location, scene: self)
                    } else {
                    let _ = TargetVertical(origin: location, scene: self)
                    }
                }
                self.addChild(myStructure! as! TargetBar)
            default:
                break
            }
            
            
            
            
            
            
            
            
            
            
            var indexesForSingleTargets = [Int]()
            while indexesForSingleTargets.count < 9 - targetsOnStructure {
                let randomInt = Int(arc4random_uniform(UInt32(targetLocationsSingle.count)))
                if !indexesForSingleTargets.contains(randomInt){
                    indexesForSingleTargets.append(randomInt)
                }
            }
            print("indexes: \(indexesForSingleTargets)")
            for index in indexesForSingleTargets {
                let location = targetLocationsSingle[index].0
                var target: Any?
                if targetLocationsSingle[index].1 == "h" {
                    target = TargetHorizontal(origin: location, scene: self)
                  //  self.addChild(target as! TargetHorizontal)
                } else {
                    target = TargetVertical(origin: location, scene: self)
                   // self.addChild(target as! TargetVertical)
                }
                
            }
            
            
            
        case 0:
            
            var indexesForSingleTargets = [Int]()
            while indexesForSingleTargets.count < 9 {
                let randomInt = Int(arc4random_uniform(UInt32(targetLocationsSingle.count)))
                if !indexesForSingleTargets.contains(randomInt){
                    indexesForSingleTargets.append(randomInt)
                }
            }
          
            for index in indexesForSingleTargets {
                let location = targetLocationsSingle[index].0
                var target: Any?
                if targetLocationsSingle[index].1 == "h" {
                    target = TargetHorizontal(origin: location, scene: self)
                //    self.addChild(target as! TargetHorizontal)
                } else {
                    target = TargetVertical(origin: location, scene: self)
                 //   self.addChild(target as! TargetVertical)
                }
                
            }
            
        default: break
            
        }
        
        addBalls()
        
        delay(bySeconds: 2.0) {
            for ball in self.balls {
                ball.physicsBody?.linearDamping = 100000
            }
            self.cue.physicsBody?.linearDamping = 100000
            self.delay(bySeconds: 0.5) {
                self.on = true
                for ball in self.balls {
                    ball.physicsBody?.linearDamping = self.initialDamping
                }
                self.cue.physicsBody?.linearDamping = self.initialDamping
            }
        }
        
    }
    
    let locationAndShapes: [(CGFloat,CGFloat,CGFloat,CGFloat)] = [
        
        (0,0,60,6),
        (0,0,6,60),
        (595,0,60,6),
        (595,649,60,6),
        (0,649,60,6),
        (357,0,6,60),
        (357,595,6,60),
        
        ]
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("bodyA: \(contact.bodyA.categoryBitMask)")
        print("bodyB: \(contact.bodyB.categoryBitMask)")
        if on {
        if (contact.bodyA.categoryBitMask == 2 || contact.bodyA.categoryBitMask == 8) && contact.bodyB.categoryBitMask == 1 {
           
            if let target = contact.bodyA.node as? SKShapeNode {
                
                target.removeFromParent()
            } 
            if let ball = contact.bodyB.node as? SKShapeNode {
               
            ball.removeFromParent() //node!.removeFromParent()
            }
            delegateRefresh?.pointScored()
            
        }
        }
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
            sprite.fillColor = CustomColor.color1
        case "color2":
            sprite.fillColor = CustomColor.color2
        case "color3":
            sprite.fillColor = CustomColor.color3
        case "color4":
            sprite.fillColor = CustomColor.color4
        case "boundaryColor":
            sprite.fillColor = CustomColor.boundaryColor
        default:
            break
        }
    }
    
    func addBalls() {
        
        for i in 1...11 {
            
            let colors = [CustomColor.color1, CustomColor.color2, CustomColor.color3, CustomColor.color4]
            let circle = SKShapeNode(circleOfRadius: self.ballRadius*self.sw ) // Create circle
            circle.position = CGPoint(x: 100*self.sw, y: 667*self.sh/2 + CGFloat(i)*30*sh)//
            let select = colors[Int(arc4random_uniform(4))]
           // circle.strokeColor = select
            circle.fillColor = select
            circle.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius*self.sw)
            circle.physicsBody?.isDynamic = true
            circle.physicsBody?.affectedByGravity = false
            circle.physicsBody?.mass = 1
            circle.physicsBody?.restitution = 0.9
            circle.physicsBody?.linearDamping = self.initialDamping
            circle.physicsBody?.categoryBitMask = 1
            circle.physicsBody?.usesPreciseCollisionDetection = true
            circle.physicsBody?.collisionBitMask = 1 | 2 | 4 | 8 | 16
            circle.physicsBody?.contactTestBitMask = 2 | 8
            self.addChild(circle)
            self.balls.append(circle)
            circle.alpha = 0.0
        }
        
        cue = SKShapeNode(circleOfRadius: ballRadius*sw ) // Create circle
        cue.position = CGPoint(x: 100*sw, y: 667*sh/2)  // Center (given scene anchor point is 0.5 for x&y)
        //circle.glowWidth = 1.0
        cue.strokeColor = CustomColor.cueColor
        cue.fillColor = CustomColor.cueColor
        cue.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius*sw)
        cue.physicsBody?.affectedByGravity = false
        cue.physicsBody?.mass = 10
        cue.physicsBody?.restitution = 0.9
        cue.physicsBody?.categoryBitMask = 16
        
        cue.physicsBody?.linearDamping = initialDamping
        cue.alpha = 0.0
        addChild(cue)
        
        let dx = Int(arc4random_uniform(10000)) + 10000
        let dy = Int(arc4random_uniform(10000)) + 10000
        cue.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        endTouchLocation = pos//CGPoint(x: cue.frame.midX, y: cue.frame.midY)
        startTouchLocation = pos//CGPoint(x: cue.frame.midX, y: cue.frame.midY)
        delegateRefresh?.refresh(start: startTouchLocation, end: endTouchLocation)
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
        delay(bySeconds: 3.5) {
            
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


