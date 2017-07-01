//
//  ProjectileDrawings.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/28/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

class ProjectileDrawings: UIView, BrothersUIAutoLayout {
    var aPath = UIBezierPath()
    var circlePath = UIBezierPath()
    var startLine = CGPoint(x: 0, y: 0)
    var endLine = CGPoint(x: -100, y: -100)
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: 375*UIScreen.main.bounds.width/375, height: 667*UIScreen.main.bounds.height/667)
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        aPath.removeAllPoints()
        
        aPath.move(to: startLine)
        
        aPath.addLine(to: endLine)
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
       // aPath.close()
        
        //If you want to stroke it with a red color
        UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 1.0).set()
        aPath.stroke()
        //If you want to fill it as well
    //    aPath.fill()
        
        
        circlePath = UIBezierPath(arcCenter: endLine, radius: 25*UIScreen.main.bounds.width/750, startAngle: CGFloat(0), endAngle:.pi*2, clockwise: true)
        UIColor(colorLiteralRed: 162/255, green: 162/255, blue: 162/255, alpha: 1.0).set()
      //  circlePath.stroke()
        
        circlePath.fill()
    }
    

}
