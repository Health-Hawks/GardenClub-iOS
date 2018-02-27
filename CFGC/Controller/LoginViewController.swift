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
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.borderStyle = UITextBorderStyle.roundedRect
        password.borderStyle = UITextBorderStyle.roundedRect
        submitBtn.layer.cornerRadius = 23
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
