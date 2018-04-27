//
//  ViewController.swift
//  CFGC
//
//  Created by Cory Shrum on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit
import CoreData

class ContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<Thumbnail>!
    
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var currentUser: User?
    var userDictionary = [String: [ContactCard]]()
    var userSectionTitles = [String]()
    var possibleDuplicate = 0;
    var filesToDownload = 0
    
    private var login_url = "http://capefeargardenclub.org/get_json_data.php";
    
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false;
    
    //var users = [String]()
    
    //var conCellModels = [ContactModel]()        // model
    
    var contactCards : [ContactCard]!
    
    var filteredContacts = [ContactCard]()
    var filteredUserSectionTitles = [String]()
    
    //going to try a dictionary of filtered items
    
    var filteredDictionary = [String: [ContactCard]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pullContacts()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        buildContacts()
        }
    
    func attemptFetch(){
        let fetchRequest: NSFetchRequest<Thumbnail> = Thumbnail.fetchRequest()
        let dataSort = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [dataSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.controller = controller
        do{
            try controller.performFetch()
        }catch{
            let error = error as? NSError
            print("\(error)")
        }
        
    }
    
    func buildContacts(){
        
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                if self.filesToDownload > 0{
                    self.createAlert(title: "Downloading Images", message: "There are \(self.filesToDownload) left to download, please be patient")
                }
            }
            tableView.reloadData()
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoVC"{
            
            if let infoVC = segue.destination as? InfoVC{
                if let contact = sender as? ContactCard {
                    infoVC.contact = contact;
                    infoVC.currentUser = currentUser
                    infoVC.contactCards = contactCards
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
    func createAlert (title: String!, message: String!){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

