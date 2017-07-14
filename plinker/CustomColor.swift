//
//  Color.swift
//  plinker
//
//  Created by Aaron Halvorsen on 7/3/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import UIKit

public struct CustomColor {
    
    public static var color2: UIColor = UIColor(colorLiteralRed: 252/255, green: 52/255, blue: 104/255, alpha: 1.0)
    public static var color1: UIColor = UIColor(colorLiteralRed: 255/255, green: 194/255, blue: 205/255, alpha: 1.0)
    public static var color3: UIColor = UIColor(colorLiteralRed: 255/255, green: 147/255, blue: 172/255, alpha: 1.0)
    public static var color4: UIColor = UIColor(colorLiteralRed: 255/255, green: 8/255, blue: 74/255, alpha: 1.0)
    public static let cueColor: UIColor = UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 1.0)
    public static let boundaryColor: UIColor = UIColor(colorLiteralRed: 7/255, green: 7/255, blue: 7/255, alpha: 0.6)
    public static let gray: UIColor = UIColor(colorLiteralRed: 162/255, green: 162/255, blue: 162/255, alpha: 1.0)
    
    public static let colorDictionary: [ColorScheme:(UIColor,UIColor,UIColor,UIColor)] = [
        
        .lightBlue:
            (UIColor(colorLiteralRed: 22/255, green: 146/255, blue: 254/255, alpha: 1.0),
             UIColor(colorLiteralRed: 56/255, green: 160/255, blue: 254/255, alpha: 1.0),
             UIColor(colorLiteralRed: 124/255, green: 191/255, blue: 254/255, alpha: 1.0),
             UIColor(colorLiteralRed: 189/255, green: 222/255, blue: 254/255, alpha: 1.0)),
        
        .darkBlue:
            (UIColor(colorLiteralRed: 14/255, green: 40/255, blue: 249/255, alpha: 1.0),
             UIColor(colorLiteralRed: 60/255, green: 81/255, blue: 249/255, alpha: 1.0),
             UIColor(colorLiteralRed: 133/255, green: 146/255, blue: 249/255, alpha: 1.0),
             UIColor(colorLiteralRed: 189/255, green: 196/255, blue: 249/255, alpha: 1.0)),
        .teal:
            (UIColor(colorLiteralRed: 18/255, green: 239/255, blue: 248/255, alpha: 1.0),
             UIColor(colorLiteralRed: 52/255, green: 244/255, blue: 252/255, alpha: 1.0),
             UIColor(colorLiteralRed: 134/255, green: 245/255, blue: 250/255, alpha: 1.0),
             UIColor(colorLiteralRed: 187/255, green: 246/255, blue: 249/255, alpha: 1.0)),
        .darkPurple:
            (UIColor(colorLiteralRed: 141/255, green: 21/255, blue: 251/255, alpha: 1.0),
             UIColor(colorLiteralRed: 156/255, green: 52/255, blue: 252/255, alpha: 1.0),
             UIColor(colorLiteralRed: 193/255, green: 132/255, blue: 249/255, alpha: 1.0),
             UIColor(colorLiteralRed: 220/255, green: 190/255, blue: 248/255, alpha: 1.0)),
        .lightPurple:
            (UIColor(colorLiteralRed: 207/255, green: 19/255, blue: 251/255, alpha: 1.0),
             UIColor(colorLiteralRed: 213/255, green: 55/255, blue: 250/255, alpha: 1.0),
             UIColor(colorLiteralRed: 228/255, green: 129/255, blue: 251/255, alpha: 1.0),
             UIColor(colorLiteralRed: 237/255, green: 188/255, blue: 248/255, alpha: 1.0)),
        .pink:
            (UIColor(colorLiteralRed: 255/255, green: 8/255, blue: 74/255, alpha: 1.0),
             UIColor(colorLiteralRed: 249/255, green: 52/255, blue: 104/255, alpha: 1.0),
             UIColor(colorLiteralRed: 252/255, green: 147/255, blue: 172/255, alpha: 1.0),
             UIColor(colorLiteralRed: 255/255, green: 194/255, blue: 205/255, alpha: 1.0)),
        .red:
            (UIColor(colorLiteralRed: 251/255, green: 20/255, blue: 20/255, alpha: 1.0),
             UIColor(colorLiteralRed: 252/255, green: 60/255, blue: 60/255, alpha: 1.0),
             UIColor(colorLiteralRed: 252/255, green: 126/255, blue: 126/255, alpha: 1.0),
             UIColor(colorLiteralRed: 252/255, green: 194/255, blue: 194/255, alpha: 1.0)),
        .orange:
            (UIColor(colorLiteralRed: 253/255, green: 179/255, blue: 18/255, alpha: 1.0),
             UIColor(colorLiteralRed: 250/255, green: 192/255, blue: 65/255, alpha: 1.0),
             UIColor(colorLiteralRed: 248/255, green: 213/255, blue: 136/255, alpha: 1.0),
             UIColor(colorLiteralRed: 251/255, green: 231/255, blue: 190/255, alpha: 1.0)),
        .yellow:
            (UIColor(colorLiteralRed: 250/255, green: 231/255, blue: 17/255, alpha: 1.0),
             UIColor(colorLiteralRed: 252/255, green: 236/255, blue: 52/255, alpha: 1.0),
             UIColor(colorLiteralRed: 254/255, green: 243/255, blue: 122/255, alpha: 1.0),
             UIColor(colorLiteralRed: 247/255, green: 243/255, blue: 188/255, alpha: 1.0)),
        .lime:
            (UIColor(colorLiteralRed: 177/255, green: 250/255, blue: 21/255, alpha: 1.0),
             UIColor(colorLiteralRed: 191/255, green: 251/255, blue: 63/255, alpha: 1.0),
             UIColor(colorLiteralRed: 212/255, green: 249/255, blue: 133/255, alpha: 1.0),
             UIColor(colorLiteralRed: 231/255, green: 251/255, blue: 188/255, alpha: 1.0)),
        .green:
            (UIColor(colorLiteralRed: 38/255, green: 250/255, blue: 17/255, alpha: 1.0),
             UIColor(colorLiteralRed: 74/255, green: 253/255, blue: 57/255, alpha: 1.0),
             UIColor(colorLiteralRed: 139/255, green: 247/255, blue: 128/255, alpha: 1.0),
             UIColor(colorLiteralRed: 193/255, green: 251/255, blue: 187/255, alpha: 1.0))
        
    ]
    
    public static func changeCustomColor(colorScheme: ColorScheme) {
        
        CustomColor.color1 = CustomColor.colorDictionary[colorScheme]!.0
        CustomColor.color2 = CustomColor.colorDictionary[colorScheme]!.1
        CustomColor.color3 = CustomColor.colorDictionary[colorScheme]!.2
        CustomColor.color4 = CustomColor.colorDictionary[colorScheme]!.3
//        switch colorScheme {
//        case lightBlue:
//        case darkBlue:
//        case teal:
//        case darkPurple:
//        case lightPurple:
//        case pink:
//        case red:
//        case orange:
//        case yellow:
//        case lime:
//        case green:
//        }
    }
    
   
    
}

public enum ColorScheme: Int {
    case lightBlue = 5
    case darkBlue = 1
    case teal = 2
    case darkPurple = 3
    case lightPurple = 4
    case pink = 0
    case red = 6
    case orange = 7
    case yellow = 8
    case lime = 9
    case green = 10
}



