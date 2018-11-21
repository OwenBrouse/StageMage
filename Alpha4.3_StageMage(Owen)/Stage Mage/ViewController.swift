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
    @IBOutlet weak var PopertyMenuView: UIView!
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
                    items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect)))
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
                    items[i].updateImage(xPos: (items[i].x+(items[i].width/2)    )+Int(Float(translation.x)*Float(1/aspect))  ,
                                          yPos: (items[i].y+(items[i].height/2)-20)+Int(Float(translation.y)*Float(1/aspect))  )
                    if sender.state == .ended {
                        items[i].select = false
                        items[i].x = (items[i].x+(items[i].width/2)    )+Int(Float(translation.x)*Float(1/aspect))
                        items[i].y = (items[i].y+(items[i].height/2)-20)+Int(Float(translation.y)*Float(1/aspect))
                        items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
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
                items[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect)))
                if items[i].select == true{
                    scrollView.isScrollEnabled = false
                    items[i].updateImage(xPos: items[i].x, yPos: items[i].y)
                    break
                }else if i == items.count-1{
                    scrollView.isScrollEnabled = true
                    
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
                    break
                }
            }
        }
    }
    
        //Rotate_Button----------------------------------------------------------------------------------------------------------------Rotate_Button
    @IBAction func rotatePress(_ sender: Any) {//wip
        //mode = "rotate"
        print(BackgroundImage.positionIn(view: MyView).origin.x)
        
    }
    
        //Animate_Button--------------------------------------------------------------------------------------------------------------Animate_Button
    @IBAction func Animate(_ sender: Any) {
        AnimateList(loop:0,end:animations.count)
    }
    
    //Funtions//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Funtions
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


