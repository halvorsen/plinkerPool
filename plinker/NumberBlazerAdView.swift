//
//  GameOverView.swift
//  plinker pool?
//
//  Created by Aaron Halvorsen on 6/26/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

class NumberBlazerAdView: UIView, BrothersUIAutoLayout {
    var countLabel = UILabel()
    var yOrigin = CGFloat()
    var x = UIImageView()
    var myOnceDelegate: onceDelegate?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if countLabel.text! == "" && pos.x > 250*sw && pos.y < 150*sh {
            UIView.animate(withDuration: 0.4) {
                self.frame.origin.x = 375*self.sw
            }
            Global.delay(bySeconds: 0.6) {
                self.myOnceDelegate?.onceTouch()
                self.removeFromSuperview()
            }
            x.removeFromSuperview()
        } else  {
            
            url(string: "itms-apps://itunes.apple.com/app/id1152732418")
            x.removeFromSuperview()
            Global.delay(bySeconds: 0.6) {
                self.myOnceDelegate?.onceTouch()
                self.removeFromSuperview()
            }//open Number Blazer
        }
        
        
        
        countLabel.text = "10"
    }
    
    private func url(string: String) {
        if let url = URL(string: string),
            UIApplication.shared.canOpenURL(url)
            
        {self.myOnceDelegate?.onceTouch()
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        yOrigin = (667*sh - 667*sw)/2
        self.frame = CGRect(x: 0, y: 0, width: 375*sw, height: 667*sh)
        self.frame.origin.x = 375*sw
        self.backgroundColor = UIColor(colorLiteralRed: 121/255, green: 121/255, blue: 121/255, alpha: 1.0)
        let myImageView = UIImageView(frame: CGRect(x: 0, y: yOrigin, width: 375*sw, height: 667*sw))
        myImageView.image = #imageLiteral(resourceName: "BlazerAd")
        self.addSubview(myImageView)
        
        let myBez = UIBezierPath(arcCenter: CGPoint(x: 332*sw,y: 42*sh), radius: 19*sw, startAngle: 0, endAngle: .pi*2, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = myBez.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(shapeLayer)
        
        x = UIImageView(frame: CGRect(x: 313*sw, y: 23*sh, width: 38*sw, height: 38*sw))
        x.image = #imageLiteral(resourceName: "x")
        
        countLabel = UILabel(frame: CGRect(x: 313*sw, y: 23*sh, width: 38*sw, height: 38*sw))
        countLabel.text = "10"
        countLabel.textAlignment = .center
        countLabel.font = UIFont(name: "HelveticaNeue", size: 14*fontSizeMultiplier)
        self.addSubview(countLabel)
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
