//
//  InfoVC.swift
//  CFGC
//
//  Created by Cory on 2/26/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit
import MessageUI
class InfoVC: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate,UITextFieldDelegate, UITextViewDelegate {
    
    var contact: ContactCard!
    var contactCards: [ContactCard]!
    var currentUser: User!
    var activeTextField: UITextField!
    var shouldRaiseKeyboard: Bool!
    var addressAlertCount = 0
    var inEditState = false
    var initialAddress: String!
    var updateInstance: Background!
    
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
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var txtMsgBtn: UIBarButtonItem!
    @IBOutlet weak var callBtn: UIBarButtonItem!
    @IBOutlet weak var emailBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxt.delegate = self
        spouseTxt.delegate = self
        addressTxt.delegate = self
        mbrStatTxt.delegate = self
        primaryConTxt.delegate = self
        secondaryConTxt.delegate = self
        emailTxt.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        buildInfoScreen()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //print("didBegin editing!")
        if textField == nameTxt || textField == mbrStatTxt || textField == spouseTxt{
            shouldRaiseKeyboard = false
            //print("Did not raise")
        }
        else{
            shouldRaiseKeyboard = true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == addressTxt{
            shouldRaiseKeyboard = true
            print("startedEditing")
            addressAlert()
            addressAlertCount = addressAlertCount + 1
        }
    }
    
    func addressAlert(){
        if addressAlertCount < 1{
            createAlert(title: "Address Change", message: "Ensure your new address conforms to the following format:\n 1234 John Doe Street; Wilmington, NC 28043")
        }
    }
    
    @objc func keyboardWillChange(notification: Notification){
        //print("Keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if ((notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame) && shouldRaiseKeyboard){
            
            view.frame.origin.y = -keyboardRect.height
        }
        else{
            view.frame.origin.y = 0
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editBtnPressed(_ sender: Any){
        inEditState = true
        membersBackBtn.isEnabled = false
        editBtn.isEnabled = false
        cancelBtn.isEnabled = true
        cancelBtn.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        saveBtn.isEnabled = true
        saveBtn.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        enableTextFieldsForEdit()
        createAlert(title: "Editing Information", message: "Attention:\nChanging information within this application will change your website data as well.")
    }
    
    private func enableTextFieldsForEdit(){
        nameTxt.isEnabled = true
        nameTxt.allowsEditingTextAttributes = true
        mbrStatTxt.isEnabled = true
        mbrStatTxt.allowsEditingTextAttributes = true
        spouseTxt.isEnabled = true
        spouseTxt.allowsEditingTextAttributes = true
        addressTxt.isEditable = true
        addressTxt.allowsEditingTextAttributes = false
        primaryConTxt.isEnabled = true
        primaryConTxt.allowsEditingTextAttributes = true
        secondaryConTxt.isEnabled = true
        secondaryConTxt.allowsEditingTextAttributes = true
        //Do not want to allow users to change their email.
        //emailTxt.isEnabled = true
        //emailTxt.allowsEditingTextAttributes = true
       
        nameTxt.backgroundColor = UIColor.yellow
        nameTxt.layer.borderWidth = 1.0
        nameTxt.layer.borderColor = UIColor.blue.cgColor
        mbrStatTxt.backgroundColor = UIColor.yellow
        mbrStatTxt.layer.borderColor = UIColor.blue.cgColor
        spouseTxt.backgroundColor = UIColor.yellow
        spouseTxt.layer.borderColor = UIColor.blue.cgColor
        addressTxt.backgroundColor = UIColor.yellow
        addressTxt.layer.borderColor = UIColor.blue.cgColor
        primaryConTxt.backgroundColor = UIColor.yellow
        primaryConTxt.layer.borderColor = UIColor.blue.cgColor
        secondaryConTxt.backgroundColor = UIColor.yellow
        secondaryConTxt.layer.borderColor = UIColor.blue.cgColor
        //emailTxt.backgroundColor = UIColor.yellow
        
        //print("name:",nameTxt.frame.origin.y, " mbrStat:",mbrStatTxt.frame.origin.y," spouse:", spouseTxt.frame.origin.y, " Address:", addressTxt.frame.origin.y, " Prim:", primaryConTxt.frame.origin.y, " sec:", secondaryConTxt.frame.origin.y, " email:", emailTxt.frame.origin.y)
        
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        inEditState = false
        self.saveName()
        self.saveSpouse()
        self.saveMbrStatus()
        self.saveAddress()
        self.savePrimNum()
        self.saveSecNum()
        //self.saveEmail() Dont want them to change their email.
        updateInstance = Background(updateBio: false, contact: contact)
        self.buildInfoScreen()
    }
    //Needs error Handling
    private func saveName(){

        let nameParse = nameTxt.text?.split(separator: " ")
        var firstName = ""
        var lastName = ""
        for x in nameParse!{
            if (x == nameParse?.last){
                lastName = String(x)
                contact.setLastName(lstName: lastName.trimmingCharacters(in: NSCharacterSet.whitespaces))
            }
            else if firstName == "" {
                firstName = String(x)
            }
            else{
                firstName = firstName + " " + String(x)
            }
        }
        contact.setFirstName(fName: firstName)
        print(contact.FirstName,contact.LastName)
    }
    //Needs Error Handling
    private func saveMbrStatus(){
        let mbrStatusParse = mbrStatTxt.text?.split(separator: " ")
        var newMbrStatus = ""
        for x in mbrStatusParse!{
            newMbrStatus = newMbrStatus + String(x)
        }
        contact.setMbrStatus(mStatus: newMbrStatus)
    }
    //Needs Error Handling
    private func saveSpouse(){
        let spouseParse = spouseTxt.text?.split(separator: " ")
        var newSpouse = ""
        
        for x in spouseParse!{
            if(newSpouse == ""){
                newSpouse = String(x)
            }
            else{
                newSpouse = newSpouse + " " + String(x)
            }
        }
        
        contact.setSpouse(newSpouse: newSpouse)
    }
    //Needs Error Handling a bit better
    private func saveAddress(){
        
        if addressTxt.text == initialAddress{
            addressTxt.text = initialAddress
        }
        
        else if !addressTxt.text.contains(","){
            createAlert(title: "Incorrect Address Submission", message: "Please ensure you have seperated your City from your State via a comma:\nWilmington, NC")
        }
        
        else if !addressTxt.text.contains(";"){
            createAlert(title: "Incorrect Address Submission", message: "Please ensure you have seperated your Street Address from your City via a semi colon:\n1234 John Doe Street;Wilmington")
        }
        else{
            let addressParse = addressTxt.text.split(separator: ",")
            //left side will be the street address, right side will be the state and zipcode
            let leftAddressParse = addressParse[0].split(separator: ";")
            let newStreetAddress = String(leftAddressParse[0])
            let newCity = String(leftAddressParse[1])
            
            let rightParse = addressParse[1].split(separator: " ")
            let newState = String(rightParse[0])
            let newZipcode = String(rightParse[1])
            
            let combinedCityAndState = newCity + ", " + newState
            contact.setAddress(address: newStreetAddress)
            contact.setCityAndState(city_state: combinedCityAndState)
            contact.setZipCode(zipCode: newZipcode)
        }
    }
    //Needs Error Handling
    private func savePrimNum(){
        let primPhone = primaryConTxt.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
        contact.setPrimaryPhone(primPhone: primPhone!)
    }
    private func saveSecNum(){
        let secPhone = primaryConTxt.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
        contact.setSecondaryPhone(secPhone: secPhone!)
    }
    /* Dont want to allow the changing of emails.
    private func saveEmail(){
        contact.setContactEmail(newEmail: emailTxt.text!)
    }
    *////
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        inEditState = false
        buildInfoScreen()
    }
    
