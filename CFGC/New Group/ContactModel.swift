//
//  ContactModel.swift
//  CFGC
//
//  Created by Cory on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation

class ContactModel {
    private var _imageURL: String!
    private var _contactName: String!
    private var _contactMbrStat: String!
    
    var imageURL: String{
        return _imageURL
    }
    
    var contactName: String {
        return _contactName
    }
    
    var contactMbrStat: String{
        return _contactMbrStat
    }
    
    init(imageURL: String, contactName: String, contactMbrStat: String){
        _imageURL = imageURL
        _contactName = contactName
        _contactMbrStat = contactMbrStat
    }
}
