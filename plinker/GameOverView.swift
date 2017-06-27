//
//  GameOverView.swift
//  plinker pool?
//
//  Created by Aaron Halvorsen on 6/26/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

class GameOverView: UIView, BrothersUIAutoLayout {
    
    var (replay,menu,gameCenter,noAds) = (ReplayButton(), MenuButton(), GameCenterButton(), SubscribeToPremiumButton())
    var (bestScoreLabel, thisScoreLabel) = (UILabel(),UILabel())

    init(backgroundColor: UIColor, buttonsColor: UIColor, bestScore: Int, thisScore: Int) {
        super.init(frame: .zero)
        self.frame = superview!.bounds
        self.frame.origin.x = -375*sw
        self.backgroundColor = backgroundColor
        replay = ReplayButton(color: buttonsColor, origin: CGPoint(x: 48*sw, y: 158*sh))
        menu = MenuButton(color: buttonsColor, origin: CGPoint(x: 48*sw, y: 211*sh))
        gameCenter = GameCenterButton(color: buttonsColor, origin: CGPoint(x: 48*sw, y: 264*sh))
        noAds = SubscribeToPremiumButton(color: buttonsColor, origin: CGPoint(x: 48*sw, y: 317*sh))
        self.addSubview(replay)
        self.addSubview(menu)
        self.addSubview(gameCenter)
        self.addSubview(noAds)
        
        bestScoreLabel.frame = CGRect(x: 43*sw, y: 106*sh, width: 200*sw, height: 31*sh)
        bestScoreLabel.text = String(bestScore)
        bestScoreLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 26*fontSizeMultiplier)
        bestScoreLabel.textColor = .white
        self.addSubview(bestScoreLabel)
        
        thisScoreLabel.frame = CGRect(x: 43*sw, y: 29*sh, width: 200*sw, height: 84*sh)
        thisScoreLabel.text = String(thisScore)
        thisScoreLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 72*fontSizeMultiplier)
        thisScoreLabel.textColor = .white
        self.addSubview(thisScoreLabel)

        UIView.animate(withDuration: 0.4) {
            self.frame.origin.x = 0
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
