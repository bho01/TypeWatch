//
//  ViewController.swift
//  TypeWatch
//
//  Created by Brendon Ho on 12/8/17.
//  Copyright © 2017 Mengo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Floaty

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //The outlet vairables from the ViewController
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var avgWpm: UILabel!
    @IBOutlet weak var bestWPM: UILabel!
    @IBOutlet weak var gamesWon: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var fullName: UILabel!
    
    //The username from the LoginViewController
    var usrname:String = ""
    var arrOfRecent = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Handle all the FAB icons and actions
        let floaty = Floaty()
        /*
        floaty.addItem("Global Statistics", icon: UIImage(named: "ic_language")!, handler: { item in
            
            floaty.close()
        })
         */
        floaty.addItem("Settings", icon: UIImage(named: "ic_settings")!, handler: { item in
            self.performSegue(withIdentifier: "MoveToSettings", sender: nil)
            floaty.close()
        })
        self.view.addSubview(floaty)
        
        //The URL
        let url = URL(string: "http://data.typeracer.com/users?id=tr:\(usrname)")
        
        //Use AlamoFire and JSON to grab the JSON from the link
        Alamofire.request(url!).responseJSON{(responseData) -> Void in
            
            //Get the JSON values
            let swiftyJsonVar = JSON(responseData.result.value!)
            
            //All the JSON Stuffs
            let firstNameJSON = swiftyJsonVar["name"];
            let lastNameJSON = swiftyJsonVar["lastName"];
            let countryJSON = swiftyJsonVar["country"];
            let avgWpmJSON = swiftyJsonVar["tstats"]["recentAvgWpm"]
            let bestWPMJSON = swiftyJsonVar["tstats"]["bestGameWpm"]
            let gamesWonJSON = swiftyJsonVar["tstats"]["gamesWon"]
            let levelJSON = swiftyJsonVar["tstats"]["level"]
            
            //Set the specified Labels to their corresponding conversions
            self.avgWpm.text = self.convertFromJSONToIntToLabelableString(jsonVal: avgWpmJSON) + "wpm"
            self.bestWPM.text = self.convertFromJSONToIntToLabelableString(jsonVal: bestWPMJSON)
            self.gamesWon.text = self.convertFromJSONToIntToLabelableString(jsonVal: gamesWonJSON)
            self.level.text = String(describing: levelJSON)
            self.fullName.text = String(describing: firstNameJSON) + " " + String(describing: lastNameJSON)
            self.country.text = String(describing: countryJSON).uppercased()
            
            //Print all the parsed JSON
            print(swiftyJsonVar)
            
            
        }
        
        
    }
    
    //TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfRecent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "RecentScoresCell", for: indexPath) as! RecentScoresTableViewCells
        
        return cell
    }

    //Method to convert the JSON into an Integer
    func convertFromJSONToIntToLabelableString(jsonVal: JSON) -> String{
        let JSONtoString = String(describing: jsonVal)
        let stringToDoub = Double(JSONtoString)
        let doubToInt = Int(stringToDoub!)
        let final = String(describing: doubToInt)
        
        return final
    }


}

