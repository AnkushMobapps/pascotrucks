//
//  AddNotesVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 30/05/24.
//

import UIKit

class AddNotesVC: UIViewController {
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var timeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateView.isHidden = true
        timeView.isHidden = true
    }
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
