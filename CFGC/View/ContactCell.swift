//
//  ContactCell.swift
//  CFGC
//
//  Created by Cory on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var contactImg: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var mbrStat: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    /**
    
    func updateUI(contactModel: ContactModel){
        contactName.text = contactModel.firstName + " " + contactModel.lastName
        mbrStat.text = contactModel.mbrStat
    }
    */
    
    func updateUI(contactCard: ContactCard){
        contactName.text = contactCard.FirstName + " " + contactCard.LastName;
        mbrStat.text = contactCard.MbrStatus;
        let imageName = contactCard.PhotoId
        let image = UIImage(named: imageName)
        if(image != nil){
            //print("Image found!")
            contactImg.image = image
            contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
                
                
        }
        else{ //Replace dequeued cell with stock flower image
            //print("Clear")
            let image = UIImage(named: "CarolinaYellowJessamineMed1")

            contactImg.image = image
            /*
            
            contactImg.image = image
            contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
             */
        }
    }
}
