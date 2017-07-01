//
//  GameViewController.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/24/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, refreshDelegate, BrothersUIAutoLayout {
    
    let cover = UIView()
    var cueTrajectory = ProjectileDrawings()
    var scene = GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        if let view = self.view as! SKView? {
            
            scene = GameScene(size: CGSize(width: view.bounds.width, height: view.bounds.height))
            scene.scaleMode = .aspectFill
            scene.delegateRefresh = self
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        if !cueTrajectory.isDescendant(of: view) {
            view.addSubview(cueTrajectory)
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cover.frame = view.bounds
        cover.backgroundColor = .white
        view.addSubview(cover)
        let myAnimation = Animation()
        view.addSubview(myAnimation)
        
        let countDownLabel = UILabel()
        countDownLabel.frame = CGRect(x: 0, y: 283.5*sh, width: 375*sw, height: 100*sh)
        countDownLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 25*fontSizeMultiplier)
        countDownLabel.textAlignment = .center
        countDownLabel.textColor = UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 0.6)
        countDownLabel.alpha = 0.0
        countDownLabel.text = ""
        view.addSubview(countDownLabel)
        
        
        
        self.delay(bySeconds: 1.2) {
            countDownLabel.text = ""
            self.delay(bySeconds: 1.2) {
                countDownLabel.text = ""
                self.delay(bySeconds: 1.5) {
                    countDownLabel.text = "Plinker Pool!"
                    UIView.animate(withDuration: 0.5) {
                        countDownLabel.alpha = 1.0
                    }
                    self.delay(bySeconds: 1.5) {
                        UIView.animate(withDuration: 0.5) {
                            countDownLabel.alpha = 0.0
                            
                        }
                        self.delay(bySeconds: 0.8) {
                            countDownLabel.removeFromSuperview()
                        }
                    }
                }
            }
        }
        
        delay(bySeconds: 1.0) {
            UIView.animate(withDuration: 2.0) {
                myAnimation.transform = myAnimation.transform.rotated(by: .pi)
                
            }
            // self.delay(bySeconds: 0.1) {
            UIView.animate(withDuration: 2.0) {
                myAnimation.transform = myAnimation.transform.rotated(by: .pi)
            }
            // }
        }
        delay(bySeconds: 5.5) {
            
            for ball in self.scene.balls {
                
                ball.alpha = 1.0
                
            }
            for boundary in self.scene.boundaries {
                
                boundary.alpha = 1.0
                
            }
            
            self.scene.cue.alpha = 1.0
            
            UIView.animate(withDuration: 2.5) {
                self.cover.alpha = 0.0
            }
            self.delay(bySeconds: 3.0) {
                self.cover.removeFromSuperview()
            }
            
            
        }
    }
    func turn(on: Bool) {
        if on {
            cueTrajectory.alpha = 1.0
        } else {
            cueTrajectory.alpha = 0.0
        }
    }
    func refresh(start: CGPoint, end: CGPoint) {
 
        let x = scene.cue.position.x
        let y = 667 - scene.cue.position.y
        cueTrajectory.startLine = CGPoint(x: x, y: y)//scene.cue.position
        cueTrajectory.endLine = CGPoint(x: 3*(end.x - start.x) + x, y: -3*(end.y - start.y) + y)
        cueTrajectory.setNeedsDisplay()
        
    }
    
    //    (94,0,60,6),
    //    (369,251,6,60),
    //    (369,503,6,60),
    //    (221,661,60,6),
    //    (0,366,6,60),
    //    (0,114,6,60),
    
    func controlGate(gate: Gate) {
        switch gate.position {
        case .top:
            switch gate.myState {
            case .closed:
                scene.moveSprite(sprite: scene.boundaries[0], location: CGPoint(x: 94*sw, y: 0))
                scene.lockSprite(sprite: scene.boundaries[0], isDynamic: false)
                scene.colorSprite(sprite: scene.boundaries[0], colorString: gate.myColor.rawValue)
                
            case .open:
                scene.moveSprite(sprite: scene.boundaries[0], location: CGPoint(x: 94*sw, y: -7*sh))
                scene.lockSprite(sprite: scene.boundaries[0], isDynamic: true)
                scene.colorSprite(sprite: scene.boundaries[0], colorString: gate.myColor.rawValue)
                
            }
            
        case .rightTop:
            switch gate.myState {
            case .closed:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 376*sw, y: 251*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: false)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            case .open:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 376*sw, y: 251*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: true)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            }
            
        case .rightBottom:
            switch gate.myState {
            case .closed:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 376*sw, y: 503*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: false)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            case .open:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 376*sw, y: 503*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: true)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            }
            
        case .bottom:
            switch gate.myState {
            case .closed:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 0, y: 366*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: false)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            case .open:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: -7*sw, y: 366*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: true)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            }
            
        case .leftBottom:
            switch gate.myState {
            case .closed:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 0, y: 114*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: false)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            case .open:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: -7*sw, y: 114*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: true)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
                
            }
            
        case .leftTop:
            switch gate.myState {
            case .closed:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 0, y: 114*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: false)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            case .open:
                scene.moveSprite(sprite: scene.boundaries[1], location: CGPoint(x: 221*sw, y: 114*sh))
                scene.lockSprite(sprite: scene.boundaries[1], isDynamic: true)
                scene.colorSprite(sprite: scene.boundaries[1], colorString: gate.myColor.rawValue)
                
            }
            
            
        }
    }
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

