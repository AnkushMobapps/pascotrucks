//
//  NeedHelpVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 21/06/24.
//

import UIKit

class NeedHelpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBAction func driverhelpBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DriverEmergencyVC") as! DriverEmergencyVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func emergencyCallBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmergencyContactsVC") as! EmergencyContactsVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
