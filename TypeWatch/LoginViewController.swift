//
//  LoginViewController.swift
//  TypeWatch
//
//  Created by Brendon Ho on 12/8/17.
//  Copyright © 2017 Mengo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController:UIViewController{
    
    
    @IBOutlet weak var typeUser: UITextField!
    @IBOutlet weak var goDesign: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goDesign.layer.cornerRadius = 20
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        downSwipe.direction = .down;
        self.view.addGestureRecognizer(downSwipe);
    }
    
    //Move the username to the main ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let typed : String = self.typeUser.text!
        
        if(segue.identifier == "MoveToMain"){
            let svc = segue.destination as! ViewController
            svc.usrname = typed
        }
        
    }
    
    //The action the go arrow button goes through
    @IBAction func go(_ sender: Any) {
        let typed : String = self.typeUser.text!
        
        if(typed != "" && typed.count > 3
            ){
            let url = URL(string: "http://data.typeracer.com/users?id=tr:" + typed)
            checkForValidUser(link: url!)
        }else{
            alertte(title: "Hold Up!", message: "Please enter your username before you proceed")
        }
    }
    
    //An objective-c function to dismiss the keyboard
    @objc func dismissKeyboard(){
        if(self.typeUser.isFirstResponder){
            self.typeUser.resignFirstResponder()
        }
    }
    
    //A UIAlertController method
    func alertte(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //Method to check wheter a user is valid or not through AlamoFire -> Make sure to give alert when user is not valid instead of crashing
    func checkForValidUser(link: URL){
        
        Alamofire.request(link).responseJSON{(responseData) -> Void in
            let swiftyJsonVar = JSON(responseData.result.value!)
            if(swiftyJsonVar != JSON.null){
                self.performSegue(withIdentifier: "MoveToMain", sender: nil)
            }else{
                print("bad")
            }
        }
        
    }
    
}
