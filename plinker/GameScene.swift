//
//  GameScene.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/24/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

protocol refreshDelegate: class {
    func refresh(start: CGPoint, end: CGPoint)
    func turn(on: Bool)
    func addPointDecrementCount()
    func addStopCueButton()
    func removeStopCueButton()
    func gameOver()
}

class GameScene: SKScene, BrothersUIAutoLayout, SKPhysicsContactDelegate {
    
    var playerBounce = [AVAudioPlayer]()
    var playerPing = [AVAudioPlayer]()
    
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
    var target1 = [TargetHorizontal]()
    var target2 = [TargetVertical]()
    
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
            CGPoint(x: 3*375*sw/4,y: 561*sh),
            CGPoint(x: 96*sw,y: 150*sh),
            CGPoint(x: 266*sw,y: 150*sh),
            CGPoint(x: 266*sw,y: 322*sh),
            CGPoint(x: 266*sw,y: 500*sh),
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
            2:(targetLocationsBar,3,"bar")
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
                        target1.append(TargetHorizontal(origin: location, scene: self))
                        
                    } else {
                        target2.append(TargetVertical(origin: location, scene: self))
                        
                    }
                    
                }
                self.addChild(myStructure! as! TargetSquare)
                
            case "cross":
                myStructure = TargetCross(originCenter: locationOfStructure)
                for (location) in [((myStructure! as! TargetCross).horizontal1Location),((myStructure! as! TargetCross).horizontal2Location),((myStructure! as! TargetCross).horizontal3Location),((myStructure! as! TargetCross).horizontal4Location)] {
                    
                    target1.append(TargetHorizontal(origin: location, scene: self))
                }
                self.addChild(myStructure! as! TargetCross)
            case "bar":
                myStructure = TargetBar(originCenter: locationOfStructure, orientation: targetLocationsBarDirection[randomPlace])
                for (location) in [((myStructure! as! TargetBar).location1),((myStructure! as! TargetBar).location2),((myStructure! as! TargetBar).location3)] {
                    if targetLocationsBarDirection[randomPlace] == .down || targetLocationsBarDirection[randomPlace] == .up {
                        target1.append(TargetHorizontal(origin: location, scene: self))
                    } else {
                        target2.append(TargetVertical(origin: location, scene: self))
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
            
            for index in indexesForSingleTargets {
                let location = targetLocationsSingle[index].0
                if targetLocationsSingle[index].1 == "h" {
                    target1.append(TargetHorizontal(origin: location, scene: self))
                } else {
                    target2.append(TargetVertical(origin: location, scene: self))
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
                                if targetLocationsSingle[index].1 == "h" {
                    target1.append(TargetHorizontal(origin: location, scene: self))
                } else {
                    target2.append(TargetVertical(origin: location, scene: self))
                }
            }
            
        default: break
            
        }
        
        addBalls()
        
        Global.delay(bySeconds: 2.0) {
            for ball in self.balls {
                ball.physicsBody?.linearDamping = 100000
            }
            self.cue.physicsBody?.linearDamping = 100000
            Global.delay(bySeconds: 0.5) {
                self.on = true
                for ball in self.balls {
                    ball.physicsBody?.linearDamping = self.initialDamping
                }
                self.cue.physicsBody?.linearDamping = self.initialDamping
            }
        }
        
        var _playerBounce: AVAudioPlayer?
        var _playerPing: AVAudioPlayer?
        
        for _ in 0...9 {
        
        guard let url = Bundle.main.url(forResource: "bounce", withExtension: "wav") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            _playerBounce = try AVAudioPlayer(contentsOf: url)
            if let player = _playerBounce {
                player.prepareToPlay()
                playerBounce.append(player)
            
            }
        } catch let error {
            print(error.localizedDescription)
        }
        }
        
        for _ in 0...3 {
        guard let url2 = Bundle.main.url(forResource: "ping", withExtension: "wav") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            _playerPing = try AVAudioPlayer(contentsOf: url2)
            if let player = _playerPing {
                player.prepareToPlay()
                playerPing.append(player) }
            
            
        } catch let error {
            print(error.localizedDescription)
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
    
    var targetTrash = [SKShapeNode]()
    var playCount = 0
    var pingCount = 0
    func didBegin(_ contact: SKPhysicsContact) {
        
        if on {
            
            if (contact.bodyA.categoryBitMask == 2 || contact.bodyA.categoryBitMask == 8) && contact.bodyB.categoryBitMask == 1 {
                
                if let target = contact.bodyA.node as? SKShapeNode {
                    if !targetTrash.contains(target) {
                        targetTrash.append(target)
                        target.removeFromParent()
                        delegateRefresh?.addPointDecrementCount()
                        
                        playerPing[pingCount].play()
                        playerPing[pingCount].prepareToPlay()
                            if pingCount < 3 {
                                pingCount += 1
                            } else {
                                pingCount = 0
                            }
                        if let ball = contact.bodyB.node as? SKShapeNode {
         
                            ball.removeFromParent()
                        }
                    }
                }
            } else {
                playerBounce[playCount].play()
                playerBounce[playCount].prepareToPlay()
                if playCount < 9 {
                    playCount += 1
                } else {
                    playCount = 0
                }
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
        
        for i in 1...10 {
            
            let colors = [CustomColor.color1, CustomColor.color2, CustomColor.color3, CustomColor.color4]
            let circle = SKShapeNode(circleOfRadius: self.ballRadius*self.sw ) // Create circle
            circle.position = CGPoint(x: 100*self.sw, y: 667*self.sh/2 + CGFloat(i)*30*sh)//
            let select = colors[Int(arc4random_uniform(4))]
            // circle.strokeColor = select
            circle.fillColor = select
            circle.physicsBody = SKPhysicsBody(circleOfRadius: self.ballRadius*self.sw)
            circle.physicsBody?.isDynamic = true
            circle.physicsBody?.affectedByGravity = false
            circle.physicsBody?.mass = 10
            circle.physicsBody?.restitution = 0.9
            circle.physicsBody?.linearDamping = self.initialDamping
            circle.physicsBody?.categoryBitMask = 1
            circle.physicsBody?.usesPreciseCollisionDetection = true
            circle.physicsBody?.collisionBitMask = 1 | 2 | 4 | 8 | 16
            circle.physicsBody?.contactTestBitMask = 1 | 2 | 4 | 8 | 16
            circle.physicsBody?.friction = 0
            self.addChild(circle)
            self.balls.append(circle)
            circle.alpha = 0.0
            circle.zPosition = 1000
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
        cue.physicsBody?.friction = 0
        cue.alpha = 0.0
        cue.zPosition = 1000
        addChild(cue)
        
        let dx = Int(arc4random_uniform(10000)) + 10000
        let dy = Int(arc4random_uniform(10000)) + 10000
        cue.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
        
    }
    var targetsLeftWhenShotLast = Int()
    var madeAShot = false
    var touchDownPoint = CGPoint()
    var touchOnce = true
    func touchDown(atPoint pos : CGPoint) {
        if touchOnce {
        touchDownPoint = pos
        endTouchLocation = pos
        startTouchLocation = pos
        delegateRefresh?.refresh(start: startTouchLocation, end: endTouchLocation)
        delegateRefresh?.turn(on: true)
        }
    }
    var previouslySavedTouch = CGPoint()
    var savedTouch = CGPoint(x: 0,y: 0)
    func touchMoved(toPoint pos : CGPoint) {
        if touchOnce {
        endTouchLocation = pos
        delegateRefresh?.refresh(start: startTouchLocation, end: endTouchLocation)
            previouslySavedTouch = savedTouch
            savedTouch = pos
        }
    }
    
    var timer1 = Timer()
    var timer2 = Timer()
    var timer3 = Timer()
    
    
    func touchUp(atPoint pos : CGPoint) {
        if touchOnce {
            endTouchLocation = previouslySavedTouch
        guard abs(pos.x - touchDownPoint.x) > 2 || abs(pos.y - touchDownPoint.y) > 2 else {return}
        madeAShot = false
        timer1.invalidate()
        timer2.invalidate()
        timer3.invalidate()
        self.changeDamping(amount: self.initialDamping - 0.00001)
        targetsLeftWhenShotLast = Global.targetsLeft
        endTouchLocation = pos
        let dx = startTouchLocation.x - endTouchLocation.x
        let dy = startTouchLocation.y - endTouchLocation.y
        let amplitude = CGFloat(sqrt(Double(dx*dx + dy*dy)))
        cue.physicsBody?.applyImpulse(CGVector(dx: -16000*dx/amplitude, dy: -16000*dy/amplitude))
        
        timer1 = Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false) {_ in
            self.changeDamping(amount: 3)
        }
        timer2 = Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) {_ in
            self.changeDamping(amount: 10)
        }
        timer3 = Timer.scheduledTimer(withTimeInterval: 6, repeats: false) {_ in
            self.changeDamping(amount: self.initialDamping)
        }
        
        delegateRefresh?.turn(on: false)
            touchOnce = false
            Global.delay(bySeconds: 2.0) {
                self.touchOnce = true
            }
        }
        
    }
    
    func changeDamping(amount: CGFloat) {
        
        for ball in self.balls {
            
            ball.physicsBody?.linearDamping = amount
        }
        self.cue.physicsBody?.linearDamping = amount
        
        if amount == initialDamping {
            print("global.targetsleft: \(Global.targetsLeft)")
            print("targetsLeftWhenShotLast: \(targetsLeftWhenShotLast)")
            if Global.targetsLeft == targetsLeftWhenShotLast {
                delegateRefresh?.gameOver()
                print("GAME OVER!")
            }
            delegateRefresh?.removeStopCueButton()
        }
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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



