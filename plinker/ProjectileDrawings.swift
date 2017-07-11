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
    var squarePath = [UIBezierPath]()
    var circlePath = UIBezierPath()
    var startLine = CGPoint(x: 0, y: 0)
    var endLine = CGPoint(x: -100, y: -100)
    var verticalGrid = [CGRect]()
    var horizontalGrid = [CGRect]()
    var isVert = false
    var isHorz = false
    
    init() {
        
        let frame = CGRect(x: 0, y: 0, width: 375*UIScreen.main.bounds.width/375, height: 667*UIScreen.main.bounds.height/667)
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        
        verticalGrid = [
            CGRect(x: 0, y: 0, width: 375*sw/5, height: 667*sh),
            CGRect(x: 2*375*sw/5, y: 0, width: 375*sw/5, height: 667*sh),
            CGRect(x: 4*375*sw/5, y: 0, width: 375*sw/5, height: 667*sh)
        ]
        
        horizontalGrid = [
            CGRect(x: 0, y: 0, width: 375*sw, height: 667*sh/9),
            CGRect(x: 0, y: 2*667*sh/9, width: 375*sw, height: 667*sh/9),
            CGRect(x: 0, y: 4*667*sh/9, width: 375*sw, height: 667*sh/9),
            CGRect(x: 0, y: 6*667*sh/9, width: 375*sw, height: 667*sh/9),
            CGRect(x: 0, y: 8*667*sh/9, width: 375*sw, height: 667*sh/9)
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        if startLine.x > 0 {
        if (endLine.y > 667*sh || endLine.y < 0 || isVert) && !(endLine.x > 375*sw || endLine.x < 0) {
            squarePath.removeAll()
            for i in 0..<verticalGrid.count {
            squarePath.append(UIBezierPath(rect: verticalGrid[i]))
            //squarePath[i].stroke()
            UIColor(colorLiteralRed: 145/255, green: 145/255, blue: 145/255, alpha: 0.03).set()
            squarePath[i].fill()
                isVert = true
                isHorz = false
            }
            
        } else if endLine.x > 375*sw || endLine.x < 0 || isHorz {
           squarePath.removeAll()
            for i in 0..<horizontalGrid.count {
                squarePath.append(UIBezierPath(rect: horizontalGrid[i]))
              //  squarePath[i].stroke()
                UIColor(colorLiteralRed: 145/255, green: 145/255, blue: 145/255, alpha: 0.03).set()
                squarePath[i].fill()
                isVert = false
                isHorz = true
            }
            
        }
        }
        
        aPath.removeAllPoints()
        aPath.move(to: startLine)
        aPath.addLine(to: endLine)
        UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 1.0).set()
        aPath.stroke()
        
        circlePath = UIBezierPath(arcCenter: endLine, radius: 24*UIScreen.main.bounds.width/750, startAngle: CGFloat(0), endAngle:.pi*2, clockwise: true)
        // circlePath.stroke()
        UIColor(colorLiteralRed: 162/255, green: 162/255, blue: 162/255, alpha: 1.0).set()
        
        circlePath.fill()
        
    }
    

}
