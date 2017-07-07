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



//add this protocol to your view controller
protocol BrothersGoPremium: class {
    func purchase(productId: String) -> Bool
    func goPremiumFunc()
}

extension BrothersGoPremium where Self: UIViewController {
    
    func purchase(productId: String = "") -> Bool {
        var myBool = false
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.center = self.view.center
        activityView.startAnimating()
        activityView.alpha = 0.0
        self.view.addSubview(activityView)
        SwiftyStoreKit.purchaseProduct(productId) { result in
            switch result {
            case .success( _):
                activityView.removeFromSuperview()
            case .error(let error):
                //self.userWarning(title: "", message: "Purchase Failed: \(error)")
                print("error: \(error)")
                print("Purchase Failed: \(error)")
                activityView.removeFromSuperview()
            }
        }
        return false //hack
    }
    
    
    func goPremiumFunc() {
        // Create the alert controller
        let alertController = UIAlertController(title: "Go Premium", message: "Remove all Ads for $1.99", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.purchase()
            
        }
        let restoreAction = UIAlertAction(title: "Restore Purchase", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            SwiftyStoreKit.restorePurchases(atomically: true) { results in
                if results.restoreFailedPurchases.count > 0 {
                    print("Restore Failed: \(results.restoreFailedPurchases)")
                }
                else if results.restoredPurchases.count > 0 {
                    
                    
                
                }
                else {
                    print("Nothing to Restore")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            print("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(restoreAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
     //   self.present(alertController, animated: true, completion: nil)
    }
    
}




