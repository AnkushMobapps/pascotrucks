//
//  CountryCodeVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 01/05/24.
//

import UIKit

protocol SelectListType:NSObject{
    func selectListType(dataName:String,dataId:Int)
}
class CountryCodeVC: UIViewController {
    var listType:String?
var selectListTypeDelegate:SelectListType?
var driverStatusListModel:DriverStatusListModel?
@IBOutlet weak var viewOverTable: UIView!
@IBOutlet weak var countryCodeTableView: UITableView!
var countryCodeArray = ["+91","+92","+91","+93","+94","+95","+266","+235"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 }
    
    override func viewWillAppear(_ animated: Bool) {
        if listType == "driverStatus" {
            driverStatusListMethod()
        }
       
    }

    @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
        
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource

extension CountryCodeVC:UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listType == "driverStatus" {
            return self.driverStatusListModel?.data?.count ?? 0
        }
        else{
            return countryCodeArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryCodeTableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryCodeCell
        cell.selectionStyle = .none
        cell.backgroundColor = .none
        if listType == "driverStatus" {
            cell.countryCodeTxt.text = self.driverStatusListModel?.data?[indexPath.row].status ?? ""
           
        }
        else{
            cell.countryCodeTxt.text = countryCodeArray[indexPath.row]
            
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listType == "driverStatus" {
            let selectString = self.driverStatusListModel?.data?[indexPath.row].status ?? ""
            print(selectString)
            let selctId = self.driverStatusListModel?.data?[indexPath.row].id ?? 0
            self.selectListTypeDelegate?.selectListType(dataName: selectString, dataId: selctId)
        }
        else{
            let selectString = countryCodeArray[indexPath.row]
           // print(selectString)
            let selctId = 0
            self.selectListTypeDelegate?.selectListType(dataName: selectString, dataId: selctId)
        }
       
        self.dismiss(animated: true)
    }
    
    
    
    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    // MARK: - Api
    func driverStatusListMethod(){
        let param = [String:Any]()
        DriverOrderViewModel.driverStatusListApi(viewController: self, parameters: param as NSDictionary){
            response in
            self.driverStatusListModel = response
            self.countryCodeTableView.reloadData()
        }
    }
    
    
}



