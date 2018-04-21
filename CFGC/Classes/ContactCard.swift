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
    private var _CityAndState: String!          //May want to change this in the future
    //private var _City: String!
    //private var _State: String!
    private var _ZipCode: String!
    private var _PrimaryContactNo: String!
    private var _SecondaryContactNo: String!
    private var _ContactEmail: String!
    
    //new variables:
    private var _WorkNum: String!
    private var _Officers: String!
    private var _Committee: String!
    private var _CommitteeTitle: String!
    private var _AzaleaGardenTourCommittees: String!
    private var _AzaleaGardenTourCommitteesTitles: String!
    private var _BiographicalInfo: String!
    
    /* No longer relevant data
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
     //private var _TypeofPrimaryContactNo: String!
     //private var _TypeofSecondaryContactNo: String!
     
     */
    
    
    var UserID: String {
        return _UserID
    }
    var PhotoId: String {
        return _PhotoID
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
    
    var CityAndState: String{ //new variable
        return _CityAndState
    }
    
    /*
    var City: String {
        return _City
    }
    var State: String {
        return _State
    }
    */
    
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
    
    //New Variables
    var Officers: String { //change made from officer to officers
        return _Officers
    }
    var WorkNum: String{
        return _WorkNum
    }
    var Committee: String{
        return _Committee
    }
    var CommitteeTitle: String{
        return _CommitteeTitle
    }
    var AzaleaGardenTourCommittees: String{
        return _AzaleaGardenTourCommittees
    }
    var AzaleaGardenTourCommitteesTitles: String{
        return _AzaleaGardenTourCommitteesTitles
    }
    var BiographicalInfo: String {
        return _BiographicalInfo
    }
    
    func setFirstName(fName: String){
        _FirstName = fName
    }
    
    func setLastName(lstName: String){
        _LastName = lstName
    }
    
    func setMbrStatus(mStatus: String){
        _MbrStatus = mStatus
    }
    
    func setYearTA(yearTA: String){
        _YearTurnedActive = yearTA
    }
    
    func setAddress(address: String){
        _StreetAddress = address
    }
    
    func setCityAndState(city_state: String){
        _CityAndState = city_state
    }
    
    func setZipCode(zipCode: String){
        _ZipCode = zipCode
    }
    
    func setSpouse(newSpouse: String){
        _Spouse = newSpouse
    }
    
    func setContactEmail(newEmail: String){
        _ContactEmail = newEmail
    }
    
    func setPrimaryPhone(primPhone: String) {
        _PrimaryContactNo = primPhone
    }
    
    func setSecondaryPhone(secPhone: String){
        _SecondaryContactNo = secPhone
    }
    
    func setBiographicalInfo(newBio: String){
        _BiographicalInfo = newBio
    }
    
    /* Old variable retrieval code
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
    var TypeofPrimaryContactNo: String {
        return _TypeofPrimaryContactNo
    }
    var TypeofSecondaryContactNo: String {
        return _TypeofSecondaryContactNo
    }
    */
    
    /*
    init(PhotoID: String, UserID: String, MbrStatus: String, YearTurnedActive: String, LastName: String, FirstName: String, Spouse: String, StreetAddress: String, City: String, State: String, ZipCode: String, PrimaryContactNo: String, SecondaryContactNo: String?, ContactEmail: String?, TypeofPrimaryContactNo: String?, TypeofSecondaryContactNo: String?, Officer: String?, OfficerTitle: String?, ExcecutiveBdMbrship: String?, CurrentCmteAssignment1: String?, CmteAssign1Chair: String?, CmteAssign1CoChair: String?, CurrentCmteAssignment2: String?, CmteAssign2Chair: String?, CmteAssign2CoChair: String?, CurrentCmteAssignment3: String?, CmteAssign3Chair: String?, CmteAssign3CoChair: String?, BiographicalInfo: String?) {
        */
    init(PhotoID: String?, UserID: String, MbrStatus: String?, YearTurnedActive: String?, LastName: String?, FirstName: String?, Spouse: String?, StreetAddress: String?, CityAndState: String?, ZipCode: String?, PrimaryContactNo: String?, SecondaryContactNo: String?, ContactEmail: String?, Officers: String?, WorkNum: String?, Committee: String?, CommitteeTitle: String?, AzaleaGardenTourCommittees: String?, AzaleaGardenTourCommitteesTitles: String?, BiographicalInfo: String?) {
        
        
        if PhotoID == nil{
            _PhotoID = ""
        }
        else {
            _PhotoID = PhotoID
        }
        if ContactEmail == nil{
            _ContactEmail = ""
        }
        else {
            _ContactEmail = ContactEmail
        }
        if Spouse == nil{
            _Spouse = ""
        }
        else {
            _Spouse = Spouse
        }
        if StreetAddress == nil{
            _StreetAddress = ""
        }
        else {
            _StreetAddress = StreetAddress
        }
        if CityAndState == nil{
            _CityAndState = ""
        }
        else {
            _CityAndState = CityAndState
        }
        if ZipCode == nil{
            _ZipCode = ""
        }
        else {
            _ZipCode = ZipCode
        }
        if PrimaryContactNo == nil{
            _PrimaryContactNo = ""
        }
        else {
            _PrimaryContactNo = PrimaryContactNo
        }
        if SecondaryContactNo == nil{
            _SecondaryContactNo = ""
        }
        else {
            _SecondaryContactNo = SecondaryContactNo
        }
        if Officers == nil{
            _Officers = ""
        }
        else {
            _Officers = Officers
        }
        if Committee == nil{
            _Committee = ""
        }
        else{
            _Committee = Committee
        }
        if WorkNum == nil {
            _WorkNum = ""
        }
        else{
            _WorkNum = WorkNum
        }
        if CommitteeTitle == nil{
            _CommitteeTitle = ""
        }
        else{
            _CommitteeTitle = CommitteeTitle
        }
        if AzaleaGardenTourCommittees == nil{
            _AzaleaGardenTourCommittees = ""
        }
        else {
            _AzaleaGardenTourCommittees = AzaleaGardenTourCommittees
        }
        if AzaleaGardenTourCommitteesTitles == nil{
            _AzaleaGardenTourCommitteesTitles = ""
        }
        else {
            _AzaleaGardenTourCommitteesTitles = AzaleaGardenTourCommitteesTitles
        }
        if BiographicalInfo == nil{
            _BiographicalInfo = ""
        }
        else {
            _BiographicalInfo = BiographicalInfo
        }
        
        _UserID = UserID;
        _MbrStatus = MbrStatus;
        _YearTurnedActive = YearTurnedActive;
        _LastName = LastName;
        _FirstName = FirstName;
        
        //variables at risk of nil
        
        //_PhotoID = PhotoID
        //_Spouse = Spouse;           //may be null
        //_StreetAddress = StreetAddress;
        //_CityAndState = CityAndState;
        //_City = City;
        //_State = State;
        //_ZipCode = ZipCode; //may be null
        //_PrimaryContactNo = PrimaryContactNo; //may be null
        //_SecondaryContactNo = SecondaryContactNo; //may be null
        //_ContactEmail = ContactEmail;
        //_Officers = Officers; //may be null
        //_WorkNum = WorkNum //may be null
        //_Committee = Committee //may be null
        //_CommitteeTitle = CommitteeTitle //may be null
        //_AzaleaGardenTourCommittees = AzaleaGardenTourCommittees //may be null
        //_AzaleaGardenTourCommitteesTitles = AzaleaGardenTourCommitteesTitles //may be null
        //_BiographicalInfo = BiographicalInfo; //may be null
    }
}
