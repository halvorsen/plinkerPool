//
//  UIProtocolExtentions.swift
//  plinker
//
//  Created by Aaron Halvorsen on 6/26/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import StoreKit

protocol BrothersUIAutoLayout {
    
    var sw: CGFloat {get}
    var sh: CGFloat {get}
    var fontSizeMultiplier: CGFloat {get}
    
    func addButton(name: UIButton, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, title: String, font: String, fontSize: CGFloat, titleColor: UIColor, bgColor: UIColor, cornerRad: CGFloat, boarderW: CGFloat, boarderColor: UIColor, act: Selector, alignment: UIControlContentHorizontalAlignment)
    
    func addLabel(name: UILabel, text: String, textColor: UIColor, textAlignment: NSTextAlignment, fontName: String, fontSize: CGFloat, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, lines: Int)
    
}

extension BrothersUIAutoLayout {
    
    var sw: CGFloat {get{return UIScreen.main.bounds.width/375}}
    var sh: CGFloat {get{return UIScreen.main.bounds.height/667}}
    var fontSizeMultiplier: CGFloat {get{return UIScreen.main.bounds.width / 375}}
    
    func addButton(name: UIButton, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, title: String, font: String, fontSize: CGFloat, titleColor: UIColor, bgColor: UIColor, cornerRad: CGFloat, boarderW: CGFloat, boarderColor: UIColor, act:
        Selector, alignment: UIControlContentHorizontalAlignment = .left) {
        name.frame = CGRect(x: x*sw, y: y*sh, width: width*sw, height: height*sh)
        name.setTitle(title, for: UIControlState.normal)
        name.titleLabel!.font = UIFont(name: font, size: fontSizeMultiplier*fontSize)
        name.setTitleColor(titleColor, for: .normal)
        name.backgroundColor = bgColor
        name.layer.cornerRadius = cornerRad
        name.layer.borderWidth = boarderW
        name.layer.borderColor = boarderColor.cgColor
        name.addTarget(self, action: act, for: .touchUpInside)
        name.contentHorizontalAlignment = alignment
        
    }
    
    func addLabel(name: UILabel, text: String, textColor: UIColor, textAlignment: NSTextAlignment, fontName: String, fontSize: CGFloat, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, lines: Int) {
        
        name.text = text
        name.textColor = textColor
        name.textAlignment = textAlignment
        name.font = UIFont(name: fontName, size: fontSizeMultiplier*fontSize)
        name.frame = CGRect(x: x*sw, y: y*sh, width: width*sw, height: height*sh)
        name.numberOfLines = lines
        
    }
}

