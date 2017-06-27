//
//  PurchaseButton.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/26/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit


class SubscribeToPremiumButton: UIButton, BrothersUIAutoLayout {
 
    init() {super.init(frame: .zero)}
    init(color: UIColor, origin: CGPoint) {
        super.init(frame: .zero)
        self.titleLabel!.text! = "NO ADS"
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18*fontSizeMultiplier)
        self.backgroundColor = color
        self.frame.size = CGSize(width: 96*sw, height: 42*sh)
        self.frame.origin = origin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

class PlayButton: UIButton, BrothersUIAutoLayout {
  
    init() {super.init(frame: .zero)}
    init(color: UIColor, origin: CGPoint) {
        super.init(frame: .zero)
        self.titleLabel?.text = "PLAY"
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18*fontSizeMultiplier)
        self.backgroundColor = color
        self.frame.size = CGSize(width: 72*sw, height: 42*sh)
        self.frame.origin = origin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ReplayButton: UIButton, BrothersUIAutoLayout {
    
    init() {super.init(frame: .zero)}
    init(color: UIColor, origin: CGPoint) {
        super.init(frame: .zero)
        self.titleLabel?.text = "REPLAY"
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18*fontSizeMultiplier)
        self.backgroundColor = color
        self.frame.size = CGSize(width: 96*sw, height: 42*sh)
        self.frame.origin = origin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class GameCenterButton: UIButton, BrothersUIAutoLayout {
    
    init() {super.init(frame: .zero)}
    init(color: UIColor, origin: CGPoint) {
        super.init(frame: .zero)
        self.titleLabel!.text! = "GAME CENTER"
        self.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 18*fontSizeMultiplier)
        self.backgroundColor = color
        self.frame.size = CGSize(width: 154*sw, height: 42*sh)
        self.frame.origin = origin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuButton: UIButton, BrothersUIAutoLayout {
    
    init() {super.init(frame: .zero)}
    init(color: UIColor, origin: CGPoint) {
        super.init(frame: .zero)
        self.titleLabel?.text = "MENU"
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18*fontSizeMultiplier)
        self.backgroundColor = color
        self.frame.size = CGSize(width: 77*sw, height: 42*sh)
        self.frame.origin = origin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

