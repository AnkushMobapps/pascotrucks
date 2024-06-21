//
//  DriverEmergencyVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 18/06/24.
//

import UIKit

class DriverEmergencyVC: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var selectAllBtn: UIButton!
    
    var select = false
    var driver_Latitude:String?
    var driver_Longitude:String?
    var nearByDriverLM:NearByDriverModel?
    var currentlocation:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        driver_Latitude = UserDefaults.standard.string(forKey: "lat")
        driver_Longitude = UserDefaults.standard.string(forKey: "long")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nearByDriverListMethod()
    }
    
    @IBAction func selectAllBtnClk(_ sender: UIButton) {
        
        if selectAllBtn.isSelected == false{
            selectAllBtn.isSelected = true
            select = true
            selectAllBtn.setTitle("Undo", for: .selected)
            selectAllBtn.setTitleColor(UIColor.white, for: .selected)
            myTableView.reloadData()
        }
        else {
            selectAllBtn.isSelected = false
            select = false
            selectAllBtn.setTitle("Select All", for: .normal)
            selectAllBtn.setTitleColor(UIColor.white, for: .normal)
            myTableView.reloadData()
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - UITableViewDelegate, UITableViewDataSource

extension DriverEmergencyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nearByDriverLM?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "emergencyContactCell") as! DriverEmergencyCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = .none
        
        cell.driverName.text = self.nearByDriverLM?.data?[indexPath.row].user ?? ""
        print(cell.driverName.text ?? "")
       
        cell.checkImage.image = select == true ? #imageLiteral(resourceName: "greencheckbox") : #imageLiteral(resourceName: "sqaure")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.cellForRow(at: indexPath) as! DriverEmergencyCell
        let driverId = self.nearByDriverLM?.data?[indexPath.row].driverid ?? 0
        cell.checkImage.image = #imageLiteral(resourceName: "greencheckbox")
       
        reqSendToPerticularDriverApi(id: driverId)
    }
}


extension DriverEmergencyVC{

    //==== near by driver list ===
    func nearByDriverListMethod(){
        var param = [String:Any]()
        
        param = ["driver_latitude":self.driver_Latitude ?? "", "driver_longitude":self.driver_Longitude ?? ""]
        print(param)
        DRiverHomeViewModel.nearByDriverListApi(viewController: self, parameters: param as NSDictionary){
            response in
            self.nearByDriverLM = response
            print("success")
            self.myTableView.reloadData()
        }
    }
    //===perticularv diver reuest=====
    
    func reqSendToPerticularDriverApi(id:Int){
        var param = [String:Any]()
        param = ["driver_id":id,
                 "current_location":"B-36,59 METRO Station Noida"]
        DRiverHomeViewModel.helpReqToPerticularDriverApi(viewController: self, parameters: param as NSDictionary){ response in
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: response?.msg, view: self)
       }
    }
}

