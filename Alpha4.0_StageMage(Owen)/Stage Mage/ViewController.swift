//
//  ViewController.swift
//  Stage Mage
//
//  Created by Jacky Liang and Owen Brouse on 2018-10-30.
//  Copyright © 2018 KingByngInc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    
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
    @IBOutlet var MyView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var actors = [Actor]()
    var animations = [Animator]()
    
    @objc override func viewDidLoad() {
        
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(Tap))
        let panGesture = UIPanGestureRecognizer (target: self, action: #selector(Pan))
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(panGesture)
        animations.append(Animator(x: 500, y: 300, time: 3.5, identity: 0,type: false)!)
        animations.append(Animator(x: 700, y: 300, time: 1.5, identity: 1,type: true)!)
        animations.append(Animator(x: 500, y: 400, time: 1.5, identity: 0,type: false)!)
        animations.append(Animator(x: 700, y: 400, time: 1.5, identity: 1,type: false)!)
        animations.append(Animator(x: 500, y: 500, time: 1.5, identity: 0,type: true)!)
        animations.append(Animator(x: 700, y: 500, time: 1.5, identity: 1,type: false)!)
        
        
        scrollView.isScrollEnabled = false
        self.scrollView.minimumZoomScale = 0.75
        self.scrollView.maximumZoomScale = 7.5
    }
    
    /* Tap detection help: https://stackoverflow.com/questions/45629639/calling-function-when-user-taps-anywhere-on-screen */
    
    @IBAction func addActor(_ sender: Any) {
        let screenAspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        let halfScreenWidth = Float(MyView.frame.width)/2;
        let halfScreenHeight = Float(MyView.frame.height)/2;
        
        actors.append(Actor(x: Int(( halfScreenWidth-Float(BackgroundImage.positionIn(view: MyView).origin.x))*(1/screenAspect)),
                            y: Int((halfScreenHeight-Float(BackgroundImage.positionIn(view: MyView).origin.y))*(1/screenAspect)),
                            width: 30,
                            height: 25)!)
        BackgroundImage.addSubview(actors[actors.count-1].imageView)
    }
    @IBAction func Pan(_ sender: UIPanGestureRecognizer) {
        //https://www.raywenderlich.com/433-uigesturerecognizer-tutorial-getting-started
        let translation = sender.translation(in: self.view)
        let tapX = Float(sender.location(in: MyView).x)-Float(BackgroundImage.positionIn(view: MyView).origin.x)
        let tapY = Float(sender.location(in: MyView).y)-Float(BackgroundImage.positionIn(view: MyView).origin.y)
        let aspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        
        if actors.count > 0{
            for i in 0...actors.count-1{
                if sender.state == .began {
                    actors[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect)))
                    if actors[i].select == true{
                        break
                    }else if i == actors.count-1{
                        scrollView.isScrollEnabled = true
                    }
                }
            }
            
            for i in 0...actors.count-1{
                if actors[i].select == true {
                    actors[i].updateImage(xPos: (actors[i].x+(actors[i].width/2)    )+Int(Float(translation.x)*Float(1/aspect))  ,
                                          yPos: (actors[i].y+(actors[i].height/2)-20)+Int(Float(translation.y)*Float(1/aspect))  )
                    if sender.state == .ended {
                        actors[i].select = false
                        actors[i].x = (actors[i].x+(actors[i].width/2)    )+Int(Float(translation.x)*Float(1/aspect))
                        actors[i].y = (actors[i].y+(actors[i].height/2)-20)+Int(Float(translation.y)*Float(1/aspect))
                        actors[i].updateImage(xPos: actors[i].x, yPos: actors[i].y)
                    }
                }
            }
            
        }
    }
    
    @IBAction func Tap(_ sender: UITapGestureRecognizer) {//TAP DETECTION//
        let tapX = Float(sender.location(in: MyView).x)-Float(BackgroundImage.positionIn(view: MyView).origin.x)
        let tapY = Float(sender.location(in: MyView).y)-Float(BackgroundImage.positionIn(view: MyView).origin.y)
        let aspect = Float(BackgroundImage.frame.width/MyView.frame.width)
        
        if actors.count > 0{
            for i in 0...actors.count-1{
                actors[i].isTapped(tX: Int(tapX*(1/aspect)), tY: Int(tapY*(1/aspect)))
                if actors[i].select == true{
                    scrollView.isScrollEnabled = false
                    actors[i].updateImage(xPos: actors[i].x, yPos: actors[i].y)
                    break
                }else if i == actors.count-1{
                    scrollView.isScrollEnabled = true
                    
                }
            }
        }
    }
    
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
    
    @IBAction func deletActor(_ sender: Any) {//self explanitory
        if actors.count > 0{
            for i in 0...actors.count-1{
                if actors[i].select == true{
                    actors[i].imageView.removeFromSuperview()
                    actors.remove(at: i)
                    break
                }
            }
        }
    }
    
    @IBAction func rotatePress(_ sender: Any) {//wip
        //mode = "rotate"
        print(BackgroundImage.positionIn(view: MyView).origin.x)
        
    }
    // Zooming tutorial: https://www.youtube.com/watch?v=TEBDwYkYx00
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.BackgroundImage
    }
    func test(loop: Int,end: Int){
        var temp = 0
        var time = 0.0
        if loop < end-1{
            for i in loop...animations.count-2{
                if animations[i+1].type == true && i<animations.count-1 {
                    temp+=1
                }else{break}
            }
        }
        for j in 0...temp{
            
            if animations[loop+j].time > time {
                time = animations[loop+j].time
            }
            
            UIView.animate(withDuration: animations[loop+j].time) {
                self.actors[self.animations[loop+j].identity].x = self.animations[loop+j].x
                self.actors[self.animations[loop+j].identity].y = self.animations[loop+j].y
                self.actors[self.animations[loop+j].identity].updateImage(xPos: self.actors[self.animations[loop+j].identity].x, yPos: self.actors[self.animations[loop+j].identity].y)
            }
        }
        temp+=1
        if loop+temp<end{
            DispatchQueue.main.asyncAfter(deadline: .now() + time) { // change 2 to desired number of seconds
                self.test(loop: loop+temp, end: end)
            }
        }
    }
    @IBAction func Animate(_ sender: Any) {
        test(loop:0,end:animations.count)
    }
}
//taken from: https://medium.com/@joesusnick/a-uiview-extension-that-will-teach-you-an-important-lesson-about-frames-cefe1e4beb0b
extension UIView {
    func positionIn(view: UIView) -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: view)
        }
        return frame
    }
}
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


