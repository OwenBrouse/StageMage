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
        @IBOutlet weak var colourSelectOne: UISegmentedControl!
        @IBOutlet weak var colourSelectTwo: UISegmentedControl!
        @IBOutlet weak var colourSelectThree: UISegmentedControl!
        @IBOutlet weak var colourSelectFour: UISegmentedControl!
    @IBOutlet var MyView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var rotateGesture = UIRotationGestureRecognizer()
    var lastRotation = CGFloat()
    
        //listsAndOther................................................................................................................listsAndOther
    var items = [Item]()
    var animations = [Animator]()
    var c = [UISegmentedControl]()
    
    //"VoidSetup"////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////"VoidSetup"
    @objc override func viewDidLoad() {
        
        // Define Rotate
        rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateObject(sender:)))
        
        self.scrollView.addGestureRecognizer(rotateGesture)
        
        //TouchScreenGestuirs (Creation/definition)
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(Tap))
        let panGesture = UIPanGestureRecognizer (target: self, action: #selector(Pan))
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(panGesture)
    
        //Scroll View (Creation/definition)
        scrollView.isScrollEnabled = false
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 5
        
        //Animation Force Example
        animations.append(Animator(x: 500, y: 300, time: 3.5, identity: 0,type: false)!)
        animations.append(Animator(x: 700, y: 300, time: 1.5, identity: 1,type: true )!)
        animations.append(Animator(x: 500, y: 400, time: 1.5, identity: 0,type: false)!)
        animations.append(Animator(x: 700, y: 400, time: 1.5, identity: 1,type: false)!)
        animations.append(Animator(x: 500, y: 500, time: 1.5, identity: 0,type: true )!)
        animations.append(Animator(x: 700, y: 500, time: 1.5, identity: 1,type: false)!)
        
        //colours selection menu (Creation/definition)
        c.append(colourSelectOne)
        c.append(colourSelectTwo)
        c.append(colourSelectThree)
        c.append(colourSelectFour)
        for i in 0...c.count-1{c[i].selectedSegmentIndex = -1; c[i].isEnabled = false}
        
        PropertyMenuView.isHidden = true
        
    }
    
    // Rotate Function
    @objc func rotateObject(sender : UIRotationGestureRecognizer) {
        guard sender.view != nil else {return}
        
        if (sender.state == .began || sender.state == .changed) {
            sender.view?.transform = sender.view!.transform.rotated(by: sender.rotation)
            sender.rotation = 0;
        }
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
            for i in stride(from:items.count-1, to: -1, by:-1 ){
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
            for i in stride(from:items.count-1, to: -1, by:-1 ){
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
            for i in stride(from:items.count-1, to: -1, by:-1 ){
                if items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect))) == true{
                    break
                }else if i == 0{
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
                self.PropertyMenuView.isHidden = true
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
            }
        }
    }
        //Colour_Button----------------------------------------------------------------------------------------------------------------Colour_Button
    @IBAction func PropertiesMenu(_ sender: Any) {
        if PropertyMenuView.isHidden == true {
            self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
            PropertyMenuView.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width-self.PropertyMenuView.frame.width
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.PropertyMenuView.frame.origin.x = self.MyView.frame.width
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.PropertyMenuView.isHidden = true
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
                    items[i].height = abs(Int(heightInfoBox.text!) ?? 0)
                }
            }
        }
    }
    @IBAction func widthItem(_ sender: Any) {
        if items.count > 0{
            for i in 0...items.count-1{
                if items[i].select == true{
                    items[i].width = abs(Int(widthInfoBox.text!) ?? 0)
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
    
    @IBAction func Colour1(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(050)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 1{red = CGFloat(100)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 2{red = CGFloat(100)/CGFloat(100); green = CGFloat(049)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 3{red = CGFloat(100)/CGFloat(100); green = CGFloat(099)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectTwo.selectedSegmentIndex = -1
        colourSelectThree.selectedSegmentIndex = -1
        colourSelectFour.selectedSegmentIndex = -1
    }
    @IBAction func Colour2(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(000)/CGFloat(100); green = CGFloat(050)/CGFloat(100); blue = CGFloat(001)/CGFloat(100)}
        if num == 1{red = CGFloat(000)/CGFloat(100); green = CGFloat(100)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 2{red = CGFloat(000)/CGFloat(100); green = CGFloat(100)/CGFloat(100); blue = CGFloat(098)/CGFloat(100)}
        if num == 3{red = CGFloat(020)/CGFloat(100); green = CGFloat(050)/CGFloat(100); blue = CGFloat(099)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectOne.selectedSegmentIndex = -1
        colourSelectThree.selectedSegmentIndex = -1
        colourSelectFour.selectedSegmentIndex = -1
    }
    @IBAction func Colour3(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(000)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(050)/CGFloat(100)}
        if num == 1{red = CGFloat(000)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(100)/CGFloat(100)}
        if num == 2{red = CGFloat(049)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(100)/CGFloat(100)}
        if num == 3{red = CGFloat(099)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(100)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectTwo.selectedSegmentIndex = -1
        colourSelectOne.selectedSegmentIndex = -1
        colourSelectFour.selectedSegmentIndex = -1
    }
    @IBAction func Colour4(_ sender: UISegmentedControl) {
        let num = sender.selectedSegmentIndex
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        if num == 0{red = CGFloat(000)/CGFloat(100); green = CGFloat(000)/CGFloat(100); blue = CGFloat(000)/CGFloat(100)}
        if num == 1{red = CGFloat(060)/CGFloat(100); green = CGFloat(060)/CGFloat(100); blue = CGFloat(060)/CGFloat(100)}
        if num == 2{red = CGFloat(099)/CGFloat(100); green = CGFloat(099)/CGFloat(100); blue = CGFloat(099)/CGFloat(100)}
        if num == 3{red = CGFloat(060)/CGFloat(100); green = CGFloat(040)/CGFloat(100); blue = CGFloat(020)/CGFloat(100)}
        for i in 0...c.count-1{c[i].tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)}
        for i in 0...items.count-1 {
            if items[i].select == true {
                items[i].colour = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
                items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
            }
        }
        colourSelectTwo.selectedSegmentIndex = -1
        colourSelectThree.selectedSegmentIndex = -1
        colourSelectOne.selectedSegmentIndex = -1
    }
    
    //Funtions//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Funtions
        //EmptyPropMenu--------------------------------------------------------------------------------------------------------------EmptyPropMenu
    func EmptyProprties(){
        nameInfoBox.text = nil
        xPosInfoBox.text = nil
        yPosInfoBox.text = nil
        widthInfoBox.text = nil
        heightInfoBox.text = nil
        for i in 0...c.count-1{
            c[i].tintColor = UIColor.init(red:0, green:0, blue:0, alpha:1)
            c[i].selectedSegmentIndex = -1
            c[i].isEnabled = false
        }
    }
        //FillPropMenu----------------------------------------------------------------------------------------------------------------FillPropMenu
    func FillProprties(info: Item){
        nameInfoBox.text = info.name
        xPosInfoBox.text = String(info.x)
        yPosInfoBox.text = String((Int(MyView.frame.height)-info.y)-(info.height+20))
        widthInfoBox.text = String(info.width)
        heightInfoBox.text = String(info.height)
        for i in 0...c.count-1{c[i].tintColor = info.colour; c[i].isEnabled = true}
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        info.colour.getRed(&r, green: &g, blue: &b, alpha: &a)
              if r == 1 || r == 0.5 {
                     if r == 0.50 {c[0].selectedSegmentIndex = 0}
                else if g == 0.00 {c[0].selectedSegmentIndex = 1}
                else if g == 0.49 {c[0].selectedSegmentIndex = 2}
                else              {c[0].selectedSegmentIndex = 3}
        }else if g == 1 || g == 0.5 {
                     if b == 0.01 {c[1].selectedSegmentIndex = 0}
                else if b == 0.00 {c[1].selectedSegmentIndex = 1}
                else if b == 0.98 {c[1].selectedSegmentIndex = 2}
                else              {c[1].selectedSegmentIndex = 3}
        }else if b == 1 || b == 0.5 {
                     if b == 0.50 {c[2].selectedSegmentIndex = 0}
                else if r == 0.00 {c[2].selectedSegmentIndex = 1}
                else if r == 0.49 {c[2].selectedSegmentIndex = 2}
                else              {c[2].selectedSegmentIndex = 3}
        }else                       {
                     if b == 0.00 {c[3].selectedSegmentIndex = 0}
                else if b == 0.60 {c[3].selectedSegmentIndex = 1}
                else if b == 0.99 {c[3].selectedSegmentIndex = 2}
                else              {c[3].selectedSegmentIndex = 3}
        }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
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


