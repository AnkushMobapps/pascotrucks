//
//  DriverEmergencyVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 18/06/24.
//

import UIKit

class DriverEmergencyVC: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - UITableViewDelegate, UITableViewDataSource

extension DriverEmergencyVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "emergencyContactCell") as! DriverEmergencyCell
        cell.callingBtn = {
            print("hello shireen")
        }
    
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(identifier: "ConfirmOrderVC") as! ConfirmOrderVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}

 