    func activateEditBtn (){
        if(contact.ContactEmail != ""){
            if(contact.ContactEmail == currentUser.userName){
                editBtn.isEnabled = true;
                editBtn.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
            }
            else{
                editBtn.isEnabled = false;
                editBtn.tintColor = UIColor.clear
            }
        }
    }
    
    func buildInfoScreen(){
        activateEditBtn() //check if edit should be enabled
        initialAddress =  " " + contact.StreetAddress + " " + contact.CityAndState + " " + contact.ZipCode
        shouldRaiseKeyboard = false
        //print("building info screen")
        membersBackBtn.isEnabled = true
        
        saveBtn.isEnabled = false
        saveBtn.tintColor = UIColor.clear
        cancelBtn.isEnabled = false
        cancelBtn.tintColor = UIColor.clear
        //Get photo from photo ID in recieved contact: ContactCard
        let imageName = contact.PhotoId
        let image = UIImage(named: imageName)
        if(imageName != ""){
            print("Image found!")
            let image = UIImage(named: "CarolinaYellowJessamineMed1")
            contactImage.image = image
            //contactImage.image = image
            pullPhotoFromURL(imageID: imageName)
            
        }
        else{ //Pull stock flower image
            //print("Clear")
            let image = UIImage(named: "CarolinaYellowJessamineMed1")
            
            contactImage.image = image
        }
        
        nameTxt.layer.borderWidth = 0.0
        nameTxt.layer.borderColor = UIColor.clear.cgColor
        
        contactImage.layer.borderWidth = 1
        contactImage.layer.masksToBounds = true
        //contactImage.layer.cornerRadius = contactImage.frame.width/1.5 //dont know why 1.6 look better than 2
        viewWillLayoutSubviews()
        contactImage.clipsToBounds = true;
        contactImage.layer.borderColor = UIColor.black.cgColor
        
        addressTxt.text = " " + contact.StreetAddress + " " + contact.CityAndState + " " + contact.ZipCode
        addressTxt = adjustUITextViewHeight(arg: addressTxt)
        addressTxt.backgroundColor = UIColor.clear
        addressTxt.layer.borderColor = UIColor.black.cgColor
        addressTxt.layer.borderWidth = 1.0
        addressTxt.layer.cornerRadius = 25
        addressTxt.isEditable = false
        addressTxt.allowsEditingTextAttributes = false

        nameTxt.text = " " + contact.FirstName + " " + contact.LastName
        nameTxt.allowsEditingTextAttributes = false
        nameTxt.backgroundColor = UIColor.clear
        nameTxt.isEnabled = false
        nameTxt.allowsEditingTextAttributes = false
        
        spouseTxt.text = " " + contact.Spouse
        spouseTxt.layer.borderColor = UIColor.black.cgColor
        spouseTxt.layer.borderWidth = 1.0
        spouseTxt.layer.cornerRadius = 20
        spouseTxt.backgroundColor = UIColor.clear
        spouseTxt.isEnabled = false
        spouseTxt.allowsEditingTextAttributes = false
        
        mbrStatTxt.text = " " + contact.MbrStatus
        mbrStatTxt.layer.borderColor = UIColor.black.cgColor
        mbrStatTxt.layer.borderWidth = 1.0
        mbrStatTxt.layer.cornerRadius = 20
        mbrStatTxt.backgroundColor = UIColor.clear
        mbrStatTxt.isEnabled = false
        mbrStatTxt.allowsEditingTextAttributes = false
        
        primaryConTxt.text = " " + contact.PrimaryContactNo
        primaryConTxt.layer.borderColor = UIColor.black.cgColor
        primaryConTxt.layer.borderWidth = 1.0
        primaryConTxt.layer.cornerRadius = 20
        primaryConTxt.backgroundColor = UIColor.clear
        primaryConTxt.isEnabled = false
        primaryConTxt.allowsEditingTextAttributes = false

        
        secondaryConTxt.text = " " + contact.SecondaryContactNo
        secondaryConTxt.layer.borderColor = UIColor.black.cgColor
        secondaryConTxt.layer.borderWidth = 1.0
        secondaryConTxt.layer.cornerRadius = 20
        secondaryConTxt.backgroundColor = UIColor.clear
        secondaryConTxt.isEnabled = false
        secondaryConTxt.allowsEditingTextAttributes = false

        emailTxt.text = " " + contact.ContactEmail
        emailTxt.layer.borderColor = UIColor.black.cgColor
        emailTxt.layer.borderWidth = 1.0
        emailTxt.layer.cornerRadius = 20
        emailTxt.backgroundColor = UIColor.clear
        emailTxt.isEnabled = false
        emailTxt.allowsEditingTextAttributes = false

    }
    
