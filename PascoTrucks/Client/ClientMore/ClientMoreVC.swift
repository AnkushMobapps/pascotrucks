//
//  ClientMoreVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 27/05/24.
//

import UIKit

class ClientMoreVC: UIViewController {

    @IBOutlet weak var clientTopBar: TitleBar!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func myWalletBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ClientWalletVC") as! ClientWalletVC
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func pascoRewardsBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func contactUsBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ContactUsVC") as! ContactUsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func term_ConditionBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "Terms_Conditions") as! Terms_Conditions
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func privacyPolicyBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notesReminderBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNotesVC") as! AddNotesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func shareAppBtnTapped(_ sender: UIButton) {
    }
    @IBAction func languageBtnTapped(_ sender: UIButton) {
    }
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
    }
    
}
