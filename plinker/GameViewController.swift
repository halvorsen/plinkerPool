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
import SwiftyStoreKit
import GCHelper

class GameViewController: UIViewController, refreshDelegate, BrothersUIAutoLayout {
    
    let cover = UIView()
    var cueTrajectory = ProjectileDrawings()
    var scene = GameScene()
    let view3 = SKView()
    var score = UILabel()
    var scoreInt = Int() {didSet{score.text = String(scoreInt); Global.points = scoreInt}}
    let stopCue = UIButton()
    let stopCueLabel = UILabel()
    var timer = Timer()
    
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
        
        score.frame = CGRect(x: 0, y: 20*sh, width: 375*sw, height: 86*sh)
        score.font = UIFont(name: "HelveticaNeue-Bold", size: 72*fontSizeMultiplier)
        score.textColor = CustomColor.color3
        score.alpha = 0.1
        score.textAlignment = .center
        score.text = String(Global.points)
        view3.addSubview(score)
        
        let skin = UIImageView(frame: CGRect(x: 10*sw, y: 144*sh, width: 355*sw, height: 355*sw))
        skin.alpha = 0.5
        switch Global.skin {
            case "whale": skin.image = #imageLiteral(resourceName: "whale")
            case "unicown": skin.image = #imageLiteral(resourceName: "unicown")
            case "squid": skin.image = #imageLiteral(resourceName: "squid")
            default: break
        }
        
