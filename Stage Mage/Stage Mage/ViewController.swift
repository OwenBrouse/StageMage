//
//  ViewController.swift
//  Stage Mage
//
//  Created by Jacky Liang on 2018-10-30.
//  Copyright © 2018 KingByngInc. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet var MyView: UIView!
    var actors = [Actor]()
    //actors.append(Actor(x: 10,y: 10,width: 100,height: 100)!)
    
    @objc override func viewDidLoad() {
        actors.append(Actor(x: 10,y: 10,width: 100,height: 100)!)
        actors.append(Actor(x: 10,y: 10,width: 200,height: 200)!)
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(Tele))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(actors[1].imageView)
    }
    
    /* Tap detection help: https://stackoverflow.com/questions/45629639/calling-function-when-user-taps-anywhere-on-screen */
    
    @IBAction func Tele(_ sender: UITapGestureRecognizer) {
        for i in 0...actors.count-1{
            actors[i].isTapped(tX: Int(sender.location(in: MyView).x),
                                       tY: Int(sender.location(in: MyView).y))
            if actors[i].select == true {
                actors[i].imageView.removeFromSuperview()
                actors[i].x = Int(sender.location(in: MyView).x)-(actors[0].width/2)
                actors[i].y = Int(sender.location(in: MyView).y)-(actors[0].height/2)
                actors[i].updateImage()
                view.addSubview(actors[0].imageView)
                
            }
            actors[i].select = false
        }
        
    }
    
}
