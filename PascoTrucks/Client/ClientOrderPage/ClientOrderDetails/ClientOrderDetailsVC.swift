//
//  ClientOrderDetailsVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 16/05/24.
//

import UIKit

class ClientOrderDetailsVC: UIViewController {

    @IBOutlet weak var topBar: ClientTitleBar!
    @IBOutlet weak var userView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userView.layer.borderWidth = 0
        userView.layer.shadowColor = UIColor.black.cgColor
        userView.layer.shadowOffset = CGSize(width: 0, height: 0)
        userView.layer.shadowRadius = 2
        userView.layer.shadowOpacity = 0.3
        userView.layer.masksToBounds = false
       
    }
    

   

}
