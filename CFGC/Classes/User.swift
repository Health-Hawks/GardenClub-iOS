//
//  currentUser.swift
//  CFGC
//
//  Created by Cory on 3/18/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation

class User{
    private var _userName: String!
    private var _password: String!
    
    
    init(userName: String, password: String) {
        _userName = userName;
        _password = password;
    }
    
    var password: String{
        return _password;
    }
    var userName: String{
        return _userName;
    }
    
}
