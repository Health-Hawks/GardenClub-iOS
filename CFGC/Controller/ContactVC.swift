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
    //var users = [String]()
    
    var conCellModels = [ContactModel]()        // model
    
    var contactCards = [ContactCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "sqlData_1", ofType: "txt") //path to text file
        
        let fileMgr = FileManager.default
        
        if fileMgr.fileExists(atPath: path!){ //if file exists
            do{
                let fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8) // gets entire text document
                
                let readings = fullText.components(separatedBy: "\n"); //array of lines in text file
                
                for i in 0..<readings.count-1 {
                    
                    let contactData = readings[i].components(separatedBy: ",") //delineated by commas
                    
                    let c1 = ContactCard(PhotoID: contactData[0], UserID: contactData[1], MbrStatus: contactData[2], YearTurnedActive: contactData[3], LastName: contactData[4], FirstName: contactData[5], Spouse: contactData[6], StreetAddress: contactData[7], City: contactData[8], State: contactData[9], ZipCode: contactData[10], PrimaryContactNo: contactData[11], SecondaryContactNo: contactData[12], ContactEmail: contactData[13], TypeofPrimaryContactNo: contactData[14], TypeofSecondaryContactNo: contactData[15], Officer: contactData[16], OfficerTitle: contactData[17], ExcecutiveBdMbrship: contactData[18], CurrentCmteAssignment1: contactData[19], CmteAssign1Chair: contactData[20], CmteAssign1CoChair: contactData[21], CurrentCmteAssignment2: contactData[22], CmteAssign2Chair: contactData[23], CmteAssign2CoChair: contactData[24], CurrentCmteAssignment3: contactData[25], CmteAssign3Chair: contactData[26], CmteAssign3CoChair: contactData[27], BiographicalInfo: contactData[28])
                    
                    contactCards.append(c1); //append to array of contacts
                }
                
            }catch let error as NSError{
                print("Error \(error)")
            }
        }
        
        contactCards.sort { ($0.LastName.prefix(1) < $1.LastName.prefix(1)) } //sort array (Seems to be a bug here)
        
        for user in contactCards {
            let userKey = String(user.LastName.prefix(1))
            print(user.LastName)
            if var userValues = userDictionary[userKey] {
                userValues.append(user.LastName)
                userDictionary[userKey] = userValues
            } else {
                userDictionary[userKey] = [user.LastName]
            }
        }
        
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
                
                for x in 0...contactCards.count{
                    
                    if contactCards[x].LastName == userValues[indexPath.row]{
                        let contactCard = contactCards[x + indexPath.row]
                        cell.updateUI(contactCard: contactCard)
                        return cell
                    }
                    
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

