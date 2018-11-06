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
    var bobby = Actor(x: 10,y: 10)
    
    @objc override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(Tele))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(bobby!.display())
    }
    
    
    @IBAction func Tele(_ sender: UITapGestureRecognizer) {
        
        print("YES")
        
    }
    
}
