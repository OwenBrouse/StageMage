//  ViewController.swift
//  Stage Mage
//
//  Created by Jacky Liang and Owen Brouse on 2018-10-30.
//  Copyright © 2018 KingByngInc. All rights reserved.



//SetUp#################################################################################################################################################SetUp
//SetUp#################################################################################################################################################SetUp
//Import------------------------------------------------------------------------------------------------------------------------------------------Import
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    //VariableCreation/definition--------------------------------------------------------------------------------------------VariableCreation/definition
        //StoryBoardObjects........................................................................................................StoryBoardObjects
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var MenuView: UIView!
        @IBOutlet weak var MenuButton: UIButton!
        @IBOutlet weak var SaveButton: UIButton!
        @IBOutlet weak var OpenButton: UIButton!
        @IBOutlet weak var CurserButton: UIButton!
        @IBOutlet weak var RotateButton: UIButton!
        @IBOutlet weak var CameraButton: UIButton!
        @IBOutlet weak var ActorButton: UIButton!
        @IBOutlet weak var SetButton: UIButton!
        @IBOutlet weak var PropButton: UIButton!
        @IBOutlet weak var AnimationButton: UIButton!
        @IBOutlet weak var LightButton: UIButton!
        @IBOutlet weak var CoulorButton: UIButton!
        @IBOutlet weak var TrashButton: UIButton!
    @IBOutlet weak var PropertyMenuView: UIView!
        @IBOutlet weak var nameInfoBox: UITextField!
        @IBOutlet weak var xPosInfoBox: UITextField!
        @IBOutlet weak var yPosInfoBox: UITextField!
        @IBOutlet weak var widthInfoBox: UITextField!
        @IBOutlet weak var heightInfoBox: UITextField!
    
    @IBOutlet var MyView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
        //listsAndOther................................................................................................................listsAndOther
    var items = [Item]()
    var animations = [Animator]()
    
    //"VoidSetup"////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"VoidSetup"
    @objc override func viewDidLoad() {
        
        //TouchScreenGestuirs (Creation/definition)
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(Tap))
        let panGesture = UIPanGestureRecognizer (target: self, action: #selector(Pan))
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(panGesture)
        
        //Scroll View (Creation/definition)
        scrollView.isScrollEnabled = false
        self.scrollView.minimumZoomScale = 0.75
        self.scrollView.maximumZoomScale = 7.5
        
        //Animation Force Example
        animations.append(Animator(x: 500, y: 300, time: 3.5, identity: 0,type: false)!)
        animations.append(Animator(x: 700, y: 300, time: 1.5, identity: 1,type: true)!)
        animations.append(Animator(x: 500, y: 400, time: 1.5, identity: 0,type: false)!)
        animations.append(Animator(x: 700, y: 400, time: 1.5, identity: 1,type: false)!)
        animations.append(Animator(x: 500, y: 500, time: 1.5, identity: 0,type: true)!)
        animations.append(Animator(x: 700, y: 500, time: 1.5, identity: 1,type: false)!)
        
    }
