//
//  CurrentLocationOfOrderVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 23/04/24.
//

import UIKit

class CurrentLocationOfOrderVC: UIViewController {

    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var cursorView: UIView!
    @IBOutlet weak var topBarView: TitleBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        cursorView.layer.borderWidth = 0
        cursorView.layer.shadowColor = UIColor.black.cgColor
        cursorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cursorView.layer.shadowRadius = 2
        cursorView.layer.shadowOpacity = 0.3
        cursorView.layer.masksToBounds = false
    
        
        backBtnView.layer.borderWidth = 0
        backBtnView.layer.shadowColor = UIColor.black.cgColor
        backBtnView.layer.shadowOffset = CGSize(width: 0, height: 1)
        backBtnView.layer.shadowRadius = 2
        backBtnView.layer.shadowOpacity = 0.3
        backBtnView.layer.masksToBounds = false
        
        
        
        

}
    
    @IBAction func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func goForPickUpBtnPress(_ sender: UIButton) {
   
        let vc = self.storyboard?.instantiateViewController(identifier: "DiliverdVC") as! DiliverdVC
        self.navigationController?.pushViewController(vc, animated: true)
    
    
    }
    
}
