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
    override func viewDidLoad() {
        var bobby = Actor(x: 10,y: 10)
        view.addSubview(bobby!.display())
    }
    
   
}
