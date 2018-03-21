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
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mbrStatLbl: UILabel!
    @IBOutlet weak var spouseLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var primaryConLbl: UILabel!
    @IBOutlet weak var secondaryConLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var mbrStatusRect: UIView!
    @IBOutlet weak var SpouseViewRect: UIView!
    @IBOutlet weak var AddressViewRect: UIView!
    @IBOutlet weak var PrimaryContactViewRect: UIView!
    @IBOutlet weak var SecondaryContactViewRect: UIView!
    @IBOutlet weak var EmailViewRect: UIView!
    
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
            contactImage.frame = CGRect(x: 0, y: 0, width: 153, height: 153)
        }
        else{ //Pull stock flower image
            //print("Clear")
            let image = UIImage(named: "CarolinaYellowJessamineMed1")
            
            contactImage.image = image
        }
        
        contactImage.layer.borderWidth = 1
        contactImage.layer.masksToBounds = false
        contactImage.layer.cornerRadius = contactImage.frame.width/1.6 //dont know why 1.6 look better than 2
        contactImage.clipsToBounds = true;
        contactImage.layer.borderColor = UIColor.black.cgColor
        
        
        
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
        
        nameLbl.text = contact.FirstName + " " + contact.LastName
        spouseLbl.text = contact.Spouse
        mbrStatLbl.text = contact.MbrStatus
        addressLbl.text = contact.StreetAddress
        primaryConLbl.text = contact.PrimaryContactNo
        secondaryConLbl.text = contact.SecondaryContactNo
        emailLbl.text = contact.ContactEmail
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
        let telephoneNum = contact.PrimaryContactNo.replacingOccurrences(of: ".", with: "")
        
        if let url = URL(string: "tel://\(telephoneNum)"), UIApplication.shared.canOpenURL(url) {
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
