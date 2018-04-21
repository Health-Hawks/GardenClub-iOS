//
//  BiographicalVC.swift
//  CFGC
//
//  Created by Cory on 3/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class BiographicalVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var contact: ContactCard!
    var contactCards: [ContactCard]!
    var currentUser: User!
    var inEditState = false
    var shouldRaiseKeyboard = false
    var firstTimeEditingBio = true
    var updateInstance: Background!
    //@IBOutlet weak var yearLbl: UILabel!
    //@IBOutlet weak var biographicalLbl: UILabel!
    @IBOutlet weak var yearActiveTextField: UITextField!
    @IBOutlet weak var BiographicalTextField: UITextView!


    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    @IBOutlet weak var returnBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        buildBiographicalView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == BiographicalTextField{
            shouldRaiseKeyboard = true
            if firstTimeEditingBio{
                createAlert(title: "Editing Biographical Info", message: "There is a maximum character limit of 255.")
                firstTimeEditingBio = false
            }
            //print("startedEditingBio")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == yearActiveTextField{
            shouldRaiseKeyboard = false
        }
    }
    
    @objc func keyboardWillChange(notification: Notification){
        //print("Keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if ((notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame) && shouldRaiseKeyboard){
            
            view.frame.origin.y = -keyboardRect.height + 80
        }
        else{
            view.frame.origin.y = 0
        }
        
    }
    /*
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == yearActiveTextField {
            return false; //do not show keyboard nor cursor
        }
        return true
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func buildBiographicalView(){
        self.activateEditBtn()
        firstTimeEditingBio = true
        shouldRaiseKeyboard = false
        returnBtn.isEnabled = true
        returnBtn.title = contact.FirstName + " " + contact.LastName
        cancelBtn.isEnabled = false
        cancelBtn.tintColor = UIColor.clear
        saveBtn.isEnabled = false
        saveBtn.tintColor = UIColor.clear
        //yearLbl.text = contactCard.YearTurnedActive
        //biographicalLbl.text = contactCard.BiographicalInfo
        yearActiveTextField.delegate = self
        BiographicalTextField.delegate = self
        
        
        yearActiveTextField.text = "  " + contact.YearTurnedActive
        yearActiveTextField.layer.borderColor = UIColor.black.cgColor
        yearActiveTextField.layer.borderWidth = 1.0
        yearActiveTextField.layer.cornerRadius = 20
        yearActiveTextField.backgroundColor = UIColor.clear
        yearActiveTextField.isEnabled = false
        yearActiveTextField.allowsEditingTextAttributes = false
        
        
        BiographicalTextField.text = contact.BiographicalInfo
        BiographicalTextField.layer.borderColor = UIColor.black.cgColor
        BiographicalTextField.layer.borderWidth = 1.0
        BiographicalTextField.layer.cornerRadius = 20
        BiographicalTextField.backgroundColor = UIColor.clear
        BiographicalTextField.isEditable = false
        BiographicalTextField.allowsEditingTextAttributes = false
        
    }
    @IBAction func editBtnPressed(_ sender: Any){
        inEditState = true
        returnBtn.isEnabled = false
        editBtn.isEnabled = false
        cancelBtn.isEnabled = true
        cancelBtn.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        saveBtn.isEnabled = true
        saveBtn.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        enableTextFieldsForEdit()
        createAlert(title: "Editing Information", message: "Attention:\nChanging information within this application will change your website data as well.")
    }
    
    private func activateEditBtn (){
        if(contact.ContactEmail != ""){
            if(contact.ContactEmail == currentUser.userName){
                editBtn.isEnabled = true;
            }
            else{
                editBtn.isEnabled = false;
                editBtn.tintColor = UIColor.clear
            }
        }
    }
    
    private func enableTextFieldsForEdit(){
        yearActiveTextField.isEnabled = true
        yearActiveTextField.allowsEditingTextAttributes = true
        yearActiveTextField.layer.borderColor = UIColor.blue.cgColor
        yearActiveTextField.backgroundColor = UIColor.yellow
        BiographicalTextField.isEditable = true
        BiographicalTextField.allowsEditingTextAttributes = true
        BiographicalTextField.layer.borderColor = UIColor.blue.cgColor
        BiographicalTextField.backgroundColor = UIColor.yellow
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        inEditState = false
        self.saveYearTA()
        self.saveBioInfo()
        updateInstance = Background(updateBio: true, contact: contact)
        self.buildBiographicalView()
    }
    
    private func saveYearTA(){
        let enteredYear = yearActiveTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
        
        if enteredYear?.count != 4{
            createAlert(title: "Invalid Year Entry", message: "Please enter a valid year before saving.")
        }
        
        else if let converted = Int(enteredYear!){
            contact.setYearTA(yearTA: String(converted))
        }
        else{
            createAlert(title: "Invalid Year Entry", message: "Please enter a valid year before saving.")
        }
        
    }
    
    private func saveBioInfo(){
        let enteredBio = BiographicalTextField.text
        
        if (enteredBio?.count)! < 255{
            contact.setBiographicalInfo(newBio: enteredBio!)
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        inEditState = false
        self.buildBiographicalView()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = BiographicalTextField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changedText.count <= 255
    }
    
    @IBAction func returnBtnPressed(_ sender: UIBarButtonItem){
        performSegue(withIdentifier: "InfoVC", sender: contact)
    }
    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer){
        if gestureRecognizer.state == .ended{
            performSegue(withIdentifier: "InfoVC", sender: contact)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoVC"{
            
            if let infoVC = segue.destination as? InfoVC{
                if let contact = sender as? ContactCard {
                    infoVC.contact = contact;
                    infoVC.contactCards = contactCards
                    infoVC.currentUser = currentUser
                }
            }
        }
    }
    
    func createAlert (title: String!, message: String!){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
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
