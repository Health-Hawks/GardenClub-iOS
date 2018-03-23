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
    private var _firstName: String!
    private var _lastName: String!
    private var _mbrStat: String!
    
    
    var imageURL: String{
        return _imageURL
    }
    
    var firstName: String {
        return _firstName
    }
    
    var lastName: String {
        return _lastName
    }
    
    var mbrStat: String{
        return _mbrStat
    }
    
    init(imageURL: String, firstName: String, lastName: String, mbrStat: String){
        _imageURL = imageURL
        _firstName = firstName
        _lastName = lastName
        _mbrStat = mbrStat
    }
}
