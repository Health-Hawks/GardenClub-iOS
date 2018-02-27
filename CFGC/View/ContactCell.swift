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

    func updateUI(contactModel: ContactModel){
        contactName.text = contactModel.firstName + " " + contactModel.lastName
        mbrStat.text = contactModel.mbrStat
    }

}
