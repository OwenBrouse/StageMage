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
    var view: UIView
    
    init?(x: Int, y: Int, time: Double, identity: Int, type: Bool){
        self.x = x
        self.y = y
        self.time = time
        self.identity = identity
        self.type = type
        self.view = UIView()
    }
    
    func drawClose(list1: [Item], num: Int) -> Int{
        let height = 90
        let width = 321
        var space = 0;if self.type == true {space = 0}else{space = 10}
        space+=num
        
        let box        = UIView.init(     frame: CGRect.init(x: 8,              y: space,         width: width,         height:  height))
        let name       = UILabel.init(    frame: CGRect.init(x: 4,              y: 4,             width: (2*width/3)-6, height: (height/2)-6))
        let activation = UILabel.init(    frame: CGRect.init(x: (2*width/3)+2,  y: 4,             width: (width/3)-6,   height: (height/2)-8))
        
        let xPos       = UILabel.init(    frame: CGRect.init(x: 4,              y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let yPos       = UILabel.init(    frame: CGRect.init(x: (width/3)+2,    y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let duration   = UILabel.init(    frame: CGRect.init(x: (2*width/3)+2,  y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        
        let dBox       = UITextField.init(frame: CGRect.init(x: (10*width/12)+2,y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let xBox       = UITextField.init(frame: CGRect.init(x: (width/12)+2,   y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let yBox       = UITextField.init(frame: CGRect.init(x: (5*width/12)+2, y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        
        name.font = name.font.withSize(24)
        name.text = list1[self.identity].name
        name.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        name.textColor = UIColor.black
        box.addSubview(name)
        
        activation.font = name.font.withSize(18)
        if self.type == true {activation.text = "With Prev"}else{activation.text = "After Prev"}
        activation.backgroundColor = UIColor.white
        activation.textColor = UIColor.black
        box.addSubview(activation)
        
        xPos.font = name.font.withSize(23)
        xPos.text = "X:"
        xPos.backgroundColor = UIColor.white
        xPos.textColor = UIColor.black
        box.addSubview(xPos)
        
        xBox.text = String(self.x)
        xBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(xBox)
        
        yPos.font = name.font.withSize(23)
        yPos.text = "Y:"
        yPos.backgroundColor = UIColor.white
        yPos.textColor = UIColor.black
        box.addSubview(yPos)
        
        yBox.text = String(self.y)
        yBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(yBox)
        
        duration.font = name.font.withSize(23)
        duration.text = "Dur:"
        duration.backgroundColor = UIColor.white
        duration.textColor = UIColor.black
        box.addSubview(duration)
        
        dBox.text = String(self.time)
        dBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(dBox)
        
        box.backgroundColor = UIColor.white
        self.view = box
        return height+space
    }
}
