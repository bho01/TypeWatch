//
//  SettingsTableViewController.swift
//  
//
//  Created by Brendon Ho on 12/9/17.
//

import UIKit

class SettingsTableViewController: UITableViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
