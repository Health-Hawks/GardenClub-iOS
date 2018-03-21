//
//  BiographicalVC.swift
//  CFGC
//
//  Created by Cory on 3/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import UIKit

class BiographicalVC: UIViewController {
    
    var contactCard: ContactCard!
    
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var biographicalLbl: UILabel!
    
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    @IBOutlet weak var returnBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        buildBiographicalView()
    }

    func buildBiographicalView(){
        
        returnBtn.title = contactCard.FirstName + " " + contactCard.LastName
        yearLbl.text = contactCard.YearTurnedActive
        biographicalLbl.text = contactCard.BiographicalInfo
    }
    @IBAction func returnBtnPressed(_ sender: UIBarButtonItem){
        performSegue(withIdentifier: "InfoVC", sender: contactCard)
    }
    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer){
        if gestureRecognizer.state == .ended{
            performSegue(withIdentifier: "InfoVC", sender: contactCard)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoVC"{
            
            if let infoVC = segue.destination as? InfoVC{
                if let contact = sender as? ContactCard {
                    infoVC.contact = contact;
                }
            }
        }
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
