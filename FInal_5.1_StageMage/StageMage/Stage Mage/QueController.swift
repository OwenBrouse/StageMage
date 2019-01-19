//
//  QueController.swift
//  Stage Mage
//
//  Created by Jacky Liang on 2019-01-18.
//  Copyright © 2019 KingByngInc. All rights reserved.
//
/* This class is used for the que screen. It can add, display and delete the ques. The ques also save after app terminatio
 */

import UIKit
import CoreData

class QueController: UIViewController {

    // How to save baisc data to core data: https://www.youtube.com/watch?v=tP4OGvIRUC4&t=199s
    
    @IBOutlet weak var tableView: UITableView!
    
    var ques = [Ques]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call for a fetch request from core data
        let fetchQues: NSFetchRequest<Ques> = Ques.fetchRequest()
        do {
            
            let loadQues = try PersistenceService.context.fetch(fetchQues)
            
            self.ques = loadQues
            self.tableView.reloadData()
            
        } catch {}
        
    }
    
    @IBAction func addTap() {
        
        // Create a alert to write que info
        let alert = UIAlertController(title: "Add Que", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Que"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Details"
        }
        
        // the post que part of the alert
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let que = alert.textFields!.first!.text!
            let details = alert.textFields!.last!.text!
            
            // creates container to save to core data
            let queData = Ques(context: PersistenceService.context)
            queData.name = que
            queData.details = details
            PersistenceService.saveContext()
            
            // add object to the array and refresh screen
            self.ques.append(queData)
            self.tableView.reloadData()
            
            
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func delTap() {
    
        // : how to delete objects in core data: https://www.youtube.com/watch?v=XH-osAmaU5E
        
        if ques.count > 0 {
             let firstQue = ques.first!
            PersistenceService.context.delete(firstQue)
            self.ques.remove(at: 0)
            PersistenceService.saveContext()
            self.tableView.reloadData()
        }
    }
}

extension QueController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ques.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = ques[indexPath.row].name
        cell.detailTextLabel?.text = ques[indexPath.row].details
        
        return cell
    }
}
