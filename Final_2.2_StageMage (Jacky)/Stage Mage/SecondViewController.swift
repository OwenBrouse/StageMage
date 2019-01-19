//
//  SecondViewController.swift
//  Stage Mage
//
//  Created by Jacky Liang on 2019-01-06.
//  Copyright © 2019 KingByngInc. All rights reserved.
//

/* https://www.youtube.com/watch?v=7fbTHFH3tl4 -> How to pass data across
 */

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var loadItem = [Any]()
    var loadAnime = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        var Controller = segue.destination as! ViewController
        
        // Pass the selected object to the new view controller.
        Controller.mString = textField.text!
        loadItem = Controller.items
        loadAnime = Controller.animations
        
    }
    
    @IBAction func enter(_ sender: Any?) {
        if textField.text != "" {
            performSegue(withIdentifier: "results", sender: self)
            performSegue(withIdentifier: "results", sender: self)
        }
    }
}
