//
//  InfoVC.swift
//  CFGC
//
//  Created by Cory on 2/26/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    var contact: ContactCard!
    
    @IBOutlet weak var contactImage: UIImageView!
    
    
    @IBOutlet var swipe: UISwipeGestureRecognizer!

    @IBOutlet weak var nameTxt: UITextField!

    @IBOutlet weak var mbrStatTxt: UITextField!
    
    @IBOutlet weak var spouseTxt: UITextField!

    @IBOutlet weak var addressTxt: UITextView!

    @IBOutlet weak var primaryConTxt: UITextField!
    
    @IBOutlet weak var secondaryConTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    
    @IBOutlet weak var membersBackBtn: UIBarButtonItem!
    
    @IBOutlet weak var txtMsgBtn: UIBarButtonItem!
    @IBOutlet weak var callBtn: UIBarButtonItem!
    @IBOutlet weak var emailBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildInfoScreen()
        // Do any additional setup after loading the view.
    }
    
    func buildInfoScreen(){
        //mbrStatLbl.layer.borderColor = UIColor.black.cgColor
        //mbrStatLbl.layer.borderWidth = 1.0
        //mbrStatLbl.layer.cornerRadius = 20
        
        //Get photo from photo ID in recieved contact: ContactCard
        let imageName = contact.PhotoId
        let image = UIImage(named: imageName)
        if(image != nil){
            print("Image found!")
            contactImage.image = image
            
        }
        else{ //Pull stock flower image
            //print("Clear")
            let image = UIImage(named: "CarolinaYellowJessamineMed1")
            
            contactImage.image = image
        }
        
        contactImage.layer.borderWidth = 1
        contactImage.layer.masksToBounds = true
        //contactImage.layer.cornerRadius = contactImage.frame.width/1.5 //dont know why 1.6 look better than 2
        viewWillLayoutSubviews()
        contactImage.clipsToBounds = true;
        contactImage.layer.borderColor = UIColor.black.cgColor
        
        
        /*
        mbrStatusRect.layer.borderColor = UIColor.black.cgColor
        mbrStatusRect.layer.borderWidth = 1.0
        mbrStatusRect.layer.cornerRadius = 20
        
        SpouseViewRect.layer.borderColor = UIColor.black.cgColor
        SpouseViewRect.layer.borderWidth = 1.0
        SpouseViewRect.layer.cornerRadius = 20
        
        AddressViewRect.layer.borderColor = UIColor.black.cgColor
        AddressViewRect.layer.borderWidth = 1.0
        AddressViewRect.layer.cornerRadius = 20
        
        PrimaryContactViewRect.layer.borderColor = UIColor.black.cgColor
        PrimaryContactViewRect.layer.borderWidth = 1.0
        PrimaryContactViewRect.layer.cornerRadius = 20
        
        SecondaryContactViewRect.layer.borderColor = UIColor.black.cgColor
        SecondaryContactViewRect.layer.borderWidth = 1.0
        SecondaryContactViewRect.layer.cornerRadius = 20
        
        EmailViewRect.layer.borderColor = UIColor.black.cgColor
        EmailViewRect.layer.borderWidth = 1.0
        EmailViewRect.layer.cornerRadius = 20
        */
        
        
        
        addressTxt.layer.borderColor = UIColor.black.cgColor
        addressTxt.layer.borderWidth = 1.0
        addressTxt.layer.cornerRadius = 25
        
        nameTxt.text = contact.FirstName + " " + contact.LastName
        nameTxt.allowsEditingTextAttributes = false
        spouseTxt.text = contact.Spouse
        mbrStatTxt.text = contact.MbrStatus
        addressTxt.text = contact.StreetAddress + " " + contact.City + ", " + contact.State + " " + contact.ZipCode
        primaryConTxt.text = contact.PrimaryContactNo
        secondaryConTxt.text = contact.SecondaryContactNo
        emailTxt.text = contact.ContactEmail
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contactImage.layer.cornerRadius = contactImage.frame.height / 2.0
    }
    
    @IBAction func membersBackBtnPressed(_ sender: UIBarButtonItem){
        performSegue(withIdentifier: "ContactVC", sender: nil)
    }
    
    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer){
        if gestureRecognizer.state == .ended{
            performSegue(withIdentifier: "BiographicalVC", sender: contact)
        }
    }
    
    @IBAction func callBtnPressed(_ sender: UIBarButtonItem){
        
        let primaryNum = contact.PrimaryContactNo.replacingOccurrences(of: ".", with: "")
        let secondaryNum = contact.SecondaryContactNo.replacingOccurrences(of: ".", with: "")
        
        let phoneActionSheet = UIAlertController(title: "Please Select A Number", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let primaryPhoneButtonAction = UIAlertAction(title: "Primary Phone: " + contact.PrimaryContactNo, style: UIAlertActionStyle.default){(ACTION) in
            self.callSelectedNumber(number: primaryNum)
        }
        
        let secondaryPhoneButtonAction = UIAlertAction(title: "Secondary Phone: " + contact.SecondaryContactNo, style: UIAlertActionStyle.default){(ACTION) in
            self.callSelectedNumber(number: secondaryNum)
        }
        
        let cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default){
            (ACTION) in
            print("canceled")
        }
        
        phoneActionSheet.addAction(primaryPhoneButtonAction)
        phoneActionSheet.addAction(secondaryPhoneButtonAction)
        phoneActionSheet.addAction(cancelButtonAction)
        
        self.present(phoneActionSheet, animated: true, completion: nil)
        
    }
    
    private func callSelectedNumber(number: String){
        
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactVC"{
            
            var contVC = segue.destination as? ContactVC
        }
        
        else if segue.identifier == "BiographicalVC"{
            if let bioVC = segue.destination as? BiographicalVC{
                if let contact = sender as? ContactCard{
                    bioVC.contactCard = contact
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
