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
class DropDownListVC: UIViewController,UISearchBarDelegate {

   @IBOutlet weak var searchbar: UISearchBar!
   
    @IBOutlet weak var viewOverMyListTable: UIView!
    @IBOutlet weak var myListTable: UITableView!
    @IBOutlet weak var listTop: NSLayoutConstraint!
    
    var languageArray = ["Hindi","English","Arabic","Persian","French"]
    // var countryArray = ["India","USA","UAE","France","Itly"]
     var cityArray = ["Delhi","Noida","LosAngles"]
    
    var listType:String!
    var selectrowdelegate: selectList?
    var transporterListModel: TransporterModel?
    var vehicleListModel:VehicleModel?
   // var countryListModel:CountryListModel?
   // var cityListModel:CityListModel?
    var selectCityModel:SelectCityModel?
    
    var filteredList: [SelectCityModel_data] = []

   var typeSelected_ID:Int?
    
    var countryCode:String?
    var isSearch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.set(dialingPhoneCode, forKey: "countryCode")
        print(countryCode)
        self.searchbar.isHidden = true
        self.listTop.constant = 0
        
        if listType == "Transporter" {
            self.searchbar.isHidden = true
            self.listTop.constant = 0
            transporterApiMetnod()
         }
        else if listType == "VehicleType"{
            self.searchbar.isHidden = true
            self.listTop.constant = 0
           vehicleListApiMetnod()
        }
        else if listType == "City"{
            self.searchbar.isHidden = false
            self.listTop.constant = 50
            selectCityApiMetnod()
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
            if isSearch {
                return filteredList.count
            }
            else {
                return self.selectCityModel?.data?.count ?? 0
            }
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
              if isSearch {
                  cell.data.text = self.filteredList[indexPath.row].cityname
              }
              else{
                  cell.data.text = self.selectCityModel?.data?[indexPath.row].cityname
              }
            
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
                let selectID = self.transporterListModel?.data?[indexPath.row].shipmentid ?? 0
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
           else if listType == "City" {
               if isSearch {
                   let selectString = self.filteredList[indexPath.row].cityname ?? ""
                   print(selectString)
                   self.selectrowdelegate?.selcetrow(rowid: selectString, typeID: 0)
                   self.dismiss(animated: true)
               }
               else{
                   let selectString = self.selectCityModel?.data?[indexPath.row].cityname ?? ""
                   print(selectString)
                   self.selectrowdelegate?.selcetrow(rowid: selectString, typeID: 0)
                   self.dismiss(animated: true)
               }

           }

 }
   
}

extension DropDownListVC {
   // transporter list api
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
    
    // vehicle list api
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
    
    func selectCityApiMetnod(){
        // "country":
       let param = ["countrycode": countryCode]
        print(param)
        RegisterViewModel.selectCityApi(viewController: self, parameters: param as NSDictionary){
            response in
            print(response!)
            self.selectCityModel = response
            self.myListTable.reloadData()
            
        }
     
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchbar.text == ""
        {
            isSearch = false
            myListTable.reloadData()
        }
        else
        {
            filteredList = selectCityModel?.data?.filter { person in
                return person.cityname!.lowercased().contains(searchText.lowercased())
            } ?? filteredList
            isSearch = true
            myListTable.reloadData()
        }
    }
}
    

// MARK: - UIGestureRecognizerDelegate

extension DropDownListVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

/*
 func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if searchbar.text == ""
         {
             isSearch = false
             myTableView.reloadData()
         }
         else
         {
             filteredList = ExploreData?.data?.filter { person in
                 return person.first_name!.lowercased().contains(searchText.lowercased())
             } ?? filteredList
             isSearch = true
             myTableView.reloadData()
         }
     }
 
 
 
 func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.resignFirstResponder()
     }
 
 
 if isSearch {
             return filteredList.count
         }
         else {
             return ExploreData?.data?.count ?? 0
         }
 
 UISearchBarDelegate
 
 
         searchbar.delegate = self
         searchbar.returnKeyType = .done
         searchbar.barTintColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9019607843, alpha: 1)
         searchbar.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9019607843, alpha: 1)
         searchbar.isTranslucent = false
         UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9019607843, alpha: 1)
         searchbar.layer.borderWidth = 0
         searchbar.layer.borderColor = UIColor.clear.cgColor
 */

