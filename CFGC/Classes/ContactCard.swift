//
//  contactCard.swift
//  CFGC
//
//  Created by Cory on 3/1/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation

class ContactCard {
    
    private var _PhotoID: String!
    private var _UserID: String!
    private var _MbrStatus: String!
    private var _YearTurnedActive: String!
    private var _LastName: String!
    private var _FirstName: String!
    private var _Spouse: String!
    private var _StreetAddress: String!
    private var _City: String!
    private var _State: String!
    private var _ZipCode: String!
    private var _PrimaryContactNo: String!
    private var _SecondaryContactNo: String!
    private var _ContactEmail: String!
    private var _TypeofPrimaryContactNo: String!
    private var _TypeofSecondaryContactNo: String!
    private var _Officer: String!
    private var _OfficerTitle: String!
    private var _ExcecutiveBdMbrship: String!
    private var _CurrentCmteAssignment1: String!
    private var _CmteAssign1Chair: String!
    private var _CmteAssign1CoChair: String!
    private var _CurrentCmteAssignment2: String!
    private var _CmteAssign2Chair: String!
    private var _CmteAssign2CoChair: String!
    private var _CurrentCmteAssignment3: String!
    private var _CmteAssign3Chair: String!
    private var _CmteAssign3CoChair: String!
    private var _BiographicalInfo: String!
    
    var UserID: String {
        return _UserID
    }
    var MbrStatus: String {
        return _MbrStatus
    }
    var YearTurnedActive: String {
        return _YearTurnedActive
    }
    var LastName: String {
        return _LastName
    }
    var FirstName: String {
        return _FirstName
    }
    var Spouse: String {
        return _Spouse
    }
    var StreetAddress: String {
        return _StreetAddress
    }
    var City: String {
        return _City
    }
    var State: String {
        return _State
    }
    var ZipCode: String {
        return _ZipCode
    }
    var PrimaryContactNo: String {
        return _PrimaryContactNo
    }
    var SecondaryContactNo: String {
        return _SecondaryContactNo
    }
    var ContactEmail: String {
        return _ContactEmail
    }
    var TypeofPrimaryContactNo: String {
        return _TypeofPrimaryContactNo
    }
    var TypeofSecondaryContactNo: String {
        return _TypeofSecondaryContactNo
    }
    var Officer: String {
        return _Officer
    }
    var OfficerTitle: String {
        return _OfficerTitle
    }
    var ExecutiveBdMbrship: String {
        return _ExcecutiveBdMbrship
    }
    var CurrentCmteAssignment1: String {
        return _CurrentCmteAssignment1
    }
    var CmteAssign1Chair: String {
        return _CmteAssign1Chair
    }
    var CmteAssign1CoChair: String {
        return _CmteAssign1CoChair
    }
    var CurrentCmteAssignment2: String {
        return _CurrentCmteAssignment2
    }
    var CmteAssign2Chair: String {
        return _CmteAssign2Chair
    }
    var CmteAssign2CoChair: String {
        return _CmteAssign2CoChair
    }
    var CurrentCmteAssignment3: String {
        return _CurrentCmteAssignment3
    }
    var CmteAssign3Chair: String {
        return _CmteAssign3Chair
    }
    var CmteAssign3CoChair: String {
        return _CmteAssign3CoChair
    }
    var BiographicalInfo: String {
        return _BiographicalInfo
    }
    
    init(PhotoID: String, UserID: String, MbrStatus: String, YearTurnedActive: String, LastName: String, FirstName: String, Spouse: String, StreetAddress: String, City: String, State: String, ZipCode: String, PrimaryContactNo: String, SecondaryContactNo: String?, ContactEmail: String?, TypeofPrimaryContactNo: String?, TypeofSecondaryContactNo: String?, Officer: String?, OfficerTitle: String?, ExcecutiveBdMbrship: String?, CurrentCmteAssignment1: String?, CmteAssign1Chair: String?, CmteAssign1CoChair: String?, CurrentCmteAssignment2: String?, CmteAssign2Chair: String?, CmteAssign2CoChair: String?, CurrentCmteAssignment3: String?, CmteAssign3Chair: String?, CmteAssign3CoChair: String?, BiographicalInfo: String?) {
        
        _PhotoID = PhotoID;
        _UserID = UserID;
        _MbrStatus = MbrStatus;
        _YearTurnedActive = YearTurnedActive;
        _LastName = LastName;
        _FirstName = FirstName;
        _Spouse = Spouse;           //may be null
        _StreetAddress = StreetAddress;
        _City = City;
        _State = State;
        _ZipCode = ZipCode;
        _PrimaryContactNo = PrimaryContactNo;
        _SecondaryContactNo = SecondaryContactNo; //may be null
        _ContactEmail = ContactEmail; //may be null
        _TypeofPrimaryContactNo = TypeofPrimaryContactNo; //may be null
        _TypeofSecondaryContactNo = TypeofSecondaryContactNo; //may be null
        _Officer = Officer; //may be null
        _OfficerTitle = OfficerTitle; //may be null
        _ExcecutiveBdMbrship = ExcecutiveBdMbrship; //may be null
        _CurrentCmteAssignment1 = CurrentCmteAssignment1; //may be null
        _CmteAssign1Chair = CmteAssign1Chair; //may be null
        _CmteAssign1CoChair = CmteAssign1CoChair; //may be null
        _CurrentCmteAssignment2 = CurrentCmteAssignment2; //may be null
        _CmteAssign2Chair = CmteAssign2Chair; //may be null
        _CmteAssign2CoChair = CmteAssign2CoChair; //may be null
        _CurrentCmteAssignment3 = CurrentCmteAssignment3; //may be null
        _CmteAssign3Chair = CmteAssign3Chair; //may be null
        _CmteAssign3CoChair = CmteAssign3CoChair; //may be null
        _BiographicalInfo = BiographicalInfo; //may be null
    }
}
