//
//  InfoVC.swift
//  CFGC
//
//  Created by Cory on 2/26/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
    
    var contactModel: ContactModel!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var mbrStatLbl: UILabel!
    @IBOutlet weak var spouseLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var primaryConLbl: UILabel!
    @IBOutlet weak var secondaryConLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLbl.text = contactModel.firstName + " " + contactModel.lastName
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
