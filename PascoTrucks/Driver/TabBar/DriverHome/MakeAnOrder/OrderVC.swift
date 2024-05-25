//
//  OrderVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 19/04/24.
//

import UIKit

class OrderVC: UIViewController {

    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var topBarView: TitleBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptView.layer.borderWidth = 0
        receiptView.layer.shadowColor = UIColor.black.cgColor
        receiptView.layer.shadowOffset = CGSize(width: 0, height: 0)
        receiptView.layer.shadowRadius = 2
        receiptView.layer.shadowOpacity = 0.3
        receiptView.layer.masksToBounds = false
       
    }

    @IBAction func confirmOrdBtnPres(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CurrentLocationOfOrderVC") as! CurrentLocationOfOrderVC
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
}
