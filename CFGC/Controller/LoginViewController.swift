//
//  ViewController.swift
//  CFGC
//
//  Created by Cory on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    var currentUser: User!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.borderStyle = UITextBorderStyle.roundedRect
        password.borderStyle = UITextBorderStyle.roundedRect
        submitBtn.layer.cornerRadius = 23
        
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton){
    
        currentUser = User(userName: userName.text!, password: password.text!)
        if (verifyLogin(userName: currentUser.userName, password: password.text!)){
            performSegue(withIdentifier: "ContactVC", sender: currentUser)
        }
        else{
            createAlert(title: "Login Failure", message: "Incorrect Username or Password")
        }
    }
    
    func createAlert (title: String!, message: String!){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyLogin(userName: String, password: String) -> Bool{
        if (userName == "test" && password == "testing"){
            return true;
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactVC"{
            
                if let contVC = segue.destination as? ContactVC{
                    if let user = sender as? User {
                        contVC.currentUser = user;
                    }
                }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
