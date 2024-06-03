//
//  ClientWalletVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 30/05/24.
//

import UIKit

class ClientWalletVC: UIViewController {
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.isHidden = true
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.black
                ]
                
                let selectedTextAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.white
                ]
                
                segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
            
        
    }
    
    
    @IBAction func sagementContolTapped(_ sender: UISegmentedControl) {
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cutBtnTapped(_ sender: UIButton) {
        popUpView.isHidden = true
    }
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        popUpView.isHidden = true
    }
    @IBAction func addBtnTapped(_ sender: UIButton) {
        popUpView.isHidden = false
    }
}
