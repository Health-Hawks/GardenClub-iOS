//
//  ViewController.swift
//  CFGC
//
//  Created by Cory Shrum on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class ContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var userDictionary = [String: [String]]()
    var userSectionTitles = [String]()
    var users = [String]()
    
    var contactUsed = [Bool]()
    
    var conCellModels = [ContactModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        for _ in 0...50{
            let p1 = ContactModel(imageURL: "test", firstName: "Elizabeth",lastName: "White Baker", mbrStat: "Active")
            
            conCellModels.append(p1)
        }
        **/
        
        let p1 = ContactModel(imageURL: "test", firstName: "Elizabeth",lastName: "White Baker", mbrStat: "Active")
        let p2 = ContactModel(imageURL: "test", firstName: "Cory",lastName: "Shrum", mbrStat: "Inactive")
        let p3 = ContactModel(imageURL: "test", firstName: "Test",lastName: "Test", mbrStat: "Active")
        let p4 = ContactModel(imageURL: "test", firstName: "John",lastName: "Doe", mbrStat: "Active")
        let p5 = ContactModel(imageURL: "test", firstName: "Jane",lastName: "Doe", mbrStat: "Active")

        conCellModels.append(p1)
        contactUsed.append(false)
        conCellModels.append(p2)
        contactUsed.append(false)
        conCellModels.append(p3)
        contactUsed.append(false)
        conCellModels.append(p4)
        contactUsed.append(false)
        conCellModels.append(p5)
        contactUsed.append(false)
        
        for user in conCellModels {
            let userKey = String(user.lastName.prefix(1))
            if var userValues = userDictionary[userKey] {
                userValues.append(user.lastName)
                userDictionary[userKey] = userValues
            } else {
                userDictionary[userKey] = [user.lastName]
            }
        }
        
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
        return userSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        let userKey = userSectionTitles[section]
        if let userValues = userDictionary[userKey] {
            return userValues.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 3
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell{
            
            let userKey = userSectionTitles[indexPath.section]
            if let userValues = userDictionary[userKey] {
                //cell.textLabel?.text = userValues[indexPath.row]
                var contactModel = conCellModels[0]
                var x = 0;
                for user in conCellModels{
                    
                    print("Checking \(user.firstName)")
                    if user.lastName == userValues[indexPath.row] /*&& !contactUsed[x]*/{
                        contactModel = conCellModels[x]
                        //contactUsed[x] = true;                        // BUG will only print correctly one time.
                        cell.updateUI(contactModel: contactModel)
                        return cell
                    }
                    
                    x = x+1;
                }
                
            }
        }
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return userSectionTitles
    }
 
}

