//
//  Global.swift
//  plinker
//
//  Created by Aaron Halvorsen on 7/5/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import Foundation

public struct Global {
    public static var skin: String = "none"
    public static var points: Int = 0
    public static var isOddController = true
    public static var targetsLeft = 9
    public static var gaveBonusStrikes = false
    public static var isPremium = false
    public static var topScore = 0
    public static var introTitle = "Plinker Pool!"
    public static var level = 1
    public static func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    public enum DispatchLevel {
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

