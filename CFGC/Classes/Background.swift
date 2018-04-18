//
//  Background.swift
//  CFGC
//
//  Created by Cory on 3/20/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation

class Background {
    private var _login_url = "http://capefeargardenclub.org/cfgcTestingJSON/more_json11.php";
    private var jsonDataSet : Root?
    private var _contactCards = [ContactCard]()
    
    
    private var _login: Bool!
    
    
    var contactCards: [ContactCard]{
        return _contactCards
    }
    
    init(login: Bool!){
        if(login){
            getJsonFromUrl()
        }
    }
    
    struct Root : Decodable{
        struct contactJson: Decodable{
            var ID: String?
            
            var PhotoID: String?
            
            var Status: String?
            
            var YearTA: String?
            var LastName: String?
            var FirstName: String?
            var Spouse: String?
            var StreetAddress: String?
            
            var CityAndState: String?
            
            
            var ZipCode: String?
            var PrimNum: String?
            var SecNum: String?
            
            var WorkNum: String? //new Variable
            
            var EmailAddress: String?
            
            //New Variables
            var Committee: String?
            var CommitteeTitle: String?
            var AzaleaGardenTourCommittees: String?
            var AzaleaGardenTourCommitteesTitles: String?
            var Officers: String?
            var BiographicalInfo: String?
        }
        let server_response : [contactJson]
    }
    
    
    
    func getJsonFromUrl(){
        //var retrieved = false;
        print("starting")
        guard let url = URL(string: _login_url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check err
            //check response status 200 OK
            print(response)
            if (err == nil){
                print("do stuff")
                guard let data = data else {return}
                do{
                    let myStructArray = try JSONDecoder().decode(Root.self, from: data)
                    //print(myStructArray.server_response)
                    self.jsonDataSet = myStructArray
                    self.buildCards(contactJsons: self.jsonDataSet!)
                    //retrieved = true
                    
                    print("true")
                }catch let jsonerr{
                    print("Error with json parse", jsonerr)
                }
            }
            else{
                print(err)
            }
            
            }.resume()
        
    }
    
    /*
     print("connected")
     self.buildCards(contactJsons: self.jsonDataSet!)
     for x in self.contactCards{
     print(x)
     }
    */
    
    func buildCards(contactJsons: Root){
        for x in contactJsons.server_response{
            let c1 = ContactCard(PhotoID: x.PhotoID, UserID: x.ID!, MbrStatus: x.Status!, YearTurnedActive: x.YearTA!, LastName: x.LastName, FirstName: x.FirstName!, Spouse: x.Spouse, StreetAddress: x.StreetAddress, CityAndState: x.CityAndState, ZipCode: x.ZipCode, PrimaryContactNo: x.PrimNum, SecondaryContactNo: x.SecNum, ContactEmail: x.EmailAddress, Officers: x.Officers, WorkNum: x.WorkNum, Committee: x.Committee, CommitteeTitle: x.CommitteeTitle, AzaleaGardenTourCommittees: x.AzaleaGardenTourCommittees, AzaleaGardenTourCommitteesTitles: x.AzaleaGardenTourCommitteesTitles, BiographicalInfo: x.BiographicalInfo)
            _contactCards.append(c1); //append to array of contacts
            
        }
    }
    /*
    func buildCards(contactJsons: [contactJson]){
        for x in contactJsons{
            let c1 = ContactCard(PhotoID: x.PhotoID, UserID: x.UserID, MbrStatus: x.MbrStatus, YearTurnedActive: x.YearTurnedActive, LastName: x.LastName, FirstName: x.FirstName, Spouse: x.Spouse, StreetAddress: x.StreetAddress, City: x.City, State: x.State, ZipCode: x.ZipCode, PrimaryContactNo: x.PrimaryContactNo, SecondaryContactNo: x.SecondaryContactNo, ContactEmail: x.ContactEmail, TypeofPrimaryContactNo: x.TypeofPrimaryContactNo, TypeofSecondaryContactNo: x.TypeofSecondaryContactNo, Officer: x.Officer, OfficerTitle: x.OfficerTitle, ExcecutiveBdMbrship: x.ExcecutiveBdMbrship, CurrentCmteAssignment1: x.CurrentCmteAssignment1, CmteAssign1Chair: x.CmteAssign1Chair, CmteAssign1CoChair: x.CmteAssign1CoChair, CurrentCmteAssignment2: x.CurrentCmteAssignment2, CmteAssign2Chair: x.CmteAssign2Chair, CmteAssign2CoChair: x.CmteAssign2CoChair, CurrentCmteAssignment3: x.CurrentCmteAssignment3, CmteAssign3Chair: x.CmteAssign3Chair, CmteAssign3CoChair: x.CmteAssign3CoChair, BiographicalInfo: x.BiographicalInfo)
            _contactCards.append(c1); //append to array of contacts
        }
    }
    */
    /*
     struct contactJson1 : Decodable {
     
     private enum CodingKeys : String, CodingKey {
     case UserID: "userID"
     case PhotoID: "photoID"
     case MbrStatus: "mbrStatus"
     case YearTurnedActive: "yearTurnedActive"
     case LastName: "lastName"
     case FirstName: "firstName"
     case Spouse: "spouse"
     case StreetAddress: "streetAddress"
     case City: "city"
     case State: "state"
     case ZipCode: "zipCode"
     case PrimaryContactNo: "primaryContactNo"
     case SecondaryContactNo: "secondaryContactNo"
     case ContactEmail: "contactEmail"
     case TypeofPrimaryContactNo: "typeOfPrimaryContactNo"
     case TypeofSecondaryContactNo: "typeOfSecondaryContactNo"
     case Officer: "officer"
     case OfficerTitle: "officerTitle"
     case ExcecutiveBdMbrship: "executiveBdMbrship"
     case CurrentCmteAssignment1: "currentCmteAssignment1"
     case CmteAssign1Chair: "cmteAssign1Chair"
     case CmteAssign1CoChair: "cmteAssign1CoChair"
     case CurrentCmteAssignment2: "currentCmteAssignment2"
     case CmteAssign2Chair: "cmteAssign2Chair"
     case CmteAssign2CoChair: "cmteAssign2CoChair"
     case CurrentCmteAssignment3: "currentCmteAssignment3"
     case CmteAssign3Chair: "cmteAssign3Chair"
     case CmteAssign3CoChair: "cmteAssign3CoChair"
     case BiographicalInfo: "biographicalInfo"
     }
     
     let UserID: String?
     let PhotoID: String?
     let MbrStatus: String?
     let YearTurnedActive: String?
     let LastName: String?
     let FirstName: String?
     let Spouse: String?
     let StreetAddress: String?
     let City: String?
     let State: String?
     let ZipCode: String?
     let PrimaryContactNo: String?
     let SecondaryContactNo: String?
     let ContactEmail: String?
     let TypeofPrimaryContactNo: String?
     let TypeofSecondaryContactNo: String?
     let Officer: String?
     let OfficerTitle: String?
     let ExcecutiveBdMbrship: String?
     let CurrentCmteAssignment1: String?
     let CmteAssign1Chair: String?
     let CmteAssign1CoChair: String?
     let CurrentCmteAssignment2: String?
     let CmteAssign2Chair: String?
     let CmteAssign2CoChair: String?
     let CurrentCmteAssignment3: String?
     let CmteAssign3Chair: String?
     let CmteAssign3CoChair: String?
     let BiographicalInfo: String?
     }
     */
    
}
