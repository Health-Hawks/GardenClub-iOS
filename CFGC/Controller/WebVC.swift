//
//  WebVC.swift
//  CFGC
//
//  Created by Cory on 4/23/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class WebVC: UIViewController, UIWebViewDelegate {
    
    var currentUser: User!
    var currentURL: String!
    var contactCards: [ContactCard]!
    
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.webView.delegate = self
        let url = NSURL (string: "http://www.capefeargardenclub.org/wp-login.php")! as URL;
        let requestObj = NSURLRequest(url: url)
        myWebView?.loadRequest(requestObj as URLRequest)
        // Do any additional setup after loading the view.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("attempting to fill form")
        // fill data
        let savedUsername = currentUser.userName
        let savedPassword = currentUser.password
        
        let fillForm = String(format: "document.getElementById('user_login').value = '\(savedUsername)';document.getElementById('user_pass').value = '\(savedPassword)';")
        webView.stringByEvaluatingJavaScript(from: fillForm)
        
        //check checkboxes
        //webView.stringByEvaluatingJavaScript(from: "document.getElementById('expert_remember_me').checked = true; document.getElementById('expert_terms_of_service').checked = true;")
        
        //submit form
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            webView.stringByEvaluatingJavaScript(from: "document.forms[\"loginform\"].submit();")
        }
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        //currentURL = webView.request?.url?.absoluteString
        //verifyLogin(url: currentURL)
    }
    
    func verifyLogin(url: String){
        let authentication = Background(url: url)
        
        if authentication.login_wp{
            performSegue(withIdentifier: "ContactVC", sender:currentUser )
        }
        else{
            performSegue(withIdentifier: "LoginViewController", sender: currentUser)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactVC"{
            
            if let contVC = segue.destination as? ContactVC{
                if let user = sender as? User {
                    contVC.currentUser = user;
                    contVC.contactCards = self.contactCards
                }
            }
        }
        else if segue.identifier == "LoginViewController"{
            if let logVC = segue.destination as? LoginViewController{
                if let user = sender as? User {
                    logVC.currentUser = user
                    //logVC.userName.text = user.userName
                    //logVC.password.text = user.password
                    logVC.authenticated = false
                    logVC.loginAttempts = 1
                }
            }
        }
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
