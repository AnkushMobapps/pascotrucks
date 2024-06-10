//
//  DriverNotesVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 06/06/24.
//

import UIKit

class DriverNotesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
