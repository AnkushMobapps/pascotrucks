//
//  EmergencyContactsVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 20/06/24.
//

import UIKit

class EmergencyContactsVC: UIViewController {

  
    @IBOutlet weak var myTableView: UITableView!
    var emergContactLM:EmergencyContactListModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        emergContactListApi()
    }

    @IBAction func backBtnclk(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func driverContact(phoneNumber:String){
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
}



extension EmergencyContactsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emergContactLM?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "emrContactCell") as! EmergencyContactsCell
        cell.selectionStyle = .none
        cell.backgroundColor = .none
        cell.countryName.text = self.emergContactLM?.data?[indexPath.row].country ?? ""
        cell.emergencyNumber.text = self.emergContactLM?.data?[indexPath.row].emergencynum ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.cellForRow(at: indexPath) as! EmergencyContactsCell
        let phoneNo = cell.emergencyNumber.text
        driverContact(phoneNumber: phoneNo ?? "" )
        
    }
}
extension EmergencyContactsVC{
    func emergContactListApi(){
        var param = [String:Any]()
        DRiverHomeViewModel.EmergencyContactListApi(viewController: self, parameters: param as NSDictionary){ response in
            self.emergContactLM = response
            self.myTableView.reloadData()
            
        }
    }
}
//EmergencyContactListModel
