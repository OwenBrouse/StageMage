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
    
    init?(x: Int, y: Int){
        
    self.x = x
    self.y = y
    }
    func display() -> UIView{
        //return x
        let imageName = "Actor Shape Tool"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.x, y: self.y, width: 100, height: 100)
        return imageView
        
    }
    
    func teleport() {
        self.x = 500
        self.y = 500
    }
}
