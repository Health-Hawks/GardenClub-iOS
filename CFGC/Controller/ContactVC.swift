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
    var currentUser: User!
    var userDictionary = [String: [String]]()
    var userSectionTitles = [String]()
    var possibleDuplicate = 0;
    private var login_url = "http://satoshi.cis.uncw.edu/~jbr5433/GardenClub/login.php";
    
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false;
    //var users = [String]()
    
    var conCellModels = [ContactModel]()        // model
    
    var contactCards = [ContactCard]()
    var filteredContacts = [ContactCard]()
    var filteredUserSectionTitles = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Future JSON Decoder Call to class Background
        let backG = Background(login: true)
        contactCards = backG.contactCards
        */
        
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
                    //print(c1.LastName)
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
            //print(user.LastName)
            if var userValues = userDictionary[userKey] {
                userValues.append(user.LastName + user.FirstName)
                //print(userValues[0],userValues[1])
                userDictionary[userKey] = userValues
            } else {
                userDictionary[userKey] = [user.LastName + user.FirstName]
            }
        }
        /*
        for section in userDictionary{
            print(section.key + " " + String(section.value.count))
        }
        */
        /*
        let p1 = ContactModel(imageURL: "test", firstName: "Elizabeth",lastName: "White Baker", mbrStat: "Active")
        let p2 = ContactModel(imageURL: "test", firstName: "Cory",lastName: "Shrum", mbrStat: "Inactive")
        let p3 = ContactModel(imageURL: "test", firstName: "Test",lastName: "Test", mbrStat: "Active")
        let p4 = ContactModel(imageURL: "test", firstName: "John",lastName: "Doe", mbrStat: "Active")
        let p5 = ContactModel(imageURL: "test", firstName: "Jane",lastName: "Doe", mbrStat: "Active")
        let p6 = ContactModel(imageURL: "test", firstName: "Jennifer",lastName: "Doe", mbrStat: "Active")

        conCellModels.append(p1)
        conCellModels.append(p2)
        conCellModels.append(p3)
        conCellModels.append(p4)
        conCellModels.append(p5)
        conCellModels.append(p6)
        
        conCellModels.sort { ($0.lastName.prefix(1) < $1.lastName.prefix(1)) } //sort array
        
        for user in conCellModels {
            let userKey = String(user.lastName.prefix(1))
            if var userValues = userDictionary[userKey] {
                userValues.append(user.lastName)
                userDictionary[userKey] = userValues
            } else {
                userDictionary[userKey] = [user.lastName]
            }
        }
        */
        
        userSectionTitles = [String](userDictionary.keys)
        userSectionTitles = userSectionTitles.sorted(by: { $0 < $1 })
        
        
        
        //print(userSectionTitles)
        
        tableView.delegate = self
        tableView.dataSource = self
    }


    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier:"ContactCell", for: indexPath) as? ContactCell{
            
            let contactModel = conCellModels[indexPath.row]
            
            cell.updateUI(contactModel: contactModel)
            
            return cell
        }
        
        else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conCellModels.count
    }
    **/
 
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
            return filteredContacts.count
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

                contact = filteredContacts[indexPath.row]
                
                cell.updateUI(contactCard: contact)
                
                return cell
            }
            
            var contact: ContactCard!
            let userKey = userSectionTitles[indexPath.section]
            var sectionSum = 0
            
            for section in userSectionTitles{
                let userValues = userDictionary[section]
                if(userKey > section){
                    sectionSum += userValues!.count
                }
            }
            
            contact = contactCards[sectionSum+indexPath.row]
            
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
            
            contact = filteredContacts[indexPath.row]
            
            performSegue(withIdentifier: "InfoVC", sender: contact)
        }
        
        var contact: ContactCard!
        let userKey = userSectionTitles[indexPath.section]
        var sectionSum = 0
        
        for section in userSectionTitles{
            let userValues = userDictionary[section]
            if(userKey > section){
                sectionSum += userValues!.count
            }
        }
        
        contact = contactCards[sectionSum+indexPath.row]
        
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
            print("insearchmode")
            let lower = String(searchBar.text!.lowercased())
            print(lower.uppercased().hasPrefix("B"))
            let pre = lower.prefix(1)
            print(pre)
            /*
            for section in userSectionTitles{
                print(String(section))
            }
 */
            
            filteredUserSectionTitles = userSectionTitles.filter({ $0.range(of: lower.uppercased().prefix(1)) != nil})
            
            filteredContacts = contactCards.filter({$0.LastName.lowercased().range(of: lower) != nil})
            
            
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoVC"{
            
            if let infoVC = segue.destination as? InfoVC{
                if let contact = sender as? ContactCard {
                    infoVC.contact = contact;
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

