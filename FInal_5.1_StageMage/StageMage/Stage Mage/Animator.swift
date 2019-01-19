//
//  Actor.swift
//  Stage Mage
//
//  Created by Jacky Liang and Owen Brouse on 2018-11-05.
//  Copyright © 2018 KingByngInc. All rights reserved.
//
import UIKit

class Animator: NSObject {
    //normal variables
    var x: Int //X position
    var y: Int //Y Position
    var time: Double //Time duration of an animation
    var identity: Item //The Item being animated
    var percent: Double //the % of distance the curtain will go to
    var screen: UIView //the size and information of the device being used
    
    //saved objects for multi tap reconizion
    var view: UIView //the view the viewController will take
    var box: UIView //the view that collects the objects
    var name: UIButton // the
    var activation: UILabel
    var upButt: UILabel
    var downButt: UILabel
    var delete: UILabel
    
    //boolean stament aboot the animation
    var open: Bool //is this anmiation selected
    var tapPos: Bool //is this animation receving new coordinats
    var newItem: Bool //is this animation changeing Items to animate
    var type: Bool //If the animation happens after or with the one befor it
    var simple: Bool //If this is a curtain animation
    
    init?(x: Int, y: Int, time: Double, identity: Item, type: Bool, screen: UIView, simple: Bool){
        self.simple = simple
        self.percent = 100.0
        self.x = x
        self.y = y
        self.time = time
        self.identity = identity
        self.type = type
        self.view = UIView()
        self.screen = screen
        self.box = UIView()
        self.name = UIButton()
        self.activation = UILabel()
        self.upButt = UILabel()
        self.downButt = UILabel()
        self.delete = UILabel()
        self.open = false
        self.tapPos = false
        self.newItem = false
    }
    
