//
//  GameOverView.swift
//  plinker pool?
//
//  Created by Aaron Halvorsen on 6/26/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

class GameOverView: UIView, BrothersUIAutoLayout, DotTap {
    
    var myColorScheme:ColorScheme?
    
    func tap(colorScheme: ColorScheme) {
        UserDefaults.standard.set(colorScheme.rawValue, forKey: "colorScheme")
        CustomColor.changeCustomColor(colorScheme: colorScheme)
        myColorScheme = colorScheme
        self.bestScoreLabel.textColor = CustomColor.color2
        self.thisScoreLabel.textColor = CustomColor.color2
        self.gameCenter.backgroundColor = CustomColor.color2
        self.extraLife.layer.borderColor = CustomColor.color2.cgColor
        self.extraLife.setTitleColor(CustomColor.color2, for: .normal)
        self.noAds.backgroundColor = CustomColor.color2
        self.replay.backgroundColor = CustomColor.color2
        
    }

    var (replay,menu,gameCenter,noAds,extraLife) = (ReplayButton(), MenuButton(), GameCenterButton(), SubscribeToPremiumButton(), OneMoreLife())
    var (bestScoreLabel, thisScoreLabel) = (UILabel(),UILabel())

    init() {super.init(frame: .zero)}
    
    init(backgroundColor: UIColor, buttonsColor: UIColor, bestScore: Int, thisScore: Int, colorScheme: ColorScheme) {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: 375*sw, height: 667*sh)
        self.frame.origin.x = 375*sw
        self.backgroundColor = backgroundColor
        myColorScheme = colorScheme
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
        bestScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24*fontSizeMultiplier)
        bestScoreLabel.textColor = buttonsColor // or .white with black background
        bestScoreLabel.addTextSpacing(spacing: 1.85*fontSizeMultiplier)
        self.addSubview(bestScoreLabel)
        
        thisScoreLabel.frame = CGRect(x: 43*sw, y: 29*sh, width: 200*sw, height: 84*sh)
        thisScoreLabel.text = "\(Global.points)"
        thisScoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 68*fontSizeMultiplier)
        thisScoreLabel.textColor = buttonsColor // or .white with black background
        thisScoreLabel.addTextSpacing(spacing: 5.23*fontSizeMultiplier)
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
        
        let skin1Label = UILabel(frame: CGRect(x: 42*sw, y: 418*sh, width: 350*sw, height: 24*sh))
        let skin2Label = UILabel(frame: CGRect(x: 42*sw, y: 505*sh, width: 350*sw, height: 24*sh))
        skin1Label.textColor = CustomColor.color1
        skin2Label.textColor = CustomColor.color1
        skin1Label.font = UIFont(name: "HelveticaNeue-Medium", size: 18*fontSizeMultiplier)
        skin2Label.font = UIFont(name: "HelveticaNeue-Medium", size: 12*fontSizeMultiplier)
        skin1Label.text = "Congrats! Bonus Game Skin"
        let skinImage1 = UIImageView(frame: CGRect(x: 42*sw, y: 445*sh, width: 50*sw, height: 50*sw))
        let skinImage2 = UIImageView(frame: CGRect(x: 42*sw, y: 528*sh, width: 50*sw, height: 50*sw))
        
        
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
        
        
        //add dots at bottom
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 606*sh, width: 375*sw, height: 45*sw))
        scrollView.contentSize = CGSize(width: 11*45*sw, height: scrollView.bounds.height)
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        let schemeArray: [ColorScheme] = [
        .lightBlue,
        .darkBlue,
        .teal,
        .darkPurple,
        .lightPurple,
        .pink,
        .red,
        .orange,
        .yellow,
        .lime,
        .green
        ]
        var count = 0
        for scheme in schemeArray {
            let myDot = Dot(color: CustomColor.colorDictionary[scheme]!.1, origin: CGPoint(x:45*CGFloat(count)*sw,y:0), colorScheme: scheme)
            scrollView.addSubview(myDot)
            myDot.tapDelegate = self
            count += 1
        }
        self.addSubview(scrollView)
        scrollView.contentOffset.x = sw*22.5
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
