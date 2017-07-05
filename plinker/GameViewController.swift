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
    let view3 = SKView()
    var score = UILabel()
    var scoreInt = Int() {didSet{score.text = String(scoreInt); Global.points = scoreInt}}
    let stopCue = UIButton()
    let stopCueLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.boundaryColor
        view3.frame = self.view.bounds
        view.addSubview(view3)
        
        scene = GameScene(size: CGSize(width: view.bounds.width, height: view.bounds.height))
        scene.scaleMode = .aspectFill
        scene.delegateRefresh = self
        view3.presentScene(scene)
        view3.ignoresSiblingOrder = true
        
        if !cueTrajectory.isDescendant(of: view) {
            view.addSubview(cueTrajectory)
        }
        
        score.frame = CGRect(x: 0, y: 15*sh, width: 375*sw, height: 86*sh)
        score.font = UIFont(name: "HelveticaNeue-Bold", size: 72*fontSizeMultiplier)
        score.textColor = CustomColor.color3
        score.alpha = 0.1
        score.textAlignment = .center
        score.text = String(Global.points)
        view3.addSubview(score)
        stopCueLabel.frame = CGRect(x: 0,y: 617*sh,width: 375*sw,height: 50*sh)
        stopCueLabel.textColor = CustomColor.boundaryColor
        stopCueLabel.textAlignment = .center
        stopCueLabel.alpha = 0.1
        stopCueLabel.text = "TAP Screen to freeze cue"
        stopCue.frame = self.view.bounds
        stopCue.addTarget(self, action: #selector(GameViewController.stopCueFunc), for: .touchUpInside)
        
        cover.frame = view.bounds
        cover.backgroundColor = .white
        view.addSubview(cover)

    }
    
    @objc private func stopCueFunc() {
        scene.cue.physicsBody?.linearDamping = 10000000
        self.delay(bySeconds: 0.2) {
            self.scene.cue.physicsBody?.linearDamping = self.scene.initialDamping
        }
    }
    func addStopCueButton() {
        view3.addSubview(stopCueLabel)
        view3.addSubview(stopCue)
        
    }
    
    func removeStopCueButton() {
        stopCueLabel.removeFromSuperview()
        stopCue.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoreInt = Global.points
    }
 
    override func viewDidAppear(_ animated: Bool) {
        
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
            
            self.delay(bySeconds: 1.5) {
                countDownLabel.text = Global.introTitle
                UIView.animate(withDuration: 0.5) {
                    countDownLabel.alpha = 1.0
                }
                self.delay(bySeconds: 0.7) {
                    UIView.animate(withDuration: 0.5) {
                        countDownLabel.alpha = 0.0
                        
                    }
                    self.delay(bySeconds: 0.8) {
                        countDownLabel.removeFromSuperview()
                        
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
        delay(bySeconds: 3.5) {
            
            for ball in self.scene.balls {
                
                ball.alpha = 1.0
                
            }
            for boundary in self.scene.boundaries {
                
                boundary.alpha = 1.0
                
            }
            
            self.scene.cue.alpha = 1.0
            
            UIView.animate(withDuration: 1.2) {
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
            cueTrajectory.isHorz = false
            cueTrajectory.isVert = false
            addStopCueButton()
        }
    }
    
    func refresh(start: CGPoint, end: CGPoint) {
        
        let x = scene.cue.position.x
        let y = 667*sh - scene.cue.position.y
        cueTrajectory.startLine = CGPoint(x: x, y: y)
        cueTrajectory.endLine = CGPoint(x: 3*(end.x - start.x) + x, y: 3*(-end.y + start.y) + y)
        cueTrajectory.setNeedsDisplay()
        
    }
    func addPointDecrementCount() {
        scoreInt += 1
        Global.targetsLeft -= 1
        if Global.targetsLeft == 0 {
            if Global.isOddController {
                delay(bySeconds: 1.0) {
            performSegue(withIdentifier: "fromOddToEven", sender: self)
                }
            } else {
                delay(bySeconds: 1.0) {
            performSegue(withIdentifier: "fromEvenToOdd", sender: self)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Global.isOddController = !Global.isOddController
        Global.level += 1
        Global.introTitle = "Level \(Global.level)"
        Global.targetsLeft = 9
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