        view3.addSubview(skin)
    
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
    var checkOnce = true
    @objc private func stopCueFunc() {
        if checkOnce {
            checkOnce = false
        print("stopcuefunc")
        scene.cue.physicsBody?.linearDamping = 10000000
        Global.delay(bySeconds: 0.2) {
            self.scene.cue.physicsBody?.linearDamping = self.scene.initialDamping
        }
        
       
        var shouldStop = true
        
        
        loop: for ball in scene.balls {
            print("for ball loop")
            if (ball.physicsBody?.velocity.dx)! > CGFloat(0.05) || (ball.physicsBody?.velocity.dy)! > CGFloat(0.05) {
                print("physics body is moving")
                shouldStop = false
                break loop
            }
        }
        print("shouldstop : \(shouldStop)")
        if shouldStop {
            print("if shouldstop")
            scene.timer1.invalidate()
            scene.timer2.invalidate()
            scene.timer3.invalidate()
            removeStopCueButton()
            Global.delay(bySeconds: 1.0) {
            self.scene.changeDamping(amount: self.scene.initialDamping)
            }
            }
//            if Global.targetsLeft == scene.targetsLeftWhenShotLast {
//                gameOver()
//            }
            checkOnce = true
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
        
        
        
        Global.delay(bySeconds: 1.2) {
            countDownLabel.text = ""
            
            Global.delay(bySeconds: 1.5) {
                countDownLabel.text = Global.introTitle
                UIView.animate(withDuration: 0.5) {
                    countDownLabel.alpha = 1.0
                }
                Global.delay(bySeconds: 0.7) {
                    UIView.animate(withDuration: 0.5) {
                        countDownLabel.alpha = 0.0
                        
                    }
                    Global.delay(bySeconds: 0.8) {
                        countDownLabel.removeFromSuperview()
                        
                    }
                }
            }
            
        }
        
        Global.delay(bySeconds: 1.0) {
            UIView.animate(withDuration: 2.0) {
                myAnimation.transform = myAnimation.transform.rotated(by: .pi)
                
            }
            // self.delay(bySeconds: 0.1) {
            UIView.animate(withDuration: 2.0) {
                myAnimation.transform = myAnimation.transform.rotated(by: .pi)
            }
            // }
        }
        Global.delay(bySeconds: 3.5) {
            
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
            Global.delay(bySeconds: 3.0) {
                self.cover.removeFromSuperview()
//                self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(GameViewController.callForFlash), userInfo: nil, repeats: true)
            }
        }
    }
    
//    @objc private func callForFlash() {
//        print("triggered Flash")
//    for target in self.scene.target1 {
//    target.flash()
//    }
//    for target in self.scene.target2 {
//    target.flash()
//    }
//    }
    
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
            Global.level += 1
            Global.introTitle = "Level \(Global.level)"
            if Global.isOddController {
                Global.delay(bySeconds: 1.0) {
                    
            self.performSegue(withIdentifier: "fromOddToEven", sender: self)
                }
            } else {
                
                Global.delay(bySeconds: 1.0) {
            self.performSegue(withIdentifier: "fromEvenToOdd", sender: self)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Global.isOddController = !Global.isOddController
        Global.targetsLeft = 9
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    var myGameOverView = GameOverView()
    var once = true
    func gameOver() {
        if once {
            once = false
        if Global.points > Global.topScore {
            Global.topScore = Global.points
            UserDefaults.standard.set(Global.points, forKey: "topScore")
            GCHelper.sharedInstance.reportLeaderboardIdentifier("highscore123654", score: Global.points)
        }
        
        myGameOverView = GameOverView(backgroundColor: .white, buttonsColor: CustomColor.color3, bestScore: Global.topScore, thisScore: Global.points)
        myGameOverView.replay.addTarget(self, action: #selector(GameViewController.replayFunc(_:)), for: .touchUpInside)
//        myGameOverView.menu.addTarget(self, action: #selector(GameViewController.menuFunc(_:)), for: .touchUpInside)
        myGameOverView.gameCenter.addTarget(self, action: #selector(GameViewController.gameCenterFunc(_:)), for: .touchUpInside)
        myGameOverView.noAds.addTarget(self, action: #selector(GameViewController.noAdsFunc(_:)), for: .touchUpInside)
        myGameOverView.extraLife.addTarget(self, action: #selector(GameViewController.extraLifeFunc(_:)), for: .touchUpInside)
        view.addSubview(myGameOverView)
            Global.delay(bySeconds: 5.0) {
                self.once = true
            }
        }
    }
    @objc private func replayFunc(_ button: UIButton) {
        
        Global.points = 0
        Global.gaveBonusStrikes = false
        Global.introTitle = "Plinker Pool!"
        Global.level = 1
        
        if Global.isOddController {
            
            performSegue(withIdentifier: "fromOddToEven", sender: self)
            
        } else {
            
            performSegue(withIdentifier: "fromEvenToOdd", sender: self)
            
        }
        
    }
//    @objc private func menuFunc(_ button: UIButton) {
//        
//    }
    @objc private func gameCenterFunc(_ button: UIButton) {
       GCHelper.sharedInstance.showGameCenter(self, viewState: .leaderboards)
    }
    @objc private func extraLifeFunc(_ button: UIButton) {
        if Global.isPremium {
            UIView.animate(withDuration: 0.7) {
            self.myGameOverView.alpha = 0.0
            }
        } else {
            advertisementForExtraLife()
        }
        Global.gaveBonusStrikes = true
    }
    
    var myQuadAdView = QuadAdView()
    var myNumberBlazerAdView = NumberBlazerAdView()
    var myFoobleAdView = FoobleAdView()
    var myRansomAdView = RansomAdView()
    var myFiretailAdView = FiretailAdView()
    private func advertisementForExtraLife() {
        myGameOverView.frame.origin.x = 375*sw
        myGameOverView.removeFromSuperview()
        let whichAd = Int(arc4random_uniform(7))
        switch whichAd {
        case 0,1,2:
            view.addSubview(myQuadAdView)
            UIView.animate(withDuration: 0.4) {
                self.myQuadAdView.frame.origin.x = 0
            }
            for i in [9,8,7,6,5,4,3,2,1,0] {
                Global.delay(bySeconds: 0.9*Double(10-i)) {
                    if i != 0 {
                        self.myQuadAdView.countLabel.text = "\(i)"
                    } else {
                        self.myQuadAdView.countLabel.text = ""
                        self.myQuadAdView.addSubview(self.myQuadAdView.x)
                    }
                }
            }
        case 3:
            view.addSubview(myNumberBlazerAdView)
            UIView.animate(withDuration: 0.4) {
                self.myNumberBlazerAdView.frame.origin.x = 0
            }
            for i in [9,8,7,6,5,4,3,2,1,0] {
                Global.delay(bySeconds: 0.9*Double(10-i)) {
                    if i != 0 {
                        self.myNumberBlazerAdView.countLabel.text = "\(i)"
                    } else {
                        self.myNumberBlazerAdView.countLabel.text = ""
                        self.myNumberBlazerAdView.addSubview(self.myNumberBlazerAdView.x)
                    }
                }
            }
        case 4:
            view.addSubview(myFoobleAdView)
            UIView.animate(withDuration: 0.4) {
                self.myFoobleAdView.frame.origin.x = 0
            }
            for i in [9,8,7,6,5,4,3,2,1,0] {
                Global.delay(bySeconds: 0.9*Double(10-i)) {
                    if i != 0 {
                        self.myFoobleAdView.countLabel.text = "\(i)"
                    } else {
                        self.myFoobleAdView.countLabel.text = ""
                        self.myFoobleAdView.addSubview(self.myFoobleAdView.x)
                    }
                }
            }
            
            var count = 0
            for char in myFoobleAdView.myCharacters {
                let myLabel = UILabel()
                myLabel.frame = CGRect(origin: myFoobleAdView.locations[count], size: CGSize(width: 16*sw, height: 16*sw))
                myLabel.backgroundColor = UIColor(colorLiteralRed: 112/255, green: 194/255, blue: 206/255, alpha: 1.0)
                myLabel.textColor = .white
                myLabel.text = String(char)
                myLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 9*fontSizeMultiplier)
                myLabel.textAlignment = .center
                myLabel.layer.masksToBounds = true
                myLabel.layer.cornerRadius = 3*sw
                Global.delay(bySeconds: 0.2*Double(count)) {
                    self.myFoobleAdView.addSubview(myLabel)
                }
                count += 1
            }
            
        case 5:
            view.addSubview(myRansomAdView)
            UIView.animate(withDuration: 0.4) {
                self.myRansomAdView.frame.origin.x = 0
            }
            for i in [9,8,7,6,5,4,3,2,1,0] {
                Global.delay(bySeconds: 0.9*Double(10-i)) {
                    if i != 0 {
                        self.myRansomAdView.countLabel.text = "\(i)"
                    } else {
                        self.myRansomAdView.countLabel.text = ""
                        self.myRansomAdView.addSubview(self.myRansomAdView.x)
                    }
                }
            }
            Global.delay(bySeconds: 3.0) {
                self.myRansomAdView.myImageView.image = #imageLiteral(resourceName: "RansomAd2")
            }
            Global.delay(bySeconds: 6.0) {
                self.myRansomAdView.myImageView.image = #imageLiteral(resourceName: "RansomAd3")
            }
        case 6:
            view.addSubview(myFiretailAdView)
            UIView.animate(withDuration: 0.4) {
                self.myFiretailAdView.frame.origin.x = 0
            }
            for i in [9,8,7,6,5,4,3,2,1,0] {
                Global.delay(bySeconds: 0.9*Double(10-i)) {
                    if i != 0 {
                        self.myFiretailAdView.countLabel.text = "\(i)"
                    } else {
                        self.myFiretailAdView.countLabel.text = ""
                        self.myFiretailAdView.addSubview(self.myFiretailAdView.x)
                    }
                }
            }
        default:
            break
        }
        
        
        
        
    }
    
    @objc private func noAdsFunc(_ sender: UIButton) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Go Premium", message: "No ads for $1.99", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.purchase()
            
        }
        let restoreAction = UIAlertAction(title: "Restore Purchase", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            SwiftyStoreKit.restorePurchases(atomically: true) { results in
                if results.restoreFailedPurchases.count > 0 {
                    print("Restore Failed: \(results.restoreFailedPurchases)")
                }
                else if results.restoredPurchases.count > 0 {
                    Global.isPremium = true
                    UserDefaults.standard.set(true, forKey: "isPremiumMember")
                }
                else {
                    print("Nothing to Restore")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            print("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(restoreAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    var activityView = UIActivityIndicatorView()
    private func purchase(productId: String = "plinkerPool.iap.premium") {
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.center = self.view.center
        activityView.startAnimating()
        activityView.alpha = 0.0
        self.view.addSubview(activityView)
        SwiftyStoreKit.purchaseProduct(productId) { result in
            switch result {
            case .success( _):
                Global.isPremium = true
                UserDefaults.standard.set(true, forKey: "isPremiumMember")
                self.activityView.removeFromSuperview()
            case .error(let error):
                
                print("error: \(error)")
                print("Purchase Failed: \(error)")
                self.activityView.removeFromSuperview()
            }
        }
        
        
    }
}

