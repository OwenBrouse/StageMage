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
    var rotateView = UIView()
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
        self.rotateView.frame = CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
        self.rotateView.addSubview(self.imageView)
    }
    
    func updateImage(xPos: Int,yPos: Int) {
        // remove old view
        imageView.removeFromSuperview()
        
        //set up rotate view
        rotateView.transform = CGAffineTransform(rotationAngle: self.angle)
        rotateView.frame = CGRect(x: xPos, y: yPos, width: self.width, height: self.height)
        
        //add transpaerency?
        if type == "Light Circle"{colour = colour.withAlphaComponent(0.2)}
        
        //Create and Colour
        imageView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        imageView.tintColor = colour
        
        //remove selectView?
        if imageView.subviews.count>0 {selectView.removeFromSuperview()}
        
        //add selectView?
        if self.select == true{
            selectView.frame = CGRect(x: -5, y: -5, width: self.width+10, height: self.height+10)
            selectView.tintColor = UIColor.red
            imageView.addSubview(selectView)
        }
        
        //rotate
        rotateView.addSubview(imageView)
    }
    
    func isTapped(tX: Int,tY: Int) -> Bool {
        let tap = CGPoint.init(x: tX , y: tY )
        
        if rotateView.frame.contains(tap) == true {
            return true
        }
        return false
    }
}