    func createAlert (title: String!, message: String!){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
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
        if gestureRecognizer.state == .ended && !inEditState{
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
    
    
    func pullPhotoFromURL(imageID: String){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://capefeargardenclub.org/cfgcTestingJSON/getImage2.php")! as URL)
        
        //let imageURL = imageID

        request.httpMethod = "POST"
        
        let postString = "userID=\(contact.UserID)&email=\(contact.ContactEmail)&photoID=\(imageID)"
        request.httpBody = postString.data(using: String.Encoding.ascii)
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                print("response = \(response)")
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString)")
                do{
                    let data = try Data(contentsOf: request.url!)
                    DispatchQueue.main.sync {
                        print(data.)
                        print(request.url?.absoluteString)
                        print(request.httpBody)
                        self.contactImage.image = UIImage(data: data)
                    }
                } catch{
                    print("Exception Image")
                }
                
                
            }
            task.resume()
        }
       
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactVC"{
            
            if let contVC = segue.destination as? ContactVC{
                contVC.contactCards = contactCards
                contVC.currentUser = currentUser
            }
        }
        
        else if segue.identifier == "BiographicalVC"{
            if let bioVC = segue.destination as? BiographicalVC{
                if let contact = sender as? ContactCard{
                    bioVC.contact = contact
                    bioVC.contactCards = contactCards
                    bioVC.currentUser = currentUser
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
    
    /*
     @objc func keyboardDidShow(notification: Notification){
     let info:NSDictionary = notification.userInfo! as NSDictionary
     let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
     let keyboardY = self.view.frame.size.height - keyboardSize.height
     
     let editingTextFieldY: CGFloat! = self.activeTextField?.frame.origin.y
     
     if (self.view.frame.origin.y >= 0){
     //check if the the text field is behind the keyboard
     if (editingTextFieldY > (keyboardY - 60)) {
     UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations:{
     self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 60)), width: self.view.bounds.width, height: self.view.bounds.height)
     }, completion: nil)
     }
     }
     }
     
     @objc func keyboardWillHide(notification: Notification){
     UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations:{
     self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
     }, completion: nil)
     
     }
     
     override func viewWillDisappear(_ animated: Bool) {
     NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
     NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
     
     }
     
     func textFieldDidBeginEditing(_ textField: UITextField) {
     activeTextField = textField    }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     textField.resignFirstResponder()
     return true
     }
     */


}
