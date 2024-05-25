//
//  DiliverdVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 22/04/24.
//

import UIKit

class DiliverdVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitBtnPress(_ sender: UIButton) {
   let vc = self.storyboard?.instantiateViewController(identifier: "MyTabBar") as! MyTabBar
        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    

}
