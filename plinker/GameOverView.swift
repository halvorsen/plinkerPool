//
//  GameOverView.swift
//  plinker pool?
//
//  Created by Aaron Halvorsen on 6/26/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

class GameOverView: UIView, BrothersUIAutoLayout {
    
    var (replay,menu,gameCenter,noAds,extraLife) = (ReplayButton(), MenuButton(), GameCenterButton(), SubscribeToPremiumButton(), OneMoreLife())
    var (bestScoreLabel, thisScoreLabel) = (UILabel(),UILabel())

    init() {super.init(frame: .zero)}
    
    init(backgroundColor: UIColor, buttonsColor: UIColor, bestScore: Int, thisScore: Int) {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: 375*sw, height: 667*sh)
        self.frame.origin.x = 375*sw
        self.backgroundColor = backgroundColor
        
        replay = ReplayButton(color: buttonsColor, origin: CGPoint(x: 42*sw, y: 158*sh))
     //   menu = MenuButton(color: buttonsColor, origin: CGPoint(x: 42*sw, y: 211*sh))
        gameCenter = GameCenterButton(color: buttonsColor, origin: CGPoint(x: 42*sw, y: 211*sh))
        noAds = SubscribeToPremiumButton(color: buttonsColor, origin: CGPoint(x: 42*sw, y: 264*sh))
        extraLife = OneMoreLife(color: buttonsColor, origin: CGPoint(x: 42*sw, y: 317*sh))
        self.addSubview(replay)
     //   self.addSubview(menu)
        self.addSubview(gameCenter)
        self.addSubview(noAds)
        if !Global.gaveBonusStrikes {
        self.addSubview(extraLife)
        }
        
        bestScoreLabel.frame = CGRect(x: 43*sw, y: 106*sh, width: 200*sw, height: 31*sh)
        bestScoreLabel.text = "BEST \(Global.topScore)"
        bestScoreLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 26*fontSizeMultiplier)
        bestScoreLabel.textColor = buttonsColor // or .white with black background
        self.addSubview(bestScoreLabel)
        
        thisScoreLabel.frame = CGRect(x: 43*sw, y: 29*sh, width: 200*sw, height: 84*sh)
        thisScoreLabel.text = "\(Global.points)"
        thisScoreLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 72*fontSizeMultiplier)
        thisScoreLabel.textColor = buttonsColor // or .white with black background
        self.addSubview(thisScoreLabel)
  

        UIView.animate(withDuration: 0.4) {
            self.frame.origin.x = 0
        }
        
        Global.delay(bySeconds: 0.7) {
            self.extraLife.setTitle("ONE MORE LIFE  4", for: .normal)
            Global.delay(bySeconds: 0.7) {
                self.extraLife.setTitle("ONE MORE LIFE  3", for: .normal)
                Global.delay(bySeconds: 0.7) {
                    self.extraLife.setTitle("ONE MORE LIFE  2", for: .normal)
                    Global.delay(bySeconds: 0.7) {
                        self.extraLife.setTitle("ONE MORE LIFE  1", for: .normal)
                        Global.delay(bySeconds: 0.7) {
                            self.extraLife.removeFromSuperview()
                            
                        }
                    }
                }
            }
        }
        
        let skin1Label = UILabel(frame: CGRect(x: 42*sw, y: 468*sh, width: 350*sw, height: 24*sh))
        let skin2Label = UILabel(frame: CGRect(x: 42*sw, y: 555*sh, width: 350*sw, height: 24*sh))
        skin1Label.textColor = CustomColor.color4
        skin2Label.textColor = CustomColor.color4
        skin1Label.font = UIFont(name: "HelveticaNeue-Medium", size: 18*fontSizeMultiplier)
        skin2Label.font = UIFont(name: "HelveticaNeue-Medium", size: 12*fontSizeMultiplier)
        skin1Label.text = "Congrats! Bonus Game Skin"
        let skinImage1 = UIImageView(frame: CGRect(x: 42*sw, y: 495*sh, width: 50*sw, height: 50*sw))
        let skinImage2 = UIImageView(frame: CGRect(x: 42*sw, y: 578*sh, width: 50*sw, height: 50*sw))
        
        
        switch Global.skin {
        case "none":
            if Global.level > 1 {
                Global.skin = "whale"
                UserDefaults.standard.set("whale", forKey: "skin")
                skin2Label.text = "Next Bonus Unicown @ Level 10:"
                self.addSubview(skin2Label)
                self.addSubview(skin1Label)
                skinImage1.image = #imageLiteral(resourceName: "littleWhale")
                skinImage2.image = #imageLiteral(resourceName: "littleUnicown")
                self.addSubview(skinImage1)
                self.addSubview(skinImage2)
            }
        case "whale":
            if Global.level > 10 { 
                Global.skin = "unicown"
                UserDefaults.standard.set("unicown", forKey: "skin")
                skin2Label.text = "Next Bonus Squid @ Level 25:"
                self.addSubview(skin2Label)
                self.addSubview(skin1Label)
                skinImage1.image = #imageLiteral(resourceName: "littleUnicown")
                skinImage2.image = #imageLiteral(resourceName: "littleSquid")
                self.addSubview(skinImage1)
                self.addSubview(skinImage2)
            }
        case "unicown":
            if Global.level > 25 {
                Global.skin = "squid"
                UserDefaults.standard.set("squid", forKey: "skin")
                self.addSubview(skin1Label)
                skinImage1.image = #imageLiteral(resourceName: "littleSquid")
                self.addSubview(skinImage1)
            }
        default: break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
