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
    var mode = "select"
    
    @objc override func viewDidLoad() {
        
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(Tele))
        view.addGestureRecognizer(tapGesture)
        
        self.scrollView.minimumZoomScale = 0.75
        self.scrollView.maximumZoomScale = 7.5
    }
    
    /* Tap detection help: https://stackoverflow.com/questions/45629639/calling-function-when-user-taps-anywhere-on-screen */
    
    @IBAction func addActor(_ sender: Any) {
        actors.append(Actor(x: Int(MyView.frame.width)/2,
                            y: Int(MyView.frame.height)/2,
                            width: 60,
                            height: 50)!)
        //BackgroundImage.addSubview(actors[actors.count-1].imageView)
        MyView.addSubview(actors[actors.count-1].imageView)
    }
    
    @IBAction func Tele(_ sender: UITapGestureRecognizer) {//TAP DETECTION//
        let tapX = Int(sender.location(in: MyView).x)
        let tapY = Int(sender.location(in: MyView).y)
        //print(BackgroundImage.image.)
        var find = true
        if actors.count > 0{//if their are actors
            for i in 0...actors.count-1{
                if actors[i].select == true {//do action to selected actor
                    if mode == "select"{
                        actors[i].x = tapX-(actors[i].width/2)
                        actors[i].y = tapY-(actors[i].height/2)
                        actors[i].select = false
                    }//else if mode == "rotate"{
                     //   let angle: CGFloat = CGFloat(tan(Double((actors[i].y-tapY)/(actors[i].x-tapX))))
                     //   actors[i].imageView.transform = CGAffineTransform(rotationAngle: (angle * .pi) / angle)
                     //   actors[i].select = false
                     //   mode = "select"
                    //}
                    find = false
                }
            }
            if find == true{//else select an actor
                for i in 0...actors.count-1{
                    actors[i].isTapped(tX: tapX, tY: tapY)
                    if actors[i].select == true{
                        break
                    }
                }
            }
            for i in 0...actors.count-1{//redraw actors
                actors[i].imageView.removeFromSuperview()
                actors[i].updateImage()
                //BackgroundImage.addSubview(actors[i].imageView)
                MyView.addSubview(actors[i].imageView)
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
        for i in 0...actors.count-1{
            if actors[i].select == true{
                actors[i].imageView.removeFromSuperview()
                actors.remove(at: i)
                break
            }
        }
    }
    
    @IBAction func rotatePress(_ sender: Any) {//wip
        //mode = "rotate"
    }
    // Zooming tutorial: https://www.youtube.com/watch?v=TEBDwYkYx00
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.BackgroundImage
    }
}


