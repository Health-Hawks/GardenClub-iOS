//
//  InfoVC.swift
//  CFGC
//
//  Created by Cory on 2/26/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit
import MessageUI
class InfoVC: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate{
    
    var contact: ContactCard!
    var contactCards: [ContactCard]!
    var currentUser: User!
    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
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
        
        
        addressTxt.text = contact.StreetAddress + " " + contact.CityAndState + " " + contact.ZipCode
        addressTxt = adjustUITextViewHeight(arg: addressTxt)

        addressTxt.layer.borderColor = UIColor.black.cgColor
        addressTxt.layer.borderWidth = 1.0
        addressTxt.layer.cornerRadius = 25
        
        nameTxt.text = contact.FirstName + " " + contact.LastName
        nameTxt.allowsEditingTextAttributes = false
        
        spouseTxt.text = contact.Spouse
        spouseTxt.layer.borderColor = UIColor.black.cgColor
        spouseTxt.layer.borderWidth = 1.0
        spouseTxt.layer.cornerRadius = 20
        
        mbrStatTxt.text = contact.MbrStatus
        mbrStatTxt.layer.borderColor = UIColor.black.cgColor
        mbrStatTxt.layer.borderWidth = 1.0
        mbrStatTxt.layer.cornerRadius = 20
        
        
        primaryConTxt.text = contact.PrimaryContactNo
        primaryConTxt.layer.borderColor = UIColor.black.cgColor
        primaryConTxt.layer.borderWidth = 1.0
        primaryConTxt.layer.cornerRadius = 20
        
        secondaryConTxt.text = contact.SecondaryContactNo
        secondaryConTxt.layer.borderColor = UIColor.black.cgColor
        secondaryConTxt.layer.borderWidth = 1.0
        secondaryConTxt.layer.cornerRadius = 20
        
        emailTxt.text = contact.ContactEmail
        emailTxt.layer.borderColor = UIColor.black.cgColor
        emailTxt.layer.borderWidth = 1.0
        emailTxt.layer.cornerRadius = 20
    }
    
    func isCurrentUser (){
        //check if the current user matches the contact selected
        contact.UserID
    }
    
    func adjustUITextViewHeight(arg : UITextView) -> UITextView
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        let fixedWidth = arg.frame.size.width
        arg.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = arg.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = arg.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        arg.frame = newFrame
        arg.isScrollEnabled = false
        return arg
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
    
    @IBAction func textMessagePressed(_ sender: Any) {
        let textMessageRecipients = [contact.PrimaryContactNo]
        if MFMessageComposeViewController.canSendText(){
            let messageComposeVC = MFMessageComposeViewController()
            messageComposeVC.messageComposeDelegate = self
            messageComposeVC.recipients = textMessageRecipients
            messageComposeVC.body = "Sending from my iPhone"
            self.present(messageComposeVC, animated: true, completion: nil)
        }
        else {
            print ("SMS service is not available")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    @IBAction func emailPressed(_ sender: Any) {
        let emailMessageRecipients = [contact.ContactEmail]
        if MFMailComposeViewController.canSendMail(){
            let emailComposeVC = MFMailComposeViewController()
            emailComposeVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            emailComposeVC.setToRecipients(emailMessageRecipients)
            emailComposeVC.setSubject("Hello!")
            emailComposeVC.setMessageBody("From my iPhone", isHTML: false)
            self.present(emailComposeVC, animated: true, completion: nil)
        }
        else {
            print ("Email unavailble")
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactVC"{
            
            if let contVC = segue.destination as? ContactVC{
                contVC.contactCards = contactCards
            }
        }
        
        else if segue.identifier == "BiographicalVC"{
            if let bioVC = segue.destination as? BiographicalVC{
                if let contact = sender as? ContactCard{
                    bioVC.contactCard = contact
                    bioVC.contactCards = contactCards
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
