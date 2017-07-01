//
//  Gate.swift
//  plinker
//
//  Created by Aaron Halvorsen on 7/1/17.
//  Copyright © 2017 Aaron Halvorsen. All rights reserved.
//

import Foundation

struct Gate {
    
    enum State {
        case open
        case closed
    }
    
    var myState: State = .open
    
    enum GateColor: String {
        case color1 = "color1"
        case color2 = "color2"
        case color3 = "color3"
        case color4 = "color4"
        case boundaryColor = "boundaryColor"
    }
    
    var myColor: GateColor = .boundaryColor
    
    enum GatePosition {
        case top
        case rightTop
        case rightBottom
        case bottom
        case leftBottom
        case leftTop
    }
    
    var position: GatePosition = .top
}
