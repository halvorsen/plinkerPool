//
//  Animation.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/30/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

class Animation: UIView, BrothersUIAutoLayout {
    
    
    
    init(colors: [UIColor]? = nil) {
        var _colors = colors
        let frame = CGRect(x: 0, y: 0, width: 375*UIScreen.main.bounds.width/375, height: 667*UIScreen.main.bounds.height/667)
        super.init(frame: frame)
        
        let ballRadius: CGFloat = 12
        //  var balls = [CAShapeLayer]()
        var balls = [UILabel]()
        var locations: [CGPoint] = [
            CGPoint(x: 118*sw, y: 0),
            CGPoint(x: 375*sw, y: 270*sh),
            CGPoint(x: 375*sw, y: 523*sh),
            CGPoint(x: 257*sw, y: 667*sh),
            CGPoint(x: 0, y: 396*sh),
            CGPoint(x: 0, y: 144*sh)
        ]
        if colors == nil {
            let color1: UIColor = UIColor(colorLiteralRed: 252/255, green: 52/255, blue: 104/255, alpha: 1.0)
            let color2: UIColor = UIColor(colorLiteralRed: 255/255, green: 194/255, blue: 205/255, alpha: 1.0)
            let color3: UIColor = UIColor(colorLiteralRed: 255/255, green: 147/255, blue: 172/255, alpha: 1.0)
            let color4: UIColor = UIColor(colorLiteralRed: 255/255, green: 8/255, blue: 74/255, alpha: 1.0)
            _colors = [color1,color2,color3,color4,color1,color2]
            locations.removeAll()
            locations.append(CGPoint(x: 118*sw, y: -50*sh))
            locations.append(CGPoint(x: 425*sw, y: 270*sh))
            locations.append(CGPoint(x: 425*sw, y: 523*sh))
            locations.append(CGPoint(x: 257*sw, y: 717*sh))
            locations.append(CGPoint(x: -50*sw, y: 396*sh))
            locations.append(CGPoint(x: -50*sw, y: 144*sh))
        }
        
        let centerOfView = self.center
        print(centerOfView)
        let smallRadius = 30*sw
        let largeRadius = 60*sw
        let largeLocations: [CGPoint] = [
            CGPoint(x: centerOfView.x,
                    y: centerOfView.y - largeRadius),
            CGPoint(x:  centerOfView.x + largeRadius*cos(.pi/6),
                    y:  centerOfView.y - largeRadius*sin(.pi/6)),
            CGPoint(x:  centerOfView.x + largeRadius*cos(.pi/6),
                    y:  centerOfView.y + largeRadius*sin(.pi/6)),
            CGPoint(x: centerOfView.x,
                    y: centerOfView.y + largeRadius),
            CGPoint(x:  centerOfView.x - largeRadius*cos(.pi/6),
                    y:  centerOfView.y + largeRadius*sin(.pi/6)),
            CGPoint(x:  centerOfView.x - largeRadius*cos(.pi/6),
                    y:  centerOfView.y - largeRadius*sin(.pi/6))
        ]
        print(largeLocations)
        let smallLocations: [CGPoint] = [
            CGPoint(x: centerOfView.x,
                    y: centerOfView.y - smallRadius),
            CGPoint(x:  centerOfView.x + smallRadius*cos(.pi/6),
                    y:  centerOfView.y - smallRadius*sin(.pi/6)),
            CGPoint(x:  centerOfView.x + smallRadius*cos(.pi/6),
                    y:  centerOfView.y + smallRadius*sin(.pi/6)),
            CGPoint(x: centerOfView.x,
                    y: centerOfView.y + smallRadius),
            CGPoint(x:  centerOfView.x - smallRadius*cos(.pi/6),
                    y:  centerOfView.y + smallRadius*sin(.pi/6)),
            CGPoint(x:  centerOfView.x - smallRadius*cos(.pi/6),
                    y:  centerOfView.y - smallRadius*sin(.pi/6))
        ]

        self.frame = frame
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        var i = 0

        for location in locations {
            let myLabel = UILabel(frame: CGRect(x: location.x - ballRadius*self.sw, y: location.y - ballRadius*self.sw, width: ballRadius*2*sw, height: ballRadius*2*sw))
            myLabel.layer.cornerRadius = ballRadius*sw
            myLabel.layer.masksToBounds = true
            myLabel.backgroundColor = _colors?[i]
            self.addSubview(myLabel)
            balls.append(myLabel)
            i += 1
        }
        i = 0
        delay(bySeconds: 1.0) {
            for location in smallLocations {
                UIView.animate(withDuration: 1.0) {
                    balls[i].frame.origin.x = location.x - ballRadius*self.sw
                    balls[i].frame.origin.y = location.y - ballRadius*self.sw
                }
                
                i += 1
            }

            self.delay(bySeconds: 1.0) {
                i = 0
                for location in largeLocations {
                    UIView.animate(withDuration: 1.0) {
                        balls[i].frame.origin.x = location.x - ballRadius*self.sw
                        balls[i].frame.origin.y = location.y - ballRadius*self.sw
                    }
                    i += 1
                }
                self.delay(bySeconds: 1.0) {
                    i = 0
                    for location in largeLocations {
                        UIView.animate(withDuration: 1.0) {
                            balls[i].frame.origin.x = location.x - ballRadius*self.sw
                            balls[i].frame.origin.y = location.y - ballRadius*self.sw
                        }
                        i += 1
                    }
                    self.delay(bySeconds: 1.0) {
                        
                        UIView.animate(withDuration: 1.0){
                            self.alpha = 0

                        }
                        self.delay(bySeconds: 1.2) {
                            
                            self.removeFromSuperview()
                        }
                        
                    }
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

extension Animation {
    
    func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
}
