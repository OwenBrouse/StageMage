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
    var height: Int
    var angle: CGFloat
    var select: Bool
    var name: String
    var type: String
    var colour: UIColor
    var imageView = UIImageView()
    var sv = UIView()
    let selectView = UIImageView(image: UIImage(named: "Select"))
    
    init?(x: Int, y: Int, width: Int, height: Int, angle: CGFloat, name: String, type: String){
        self.x = x
        self.y = y
        self.select = false
        self.width = width
        self.height = height
        self.angle = angle
        self.type = type
        self.name = name
        self.colour = UIColor.black
        self.imageView = UIImageView(image: UIImage(named: self.type))
        self.imageView.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
        self.imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        self.selectView.image = selectView.image?.withRenderingMode(.alwaysTemplate)
        self.sv.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
        self.sv.addSubview(self.imageView)
    }
    
    func updateImage(xPos: Int,yPos: Int) {
        
        imageView.removeFromSuperview()
        
        sv.transform = CGAffineTransform(rotationAngle: self.angle)
       // sv.frame = CGRect(x: xPos, y: yPos, width: 1, height: 1)
        sv.frame = CGRect(x: xPos, y: yPos, width: self.width, height: self.height)
        
        if type == "Light Circle"{
            colour = colour.withAlphaComponent(0.2)
        }
        imageView.tintColor = colour
        //imageView.frame = CGRect(x: -self.width/2, y: -self.height/2, width: self.width, height: self.height)
        imageView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        
        if imageView.subviews.count>0 {selectView.removeFromSuperview()}
       
        if self.select == true{
            selectView.frame = CGRect(x: -5, y: -5, width: self.width+10, height: self.height+10)
            selectView.tintColor = UIColor.red
            imageView.addSubview(selectView)
        }
        sv.addSubview(imageView)
    }
    
    func isTapped(tX: Int,tY: Int) -> Bool {
        let tap = CGPoint.init(x: tX , y: tY )
        sv.transform = CGAffineTransform(rotationAngle: self.angle)
        if sv.frame.contains(tap) == true {
            return true
        }
//        if tX>self.x && tX < (self.x+self.width) {
  //          if tY>self.y && tY<(self.y+self.height){
    //           return true
      //       }
       // }
        return false
    }
}