//ReactionFuntion#############################################################################################################################ReactionFuntion
//ReactionFuntion#############################################################################################################################ReactionFuntion
    //TouchDetection//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////TouchDetection
        //DragDetetion------------------------------------------------------------------------------------------------------------------DragDetetion
    @IBAction func Pan(_ sender: UIPanGestureRecognizer) {
        //Pan detection help: https://www.raywenderlich.com/433-uigesturerecognizer-tutorial-getting-started
        let translation = sender.translation(in: self.view)
        let tapX = Float(sender.location(in: MyView).x)-Float(BackgroundImage.positionIn(view: MyView).origin.x)
        let tapY = Float(sender.location(in: MyView).y)-Float(BackgroundImage.positionIn(view: MyView).origin.y)
        let aspect = Float(BackgroundImage.frame.width/MyView.frame.width)
      
        if items.count > 0{
            //DragSelection......................................................................................................DragSelection
            for i in 0...items.count-1{
                if sender.state == .began {
                    if items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect))) == true{items[i].select = true}
                    if items[i].select == true{
                        break
                    }else if i == items.count-1{
                        scrollView.isScrollEnabled = true
                    }
                }
            }
            
            //Draging..................................................................................................................Draging
            for i in 0...items.count-1{
                if items[i].select == true {
                    if sender.state == .changed {
                        FillProprties(info: items[i])
                        let newX = (items[i].x+(items[i].width/2)    )+Int(Float(translation.x)*Float(1/aspect))
                        let newY = (items[i].y+(items[i].height/2)-20)+Int(Float(translation.y)*Float(1/aspect))
                        xPosInfoBox.text = String(newX)
                        yPosInfoBox.text = String(Int(MyView.frame.height)-((newY)+(items[i].height+20)))
                        
                        items[i].updateImage(xPos: newX, yPos: newY)
                    }
                    if sender.state == .ended {
                        items[i].select = false
                        items[i].x = (items[i].x+(items[i].width/2)    )+Int(Float(translation.x)*Float(1/aspect))
                        items[i].y = (items[i].y+(items[i].height/2)-20)+Int(Float(translation.y)*Float(1/aspect))
                        items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
                        EmptyProprties()
                    }
                }
            }
        }else{
            scrollView.isScrollEnabled = true
        }
    }
    
        //TapDetection------------------------------------------------------------------------------------------------------------------TapDetection
    @IBAction func Tap(_ sender: UITapGestureRecognizer) {
        /* Tap detection help: https://stackoverflow.com/questions/45629639/calling-function-when-user-taps-anywhere-on-screen */
        
        //
        let tapX = Float(sender.location(in: MyView).x)-Float(BackgroundImage.positionIn(view: MyView).origin.x)
        let tapY = Float(sender.location(in: MyView).y)-Float(BackgroundImage.positionIn(view: MyView).origin.y)
        let aspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == false{
                    if items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect))) == true{items[i].select = true}
                    if items[i].select == true{
                        scrollView.isScrollEnabled = false
                        items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
                        FillProprties(info: items[i])
                        break
                    }
                }
            }
            for i in 0...items.count-1{
                if items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect))) == true{
                    break
                }else if i == items.count-1{
                    scrollView.isScrollEnabled = true
                    for k in 0...items.count-1{
                        items[k].select = false
                        items[k].updateImage(xPos: items[k].x, yPos: items[k].y)}
                    EmptyProprties()
                }
            }
        }else{
            scrollView.isScrollEnabled = true
        }
    }
    
    //Buttons////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Buttons
        //Actor_Button------------------------------------------------------------------------------------------------------------------Actor_Button
    @IBAction func addActor(_ sender: Any) {
        let screenAspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        let halfScreenWidth = Float(MyView.frame.width)/2;
        let halfScreenHeight = Float(MyView.frame.height)/2;
        
        items.append(Item(x: Int(( halfScreenWidth-Float(BackgroundImage.positionIn(view: MyView).origin.x))*(1/screenAspect)),
                            y: Int((halfScreenHeight-Float(BackgroundImage.positionIn(view: MyView).origin.y))*(1/screenAspect)),
                            width: 30,
                            height: 25,
                            name: "Unnamed Actor",
                            type: "Actor Shape")!)
        BackgroundImage.addSubview(items[items.count-1].imageView)
        items[items.count-1].updateImage(xPos: items[items.count-1].x, yPos: items[items.count-1].y)
    }
    
        //Set_Button----------------------------------------------------------------------------------------------------------------------Set_Button
    @IBAction func AddSet(_ sender: Any) {
        let screenAspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        let halfScreenWidth = Float(MyView.frame.width)/2;
        let halfScreenHeight = Float(MyView.frame.height)/2;
        
        items.append(Item(x: Int(( halfScreenWidth-Float(BackgroundImage.positionIn(view: MyView).origin.x))*(1/screenAspect)),
                          y: Int((halfScreenHeight-Float(BackgroundImage.positionIn(view: MyView).origin.y))*(1/screenAspect)),
                          width: 50,
                          height: 30,
                          name: "Unnamed Set piece",
                          type: "Set Shapes")!)
        BackgroundImage.addSubview(items[items.count-1].imageView)
        items[items.count-1].updateImage(xPos: items[items.count-1].x, yPos: items[items.count-1].y)
    }
    
        //Arrow_Button------------------------------------------------------------------------------------------------------------------Arrow_Button
    @IBAction func MenuShift(_ sender: Any) {//moves menu
        if MenuButton.frame.origin.y <= 20{//if hidden
            UIView.animate(withDuration: 0.5) {
                self.MenuView.frame.origin.y = 20
                self.MenuButton.frame.origin.y = self.MenuView.frame.height+18
                self.MenuButton.transform = CGAffineTransform(rotationAngle:0)
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.MenuView.frame.origin.y = -self.MenuView.frame.height
                self.MenuButton.frame.origin.y = 18
                self.MenuButton.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
            }
        }
    }
        //Colour_Button----------------------------------------------------------------------------------------------------------------Colour_Button
    @IBAction func PropertiesMenu(_ sender: Any) {
        if PropertyMenuView.frame.origin.x >= self.MyView.frame.width{
            UIView.animate(withDuration: 0.5) {
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width-self.PropertyMenuView.frame.width
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
            }
        }
    }
    
        //trash_Button------------------------------------------------------------------------------------------------------------------trash_Button
    @IBAction func deletActor(_ sender: Any) {//self explanitory
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].imageView.removeFromSuperview()
                    items.remove(at: i)
                    EmptyProprties()
                    break
                }
            }
        }
    }
    
        //Rotate_Button----------------------------------------------------------------------------------------------------------------Rotate_Button
    @IBAction func rotatePress(_ sender: Any) {
        
    }
    
        //Animate_Button--------------------------------------------------------------------------------------------------------------Animate_Button
    @IBAction func Animate(_ sender: Any) {
        AnimateList(loop:0,end:animations.count)
    }
    
    @IBAction func heightItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].height = Int(heightInfoBox.text!) ?? 0
                }
            }
        }
    }
    @IBAction func widthItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].width = Int(widthInfoBox.text!) ?? 0
                }
            }
        }
    }
    @IBAction func YposItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].y = Int(MyView.frame.height)-((Int(yPosInfoBox.text!) ?? 0)+(items[i].height+20))
                }
            }
        }
    }
    @IBAction func xPosItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].x = Int(xPosInfoBox.text!) ?? 0
                }
            }
        }
    }
    @IBAction func NameItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].name = nameInfoBox.text!
                }
            }
        }
    }
    //Funtions//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Funtions
        //EmptyPropMenu--------------------------------------------------------------------------------------------------------------EmptyPropMenu
    func EmptyProprties(){
        nameInfoBox.text = nil
        xPosInfoBox.text = nil
        yPosInfoBox.text = nil
        widthInfoBox.text = nil
        heightInfoBox.text = nil
    }
        //FillPropMenu----------------------------------------------------------------------------------------------------------------FillPropMenu
    func FillProprties(info: Item){
        nameInfoBox.text = info.name
        xPosInfoBox.text = String(info.x)
        yPosInfoBox.text = String((Int(MyView.frame.height)-info.y)-(info.height+20))
        widthInfoBox.text = String(info.width)
        heightInfoBox.text = String(info.height)
    }
        //AnimationManeger----------------------------------------------------------------------------------------------------------AnimationManeger
    func AnimateList(loop: Int,end: Int){
        var numTogether = 0
        var time = 0.0
        if loop < end-1{
            for i in loop...animations.count-2{
                if animations[i+1].type == true && i<animations.count-1 {
                    numTogether+=1
                }else{break}
            }
        }
        for j in 0...numTogether{
            
            if animations[loop+j].time > time {
                time = animations[loop+j].time
            }
            
            UIView.animate(withDuration: animations[loop+j].time) {
                self.items[self.animations[loop+j].identity].x = self.animations[loop+j].x
                self.items[self.animations[loop+j].identity].y = self.animations[loop+j].y
                self.items[self.animations[loop+j].identity].updateImage(xPos: self.items[self.animations[loop+j].identity].x,
                                                                         yPos: self.items[self.animations[loop+j].identity].y)
            }
        }
        numTogether+=1
        if loop+numTogether<end{
            DispatchQueue.main.asyncAfter(deadline: .now() + time) { // change 2 to desired number of seconds
                self.AnimateList(loop: loop+numTogether, end: end)
            }
        }
    }
        //ZoomingManeger--------------------------------------------------------------------------------------------------------------ZoomingManeger
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        // Zooming tutorial: https://www.youtube.com/watch?v=TEBDwYkYx00
        return self.BackgroundImage
    }
}

//Extentions+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Extentions
    //ScrollViewImagePosition----------------------------------------------------------------------------------------------------ScrollViewImagePosition
extension UIView {
    //taken from: https://medium.com/@joesusnick/a-uiview-extension-that-will-teach-you-an-important-lesson-about-frames-cefe1e4beb0b
    func positionIn(view: UIView) -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: view)
        }
        return frame
    }
}
    //TouchScreenDelegation--------------------------------------------------------------------------------------------------------TouchScreenDelegation
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