    func drawClose(num: Int) -> Int{
        // create General information and formating
        let height = 90
        let width = (Int(screen.frame.width)/3)-10
        var space = 0;if self.type == true {space = 0}else{space = 10}
        space+=num
        
        //define all objects in the animation
        box            = UIView.init(     frame: CGRect.init(x: 8,              y: space,         width: width,         height:  height))
        name           = UIButton.init(   frame: CGRect.init(x: 4,              y: 4,             width: (2*width/3)-6, height: (height/2)-6))
        activation     = UILabel.init(    frame: CGRect.init(x: (2*width/3)+2,  y: 4,             width: (width/3)-6,   height: (height/2)-8))
        let xPos       = UILabel.init(    frame: CGRect.init(x: 4,              y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let yPos       = UILabel.init(    frame: CGRect.init(x: (width/3)+2,    y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let duration   = UILabel.init(    frame: CGRect.init(x: (2*width/3)+2,  y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let dBox       = UITextField.init(frame: CGRect.init(x: (10*width/12)+2,y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let xBox       = UITextField.init(frame: CGRect.init(x: (width/12)+2,   y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        let yBox       = UITextField.init(frame: CGRect.init(x: (5*width/12)+2, y: (height/2)+2,  width: (width/6)-6,   height: (height/2)-6))
        
        //creat assinge funtions to a button press
        yBox.addTarget(self, action: #selector(editY), for: .editingChanged)
        name.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        xBox.addTarget(self, action: #selector(editX), for: .editingChanged)
        dBox.addTarget(self, action: #selector(editDuration), for: .editingChanged)
        
        //Colour and add to animation
        name.setTitle(self.identity.name, for: .normal)
        name.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        name.tintColor = UIColor.black
        box.addSubview(name)
        
        activation.font = activation.font.withSize(18)
        if self.type == true {activation.text = "With Prev"}else{activation.text = "After Prev"}
        activation.backgroundColor = UIColor.white
        activation.textColor = UIColor.black
        box.addSubview(activation)
        
        xPos.font = xPos.font.withSize(23)
        xPos.text = "X:"
        xPos.backgroundColor = UIColor.white
        xPos.textColor = UIColor.black
        box.addSubview(xPos)
        
        xBox.text = String(self.x)
        xBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(xBox)
        
        yPos.font = yPos.font.withSize(23)
        yPos.text = "Y:"
        yPos.backgroundColor = UIColor.white
        yPos.textColor = UIColor.black
        box.addSubview(yPos)
        
        
        yBox.text = String(Int(Int(screen.frame.height)-self.y)-(self.identity.height+20))
        yBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(yBox)
        
        duration.font = duration.font.withSize(23)
        duration.text = "Dur:"
        duration.backgroundColor = UIColor.white
        duration.textColor = UIColor.black
        box.addSubview(duration)
        
        dBox.text = String(self.time)
        dBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(dBox)
        
        //submit to view controller
        box.backgroundColor = UIColor.white
        self.view = box
        return height+space
    }
    
    func drawOpen(num: Int) -> Int{ //draw a large animation box with all of information and features
        //define general formation
        let height = 225
        let width = (Int(screen.frame.width)/3)-16
        var space = 0;if self.type == true {space = 0}else{space = 10}
        space+=num
        
        //define objects
        box            = UIView.init(     frame: CGRect.init(x: 8,           y: space,        width: width,         height:  height))
        name           = UIButton.init(   frame: CGRect.init(x: 4,           y: 4,            width: (width)-8,     height: (height/5)-8))
        activation     = UILabel.init(    frame: CGRect.init(x: (3*width/5), y: (height/5),   width: (2*width/5)-4, height: (height/5)-4))
        let xPos       = UILabel.init(    frame: CGRect.init(x: 4,           y: (2*height/5), width: (width/5),     height: (height/5)-4))
        let yPos       = UILabel.init(    frame: CGRect.init(x: 4,           y: (3*height/5), width: (width/5),     height: (height/5)-4))
        let duration   = UILabel.init(    frame: CGRect.init(x: 4,           y: (1*height/5), width: (width/5),     height: (height/5)-4))
        let dBox       = UITextField.init(frame: CGRect.init(x: (width/5),   y: (1*height/5), width: (2*width/5)-4, height: (height/5)-4))
        let xBox       = UITextField.init(frame: CGRect.init(x: (width/5),   y: (2*height/5), width: (2*width/5)-4, height: (height/5)-4))
        let yBox       = UITextField.init(frame: CGRect.init(x: (width/5),   y: (3*height/5), width: (2*width/5)-4, height: (height/5)-4))
        let rePos      = UIButton.init(   frame: CGRect.init(x: (3*width/5), y: (2*height/5), width: (2*width/5)-4, height: (2*height/5)-4))
        upButt         = UILabel.init(    frame: CGRect.init(x: 4,           y: (4*height/5), width: (width/3)-8,   height: (height/5)-4))
        downButt       = UILabel.init(    frame: CGRect.init(x: (width/3),   y: (4*height/5), width: (width/3)-4,   height: (height/5)-4))
        delete         = UILabel.init(    frame: CGRect.init(x: (2*width/3), y: (4*height/5), width: (width/3)-4,   height: (height/5)-4))
        
        //Link buttons to funtions
        name.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        dBox.addTarget(self, action: #selector(editDuration), for: .editingChanged)
        xBox.addTarget(self, action: #selector(editX), for: .editingChanged)
        yBox.addTarget(self, action: #selector(editY), for: .editingChanged)
        rePos.addTarget(self, action: #selector(changePosition), for: .touchUpInside)
        
        //Colour and add to animation
        name.setTitle(self.identity.name, for: .normal)
        name.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        name.tintColor = UIColor.black
        box.addSubview(name)
        
        activation.font = activation.font.withSize(18)
        if self.type == true {activation.text = "With Prev"}else{activation.text = "After Prev"}
        activation.backgroundColor = UIColor.init(white: CGFloat(0.92), alpha: CGFloat(1))
        activation.textColor = UIColor.black
        box.addSubview(activation)
        
        xPos.font = xPos.font.withSize(23)
        xPos.text = "X:"
        xPos.backgroundColor = UIColor.white
        xPos.textColor = UIColor.black
        box.addSubview(xPos)
        
        xBox.text = String(self.x)
        xBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(xBox)
        
        yPos.font = yPos.font.withSize(23)
        yPos.text = "Y:"
        yPos.backgroundColor = UIColor.white
        yPos.textColor = UIColor.black
        box.addSubview(yPos)
        
        
        yBox.text = String(Int(Int(screen.frame.height)-self.y)-(self.identity.height+20))
        yBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(yBox)
        
        duration.font = duration.font.withSize(23)
        duration.text = "Dur:"
        duration.backgroundColor = UIColor.white
        duration.textColor = UIColor.black
        box.addSubview(duration)
        
        dBox.text = String(self.time)
        dBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(dBox)
        
        rePos.setTitle("Set Destination", for: .normal)
        rePos.backgroundColor = UIColor.init(white: CGFloat(0.92), alpha: CGFloat(1))
        rePos.setTitleColor(UIColor.black, for: .normal)
        box.addSubview(rePos)
        
        upButt.text = "Befor"
        upButt.textAlignment = .center
        upButt.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        box.addSubview(upButt)
        
        downButt.text = "After"
        downButt.textAlignment = .center
        downButt.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        box.addSubview(downButt)
        
        delete.text = "Delete"
        delete.textAlignment = .center
        delete.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        box.addSubview(delete)
        
        //submit to view controller
        box.backgroundColor = UIColor.white
        self.view = box
        return height+space
    }
    
    func drawSimple(num: Int) -> Int{ // draw an animation box for a curtain animation
        //define general formation
        let height = 135
        let width = (Int(screen.frame.width)/3)-16
        var space = 0;if self.type == true {space = 0}else{space = 10}
        space+=num
        
        //creats objects
        box          = UIView.init(     frame: CGRect.init(x: 8,           y: space,        width: width,         height:  height))
        name         = UIButton.init(   frame: CGRect.init(x: 4,           y: 4,            width: (3*width/5)-8, height: (height/3)-8))
        activation   = UILabel.init(    frame: CGRect.init(x: (3*width/5), y: 4,            width: (2*width/5)-4, height: (height/3)-4))
        let duration = UILabel.init(    frame: CGRect.init(x: 4,           y: (1*height/3), width: (width/5),     height: (height/3)-4))
        let pBox     = UITextField.init(frame: CGRect.init(x: (3*width/5), y: (1*height/3), width: (2*width/5)-4, height: (height/3)-4))
        let dBox     = UITextField.init(frame: CGRect.init(x: (width/5),   y: (1*height/3), width: (2*width/5)-4, height: (height/3)-4))
        upButt       = UILabel.init(    frame: CGRect.init(x: 4,           y: (2*height/3), width: (width/3)-8,   height: (height/3)-4))
        downButt     = UILabel.init(    frame: CGRect.init(x: (width/3),   y: (2*height/3), width: (width/3)-4,   height: (height/3)-4))
        delete       = UILabel.init(    frame: CGRect.init(x: (2*width/3), y: (2*height/3), width: (width/3)-4,   height: (height/3)-4))
        
        //links buttons to funtions
        dBox.addTarget(self, action: #selector(editDuration), for: .editingChanged)
        pBox.addTarget(self, action: #selector(editPercent), for: .editingChanged)
        
        //Colour and add to animations
        name.setTitle("Curtains", for: .normal)
        name.backgroundColor = UIColor.init(red: CGFloat(1), green: CGFloat(0.7), blue: CGFloat(0.4), alpha: CGFloat(0.8))
        name.tintColor = UIColor.black
        box.addSubview(name)
        
        activation.font = activation.font.withSize(18)
        if self.type == true {activation.text = "With Prev"}else{activation.text = "After Prev"}
        activation.backgroundColor = UIColor.init(white: CGFloat(1), alpha: CGFloat(1))
        activation.textColor = UIColor.black
        box.addSubview(activation)
        
        duration.font = duration.font.withSize(23)
        duration.text = "Dur:"
        duration.backgroundColor = UIColor.white
        duration.textColor = UIColor.black
        box.addSubview(duration)
        
        dBox.text = String(self.time)
        dBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(dBox)
        
        pBox.text = String(self.percent)+"%"
        pBox.backgroundColor = UIColor.init(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        box.addSubview(pBox)
        
        upButt.text = "Befor"
        upButt.textAlignment = .center
        upButt.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        box.addSubview(upButt)
        
        downButt.text = "After"
        downButt.textAlignment = .center
        downButt.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        box.addSubview(downButt)
        
        delete.text = "Delete"
        delete.textAlignment = .center
        delete.backgroundColor = UIColor.init(red: CGFloat(0.7), green: CGFloat(0.7), blue: CGFloat(1), alpha: CGFloat(0.8))
        box.addSubview(delete)
        
        //Submit to ViewController
        box.backgroundColor = UIColor.white
        self.view = box
        return height+space
    }
    
    
    func tapped(x: Int, y: Int) -> Bool{//when tapped inside animation box
        if x>Int(box.frame.origin.x) && x<Int(box.frame.origin.x + box.frame.width){
            if y>Int(box.frame.origin.y) && y<Int(box.frame.origin.y + box.frame.height){
                return true
            }
        }
        return false
    }
    func tappedActivation(x: Int, y: Int) -> Bool{//when tapped inside "with pre"/"after pre"
        if x>Int(activation.frame.origin.x) && x<Int(activation.frame.origin.x + activation.frame.width){
            if y>Int(activation.frame.origin.y) && y<Int(activation.frame.origin.y + activation.frame.height){
                return true
            }
        }
        return false
    }
    
    func TapUp(x: Int, y: Int) -> Bool{//when tapped inside "before"
        if x>Int(upButt.frame.origin.x) && x<Int(upButt.frame.origin.x + upButt.frame.width){
            if y>Int(upButt.frame.origin.y) && y<Int(upButt.frame.origin.y + upButt.frame.height){
                return true
            }
        }
        return false
    }
    
    
    func TapDown(x: Int, y: Int) -> Bool{//when tapped inside "after"
        if x>Int(downButt.frame.origin.x) && x<Int(downButt.frame.origin.x + downButt.frame.width){
            if y>Int(downButt.frame.origin.y) && y<Int(downButt.frame.origin.y + downButt.frame.height){
                return true
            }
        }
        return false
    }
    
    func TapOut(x: Int, y: Int) -> Bool{//when tapped inside "delete"
        if x>Int(delete.frame.origin.x) && x<Int(delete.frame.origin.x + delete.frame.width){
            if y>Int(delete.frame.origin.y) && y<Int(delete.frame.origin.y + delete.frame.height){
                return true
            }
        }
        return false
    }
    
    func switchType() {//change from "with pre" to "after pre" and vise versa
        if self.type == true{
            self.type = false
        }else{
            self.type = true
        }
    }
    
    @IBAction func changeName(_ sender: UITextField) {//the name button has been pressed
        if self.open == true{
            sender.backgroundColor = UIColor.red
            name.setTitle("", for: .normal)
            self.newItem = true
        } else{
            self.open = true
        }
    }
    
    @IBAction func editDuration(_ sender: UITextField) {// the duration button has been pressed
        self.time = Double(sender.text!) ?? 0
    }
    @IBAction func editPercent(_ sender: UITextField) {// the percentage button has been pressed (curtains)
        var text = sender.text!
        if text.last == "%" {//ignore a % sign
            text = String(text.dropLast())
        }
        self.percent = Double(text) ?? 0
        if self.percent > 100 {self.percent = 100}
        if self.percent < 0   {self.percent = 0}
    }
    @IBAction func editX(_ sender: UITextField) {//the x textfeild has been pressed
        self.x = Int(sender.text!) ?? 0
    }
    @IBAction func editY(_ sender: UITextField) {//the y textfeild has been pressed
        self.y = Int(screen.frame.height)-((Int(sender.text!) ?? 0)+(self.identity.height+20))
    }
    @IBAction func changePosition(_ sender: UIButton){//the "set destination" button has been pressed
        self.tapPos = true
        sender.backgroundColor = UIColor.red
    }
}
