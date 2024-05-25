//
//  DropDownListVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 25/04/24.
//

import UIKit

protocol selectList: NSObject {
    func selcetrow(rowid:String, typeID:Int?)
}
class DropDownListVC: UIViewController {
    var selectrowdelegate: selectList?
    @IBOutlet weak var viewOverMyListTable: UIView!
    @IBOutlet weak var myListTable: UITableView!
    
    var languageArray = ["Hindi","English","Arabic","Persian","French"]
   // var transporterArray = ["Hindi","English","Arabic","Persian","French"]
    //var vehicleArray = ["Truck","Jeep","Tractor","Cab","Cycle"]
   // var countryArray = ["India","USA","UAE","France","Itly"]
    //var cityArray = ["Delhi","Noida","LosAngles"]
    
    var listType:String!
   // var viaLoginStr:String!
    var transporterListModel: TransporterModel?
    var vehicleListModel:VehicleModel?
    var countryListModel:CountryListModel?
    var cityListModel:CityListModel?
    var typeSelected_ID:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if listType == "Transporter" {
            transporterApiMetnod()
         }
        else if listType == "VehicleType"{
           vehicleListApiMetnod()
        }

        else
        { }
    }
    
    @IBAction func tapGuestureBtnClick(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }

}

// MARK: - UITableViewDelegate,UITableViewDataSource

extension DropDownListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if listType == "Language" {
                return languageArray.count
            }
            else if listType == "Transporter"{
                return self.transporterListModel?.data?.count ?? 0
            }
            else if listType == "VehicleType"{
                return self.vehicleListModel?.data?.count ?? 0
            }
          else {
              return languageArray.count
            }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myListTable.dequeueReusableCell(withIdentifier: "listCell") as! DropDownListCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            if listType == "Language" {
                cell.data.text = languageArray[indexPath.row]
            }
            else if listType == "Transporter"{
                cell.data.text = self.transporterListModel?.data?[indexPath.row].shipmentname ?? ""
            }
            else if listType == "VehicleType"{
                cell.data.text = self.vehicleListModel?.data?[indexPath.row].vehiclename ?? ""
            }
          else{
            cell.data.text = languageArray[indexPath.row]
            }

            return cell
    
  }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if listType == "Language" {
                let selectString = languageArray[indexPath.row]
                print(selectString)
             self.selectrowdelegate?.selcetrow(rowid: selectString, typeID: 0)
                self.dismiss(animated: true)
            }
            else if listType == "Transporter"{
                let selectString = self.transporterListModel?.data?[indexPath.row].shipmentname ?? ""
                let selectID = self.transporterListModel?.data?[indexPath.row].id ?? 0
                print(selectID ?? 0)
                self.selectrowdelegate?.selcetrow(rowid: selectString, typeID: selectID)
                self.dismiss(animated: true)
            }
            else if listType == "VehicleType"{
                let selectString = self.vehicleListModel?.data?[indexPath.row].vehiclename ?? ""
                let vehicleId = self.vehicleListModel?.data?[indexPath.row].id ?? 0
                print(selectString)
                self.selectrowdelegate?.selcetrow(rowid: selectString, typeID: vehicleId)
                self.dismiss(animated: true)
            }
            

 }
   
}
extension DropDownListVC {
    
    func transporterApiMetnod(){
       var param = [String: Any]()
        param = [:]
        
        VehicleDetailsVM.TransporterListApi(viewcontroller: self, parameters: param as NSDictionary){
            (responseObject) in
            
            self.transporterListModel = responseObject
            
            self.myListTable.reloadData()
            
            print("success")
            
        }
    }
    
    func vehicleListApiMetnod(){
        let param = [ "shipment_type": typeSelected_ID ?? 0]
        print(param)
        VehicleDetailsVM.VehicleListApi(viewcontroller: self, parameters: param as NSDictionary){
            (responseObject) in
            print("Success")
            self.vehicleListModel = responseObject
            self.myListTable.reloadData()
        }
    }
    
//    func countryListApiMetnod(){
//       var param = [String: Any]()
//        param = [:]
//        
//        VehicleDetailsVM.CountryListApi(viewcontroller: self, parameters: param as NSDictionary){
//            (responseObject) in
//            
//            self.countryListModel = responseObject
//            
//            self.myListTable.reloadData()
//            
//            print("success")
//            
//        }
//    }
    
//    func cityListApiMetnod(){
//        // "country":
//      // var param = [String: Any]()
//       let param = ["country": typeSelected_ID ?? 0]
//        
//        VehicleDetailsVM.CityListApi(viewcontroller: self, parameters: param as NSDictionary){
//            (responseObject) in
//            
//            self.cityListModel = responseObject
//            
//            self.myListTable.reloadData()
//            
//            print("success")
//            
//        }
//    }
}
    

// MARK: - UIGestureRecognizerDelegate

extension DropDownListVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}


