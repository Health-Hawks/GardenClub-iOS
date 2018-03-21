//
//  Background.swift
//  CFGC
//
//  Created by Cory on 3/20/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation

class Background {
    private var _login_url = "http://satoshi.cis.uncw.edu/~jbr5433/GardenClub/get_json_data.php";
    private var contactJsons = [contactJson]()
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
    
    
    struct contactJson: Decodable{
        let UserID: String
        let PhotoID: String
        let MbrStatus: String
        let YearTurnedActive: String
        let LastName: String
        let FirstName: String
        let Spouse: String
        let StreetAddress: String
        let City: String
        let State: String
        let ZipCode: String
        let PrimaryContactNo: String
        let SecondaryContactNo: String
        let ContactEmail: String
        let TypeofPrimaryContactNo: String
        let TypeofSecondaryContactNo: String
        let Officer: String
        let OfficerTitle: String
        let ExcecutiveBdMbrship: String
        let CurrentCmteAssignment1: String
        let CmteAssign1Chair: String
        let CmteAssign1CoChair: String
        let CurrentCmteAssignment2: String
        let CmteAssign2Chair: String
        let CmteAssign2CoChair: String
        let CurrentCmteAssignment3: String
        let CmteAssign3Chair: String
        let CmteAssign3CoChair: String
        let BiographicalInfo: String
        
    }
    
    func getJsonFromUrl(){
        
        guard let url = URL(string: _login_url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check err
            //check response status 200 OK
            
            if (err == nil){
                print("do stuff")
                
                guard let data = data else {return}
                
               // let dataAsString = String(data: data, encoding: .utf8)
                do{
                    self.contactJsons = try JSONDecoder().decode([contactJson].self, from: data)

                }catch let jsonerr{
                    print("Error with json parse", jsonerr)
                }
                
                //print(dataAsString)
            }
            
            
            }.resume()
        buildCards(contactJsons: contactJsons)
        
    }
    
    func buildCards(contactJsons: [contactJson]){
        for x in contactJsons{
            let c1 = ContactCard(PhotoID: x.PhotoID, UserID: x.UserID, MbrStatus: x.MbrStatus, YearTurnedActive: x.YearTurnedActive, LastName: x.LastName, FirstName: x.FirstName, Spouse: x.Spouse, StreetAddress: x.StreetAddress, City: x.City, State: x.State, ZipCode: x.ZipCode, PrimaryContactNo: x.PrimaryContactNo, SecondaryContactNo: x.SecondaryContactNo, ContactEmail: x.ContactEmail, TypeofPrimaryContactNo: x.TypeofPrimaryContactNo, TypeofSecondaryContactNo: x.TypeofSecondaryContactNo, Officer: x.Officer, OfficerTitle: x.OfficerTitle, ExcecutiveBdMbrship: x.ExcecutiveBdMbrship, CurrentCmteAssignment1: x.CurrentCmteAssignment1, CmteAssign1Chair: x.CmteAssign1Chair, CmteAssign1CoChair: x.CmteAssign1CoChair, CurrentCmteAssignment2: x.CurrentCmteAssignment2, CmteAssign2Chair: x.CmteAssign2Chair, CmteAssign2CoChair: x.CmteAssign2CoChair, CurrentCmteAssignment3: x.CurrentCmteAssignment3, CmteAssign3Chair: x.CmteAssign3Chair, CmteAssign3CoChair: x.CmteAssign3CoChair, BiographicalInfo: x.BiographicalInfo)
            _contactCards.append(c1); //append to array of contacts
        }
    }
}
