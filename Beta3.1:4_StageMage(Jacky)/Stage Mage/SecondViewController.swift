//
//  SecondViewController.swift
//  Stage Mage
//
//  Created by Jacky Liang on 2019-01-06.
//  Copyright © 2019 KingByngInc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var Controller = segue.destination as! ViewController
        Controller.mString = textField.text!
    }
    
    @IBAction func enter(_ sender: Any?) {
        if textField.text != "" {
            performSegue(withIdentifier: "results", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
