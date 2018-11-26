//
//  Actor.swift
//  Stage Mage
//
//  Created by Jacky Liang and Owen Brouse on 2018-11-05.
//  Copyright © 2018 KingByngInc. All rights reserved.
//
import UIKit

class Item: NSObject {
    var x: Int
    var y: Int
    var width: Int
    var select: Bool
    var height: Int
    var name: String
    var type: String
    var colour: UIColor
    var imageView = UIImageView()
    
    init?(x: Int, y: Int, width: Int, height: Int, name: String, type: String){
        self.x = x
        self.y = y
        self.select = false
        self.width = width
        self.height = height
        self.type = type
        self.name = name
        self.colour = UIColor.black
        self.imageView = UIImageView(image: UIImage(named: self.type))
        self.imageView.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
        self.imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    }
    
    func updateImage(xPos: Int,yPos: Int) {
       // if self.select==true{colour = UIColor.purple
      //  }else               {colour = UIColor.black  }
        
        imageView.tintColor = colour
        imageView.frame = CGRect(x: xPos, y: yPos, width: self.width, height: self.height)
    }
    
    func isTapped(tX: Int,tY: Int) -> Bool {
        if tX>self.x && tX < (self.x+self.width) {
            if tY>(self.y) && tY<(self.y+self.height){
                return true
            }
        }
        return false
    }
}
