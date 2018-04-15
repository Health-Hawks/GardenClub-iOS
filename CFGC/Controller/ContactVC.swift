//
//  ViewController.swift
//  CFGC
//
//  Created by Cory Shrum on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class ContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var currentUser: User?
    var userDictionary = [String: [ContactCard]]()
    var userSectionTitles = [String]()
    var possibleDuplicate = 0;
    
    private var login_url = "http://satoshi.cis.uncw.edu/~jbr5433/GardenClub/login.php";
    
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false;
    
    //var users = [String]()
    
    //var conCellModels = [ContactModel]()        // model
    
    var contactCards = [ContactCard]()
    
    var filteredContacts = [ContactCard]()
    var filteredUserSectionTitles = [String]()
    
    //going to try a dictionary of filtered items
    
    var filteredDictionary = [String: [ContactCard]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*///////////////////////////////////////////////////////
        Future JSON Decoder Call to class Background
        let backG = Background(login: true)
        contactCards = backG.contactCards
        *////////////////////////////////////////////////////////
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        let path = Bundle.main.path(forResource: "sqlData_1", ofType: "txt") //path to text file
        
        let fileMgr = FileManager.default
        
        
        if fileMgr.fileExists(atPath: path!){ //if file exists
            do{
                let fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8) // gets entire text document
                
                let readings = fullText.components(separatedBy: "\n"); //array of lines in text file
                
                for i in 0..<readings.count-1 {
                    
                    var contactData = readings[i].components(separatedBy: ",") //delineated by commas
                    
                    for x in 0...contactData.count-1 {
                        
                        if (contactData[x] == "null"){
                            contactData[x] = ""
                        }
                        
                    }
                    
                    let c1 = ContactCard(PhotoID: contactData[0], UserID: contactData[1], MbrStatus: contactData[2], YearTurnedActive: contactData[3], LastName: contactData[4], FirstName: contactData[5], Spouse: contactData[6], StreetAddress: contactData[7], City: contactData[8], State: contactData[9], ZipCode: contactData[10], PrimaryContactNo: contactData[11], SecondaryContactNo: contactData[12], ContactEmail: contactData[13], TypeofPrimaryContactNo: contactData[14], TypeofSecondaryContactNo: contactData[15], Officer: contactData[16], OfficerTitle: contactData[17], ExcecutiveBdMbrship: contactData[18], CurrentCmteAssignment1: contactData[19], CmteAssign1Chair: contactData[20], CmteAssign1CoChair: contactData[21], CurrentCmteAssignment2: contactData[22], CmteAssign2Chair: contactData[23], CmteAssign2CoChair: contactData[24], CurrentCmteAssignment3: contactData[25], CmteAssign3Chair: contactData[26], CmteAssign3CoChair: contactData[27], BiographicalInfo: contactData[28])
                    
                    contactCards.append(c1); //append to array of contacts
                }
                
            }catch let error as NSError{
                print("Error \(error)")
            }
        }
        
        contactCards = contactCards.sorted{ ($0.LastName < $1.LastName) } //sort array (Seems to be a bug here)
        
        for user in contactCards {
            var userKey = String(user.LastName.prefix(1))
            if (userKey == userKey.lowercased()){
                userKey = userKey.uppercased()
            }
            
            if var userValues = userDictionary[userKey] {
                userValues.append(user)
                
                userDictionary[userKey] = userValues
            } else {
                userDictionary[userKey] = [user]
            }
        }
        
        
        userSectionTitles = [String](userDictionary.keys)
        userSectionTitles = userSectionTitles.sorted(by: { $0 < $1 })
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        if (inSearchMode){
            return filteredUserSectionTitles.count
        }
        
        return userSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        if(inSearchMode){
            let userKey = filteredUserSectionTitles[section]
            if let userValues = filteredDictionary[userKey]{
                return userValues.count
            }
        }
        
        let userKey = userSectionTitles[section]
        if let userValues = userDictionary[userKey] {
            return userValues.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 3
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell{
            
            if(inSearchMode){
                var contact: ContactCard!
                let userKey = filteredUserSectionTitles[indexPath.section]

                //contact = filteredContacts[indexPath.row]
                
                contact = filteredDictionary[userKey]?[indexPath.row]
                
                cell.updateUI(contactCard: contact)
                
                return cell
            }
            
            var contact: ContactCard!
            
            //SUCCESS
            let testSection = userSectionTitles[indexPath.section]
            contact = userDictionary[testSection]?[indexPath.row]
            
            cell.updateUI(contactCard: contact)

            return cell
        }
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(inSearchMode){
            return filteredUserSectionTitles[section]
        }
        return userSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if(inSearchMode){
            return filteredUserSectionTitles
        }
        
        return userSectionTitles
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(inSearchMode){
            var contact: ContactCard!
            let userKey = filteredUserSectionTitles[indexPath.section]
            
            contact = filteredDictionary[userKey]?[indexPath.row]
            
            performSegue(withIdentifier: "InfoVC", sender: contact)
        }
        
        var contact: ContactCard!
        
        let userKey = userSectionTitles[indexPath.section]
        
        contact = userDictionary[userKey]?[indexPath.row]
        
        performSegue(withIdentifier: "InfoVC", sender: contact)
    }
    
    @IBAction func logoutBtnPressed(_ logoutBtn: UIBarButtonItem){
        //segue to loginVC with empty currentUser
        //send empty user
        let user = User(userName: "", password: "")
        performSegue(withIdentifier: "LoginVC", sender: user)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
            
        }else {
            
            inSearchMode = true
            
            let lower = String(searchBar.text!.lowercased())
            
            filteredDictionary.removeAll() // clear dictionary for identifying new entry
            filteredUserSectionTitles.removeAll() // clear section titles
            
            //Build filtered dictionary via matching first and last name components
            //sift through first name & last name possiblities
            
                for (section, contacts) in userDictionary{ //steps through data within the main dictionary
                    
                    var firstNameCounted = false // identifier for adding a new section based on first name
                    var lastNameCounted = false // identifier for adding a new section based on last name
                    
                    for contact in contacts{ //pulls each individual contact within the section
                        
                        if (contact.FirstName.lowercased().range(of: lower) != nil) {
                            if var filtContacts = filteredDictionary[section] {
                                filtContacts.append(contact) //add matched contact to the section
                                filteredDictionary[section] = filtContacts
                                
                            }
                            
                            else if !firstNameCounted{
                                filteredDictionary[section] = [contact] //creates a section for the contact match
                                filteredUserSectionTitles.append(section)
                                firstNameCounted = true
                            }
                            
                            
                        }
                        //same as above but for all last name matches
                        else if (contact.LastName.lowercased().range(of: lower) != nil){
                            if var filtContacts = filteredDictionary[section] {
                                filtContacts.append(contact)
                                filteredDictionary[section] = filtContacts
                                
                            }
                            
                            else if !lastNameCounted{
                                filteredDictionary[section] = [contact]
                                filteredUserSectionTitles.append(section)
                                lastNameCounted = true
                            }
                            
                            
                        }
                        
                    }
                }
            
            filteredUserSectionTitles = filteredUserSectionTitles.sorted(by: { $0 < $1 }) //sort sections
            /*
            //testing the evolution of the filtered dictionary for each new search entry
            print("/////////////////////////////////new")
            var count = 0
            for (section, contacts) in filteredDictionary{
                //var response = "no"
                //if (filteredUserSectionTitles[count] != ""){
                   // response = "Yes"
                //}
                print(section, ": ") //response)
                count = count + 1
                for contact in contacts{
                    print(contact.FirstName, " ", contact.LastName)
                    
                }
            }
        
            for userKey in filteredUserSectionTitles{
                print(userKey)
            }
            */
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoVC"{
            
            if let infoVC = segue.destination as? InfoVC{
                if let contact = sender as? ContactCard {
                    infoVC.contact = contact;
                    infoVC.currentUser = currentUser
                }
            }
            
        }
        
        if segue.identifier == "LoginVC"{
            if let loginVC = segue.destination as? LoginViewController{
                if let user = sender as? User{
                    loginVC.currentUser = user
                }
            }
        }
    }
 
}

