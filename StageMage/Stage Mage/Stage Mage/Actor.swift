//
//  Actor.swift
//  Stage Mage
//
//  Created by Jacky Liang on 2018-11-05.
//  Copyright © 2018 KingByngInc. All rights reserved.
//
import UIKit

class Actor: NSObject {
    var x: Int
    var y: Int
    var width: Int
    var select: Bool
    var height: Int
    var imageView = UIImageView(image: UIImage(named: "Actor Shape Tool")!)
    
    init?(x: Int, y: Int, width: Int, height: Int){
        self.x = x
        self.y = y
        self.select = false
        self.width = width
        self.height = width
        self.imageView.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
    }
    
    func updateImage() {
        imageView.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
    }
    
    func isTapped(tX: Int,tY: Int) {
        if tX>self.x && tX < (self.x+self.width) {
            if tY>self.y && tY<(self.y+self.height){
                self.select = true
            }
        }
    }
}
