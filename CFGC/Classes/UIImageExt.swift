//
//  UIImageExt.swift
//  CFGC
//
//  Created by Cory on 4/25/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func load(image imageName: String) -> UIImage {
        // declare image location
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageName).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        
        // check if the image is stored already
        if FileManager.default.fileExists(atPath: imagePath),
            let imageData: Data = try? Data(contentsOf: imageUrl),
            let image: UIImage = UIImage(data: imageData, scale: UIScreen.main.scale) {
            return image
        }
        
        // image has not been created yet: create it, store it, return it
        let newImage: UIImage = self.pullSimpleFromURL(photoID: imageName)
        try? UIImagePNGRepresentation(newImage)?.write(to: imageUrl)
        return newImage
        
    }
    
    func pullSimpleFromURL(photoID: String)->UIImage{
        print("starting image pull")
        var imageFromDownload = UIImage(named: "CarolinaYellowJessamineMed1")
        let urlString = "http://capefeargardenclub.org/cfgcTestingJSON/images_Testing/images/" + photoID + ".png"
        let url = URL(string: urlString)
        print(photoID+".jpg")
        
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.sync {
                    imageFromDownload = UIImage(data: data)!
                }
            }catch{
                print("failed")
            }
            
        }
    return imageFromDownload!
    }
    
    
}
