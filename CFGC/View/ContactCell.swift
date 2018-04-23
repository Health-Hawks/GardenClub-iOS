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
            //pullPhotoFromURL(imageID: contactCard.PhotoId)
            //if !pullSimpleFromURL(photoID: imageName){
              //  contactImg.image = image
            //}
            contactImg.image = image
            contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
                
                
        }
        else{ //Replace dequeued cell with stock flower image
            //print("Clear")
            let image = UIImage(named: "CarolinaYellowJessamineMed1")
            
            contactImg.image = image
            //pullPhotoFromURL(imageID: contactCard.PhotoId)
            
            //pullSimpleFromURL(photoID: contactCard.PhotoId)
            
            /*
            
            contactImg.image = image
            contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
             */
        }
    }
    
    func pullPhotoFromURL(imageID: String){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://www.capefeargardenclub.org/getImage.php")! as URL)

        let imageURL = "http://capefeargardenclub.ipower.com/mysqli_connect/images/" + imageID
        
        DispatchQueue.global().async {
            request.httpMethod = "POST"
            
            let postString = "photoID=\(imageURL)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if error != nil{
                    print("error =\(error)")
                    return
                }
                
                print("response =\(response)")
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString)")
                do{
                    let data = try Data(contentsOf: request.url!)
                    //group.leave()
                    DispatchQueue.global().sync {
                        self.contactImg.image = UIImage(data: data)
                    }
                }
                catch{
                    print("failed to grab image")
                }
                
            }
            task.resume()
        }
    }
    
    func pullSimpleFromURL(photoID: String)->Bool{
        print("starting image pull")
        let url = URL(string: "http://capefeargardenclub.ipower.com/" + photoID)!
        var didGrab = false
        var grabbed = false
        let group = DispatchGroup()
            do{
                group.enter()
                let data = try Data(contentsOf: url)
                self.contactImg.image = UIImage(data: data)
                if self.contactImg.image != nil {
                    didGrab = true
                }
                else{
                    didGrab = false
                }
                group.leave()
            } catch{
                didGrab = false
            }
        group.wait()
        group.notify(queue: .main){
            grabbed = didGrab
        }
        
        return grabbed
    }
}
