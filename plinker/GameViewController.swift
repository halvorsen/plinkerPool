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

class GameViewController: UIViewController, refreshDelegate {

    
    var cueTrajectory = ProjectileDrawings()
    var scene = GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            scene = GameScene(size: CGSize(width: view.bounds.width, height: view.bounds.height))
            scene.scaleMode = .aspectFill
            scene.delegateRefresh = self
            view.presentScene(scene)
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//                scene.delegateRefresh = self as? SKSceneDelegate
//                // Present the scene
//                view.presentScene(scene)
//                scene.viewController = self
//            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        if !cueTrajectory.isDescendant(of: view) {
            view.addSubview(cueTrajectory)
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
        print("start: \(start)")
        print("end: \(end)")
        let x = scene.cue.position.x
        let y = 667 - scene.cue.position.y
    cueTrajectory.startLine = CGPoint(x: x, y: y)//scene.cue.position
    cueTrajectory.endLine = CGPoint(x: 3*(end.x - start.x) + x, y: -3*(end.y - start.y) + y)
    cueTrajectory.setNeedsDisplay()
        
    }



    override var prefersStatusBarHidden: Bool {
        return true
    }
}

