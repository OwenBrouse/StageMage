//
//  Actor.swift
//  Stage Mage
//
//  Created by Jacky Liang and Owen Brouse on 2018-11-05.
//  Copyright © 2018 KingByngInc. All rights reserved.
//
import UIKit

class Animator: NSObject {
    var x: Int
    var y: Int
    var time: Double
    var identity: Int
    var type: Bool
    
    init?(x: Int, y: Int, time: Double, identity: Int, type: Bool){
        self.x = x
        self.y = y
        self.time = time
        self.identity = identity
        self.type = type
    }
}
