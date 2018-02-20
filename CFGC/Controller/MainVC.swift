//
//  ViewController.swift
//  CFGC
//
//  Created by Cory Shrum on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var conCellModels = [ContactModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 = ContactModel(imageURL: "test", contactName: "Elizabeth White Baker", contactMbrStat: "Active")
        
        let p2 = ContactModel(imageURL: "test", contactName: "John Doe", contactMbrStat: "Active")
        
        let p3 = ContactModel(imageURL: "test", contactName: "Jane Doe", contactMbrStat: "Active")
        
        let p4 = ContactModel(imageURL: "test", contactName: "Mega Man", contactMbrStat: "Active")
        
        let p5 = ContactModel(imageURL: "test", contactName: "Mega Woman", contactMbrStat: "Active")
        
        conCellModels.append(p1)
        conCellModels.append(p2)
        conCellModels.append(p3)
        conCellModels.append(p4)
        conCellModels.append(p5)
        
        tableView.delegate = self
        tableView.dataSource = self
    }


    
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
}

