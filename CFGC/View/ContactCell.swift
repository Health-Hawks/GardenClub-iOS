//
//  ContactCell.swift
//  CFGC
//
//  Created by Cory on 2/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit
import CoreData

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
        
        let objectData = UserDefaults.standard.object(forKey: imageName)
        if objectData != nil {
            //print("Found image for ContactVC at \(imageName)")
            let imageData = objectData as! NSData
            let image = UIImage(data: imageData as Data)
            contactImg.image = image
            contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        }
        else{
            let image = UIImage(named: "CarolinaYellowJessamineMed1")
            
            contactImg.image = image
            contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
            //print("objectData nil at\(imageName)")
        }
        
        
        //if(image != nil){
            //print("Image found!")
            //contactImg.image = image
            //contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
            
            //print("Image found!")
            //pullPhotoFromURL(imageID: contactCard.PhotoId)
            //pullPhotoFromURL(imageID: imageName)
            //pullSimpleFromURL(photoID: imageName)
            //contactImg.image = image
            //contactImg.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
                
                
        //}
        //{ //Replace dequeued cell with stock flower image
            //print("Clear")
        
        //}

    }
    
    func pullPhotoFromURL(imageID: String){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://capefeargardenclub.org/cfgcTestingJSON/get_image_post.php")! as URL)

        let imageURL = imageID+".jpg"
        print(imageURL)
        DispatchQueue.main.async {
            request.httpMethod = "POST"
            
            let postString = "imageURL=\(imageURL)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if error != nil{
                    print("error =\(error)")
                    return
                }
                
                print("response =\(response)")
                
                //let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print("responseString = \(responseString)")
                do{
                    let data = try Data(contentsOf: request.url!)
                    //group.leave()
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.contactImg.image = UIImage(data: data)
                        print(request.url?.absoluteString)
                        print("Success!")
                    }
                }
                catch{
                    print("failed to grab image")
                }
                
            }
            task.resume()
        }
    }
    
    func pullSimpleFromURL(photoID: String){
        print("starting image pull")
       
        let urlString = "http://capefeargardenclub.org/cfgcTestingJSON/images_Testing/images/" + photoID + ".jpg"
        let url = URL(string: urlString)
        print(photoID+".jpg")
        
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.sync {
                    self.contactImg.image = UIImage(data: data)
                }
            }catch{
                print("failed")
            }
            
        }
    }
}
