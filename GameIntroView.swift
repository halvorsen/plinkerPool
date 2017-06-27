//
//  GameIntroView.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/26/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

class GameIntroView: UIView, BrothersUIAutoLayout {
    
    var (play,gameCenter,noAds) = (PlayButton(), GameCenterButton(), SubscribeToPremiumButton())
    
    init(backgroundColor: UIColor, buttonsColor: UIColor, logo: UIImageView) {
        super.init(frame: .zero)
        self.frame = superview!.bounds
        self.alpha = 0.0
        self.backgroundColor = backgroundColor
        play = PlayButton(color: buttonsColor, origin: CGPoint(x: 48*sw, y: 158*sh))
        gameCenter = GameCenterButton(color: buttonsColor, origin: CGPoint(x: 48*sw, y: 211*sh))
        noAds = SubscribeToPremiumButton(color: buttonsColor, origin: CGPoint(x: 48*sw, y: 264*sh))
        self.addSubview(play)
        self.addSubview(gameCenter)
        self.addSubview(noAds)
        self.addSubview(logo)
        
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1.0
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

