//
//  HistoryVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 24/04/24.
//

import UIKit
import SDWebImage

class HistoryVC: UIViewController {

@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var topBar: TitleBar!
@IBOutlet weak var segmentControl: UISegmentedControl!

var vehicleapproved:vehicleApprove?
var approvalKey:String?
var driverCountNotiModel:CountNotificationModel?
var completOrderModel:DriverShowCompleteOrderModel?
var cancelOrderModel:DriverShowCancelOrderModel?
    
 override func viewDidLoad() {
        super.viewDidLoad()
     
     topBar.notificationButton = {
          let vc = self.storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
          self.navigationController?.pushViewController(vc, animated: true)
     }
     // sagementcontrolStr = "First"
     segmentControl.selectedSegmentIndex = 0
     
    let nib1 = UINib(nibName: "DriverCompletedOrderCell", bundle: nil)
     tableView.register(nib1, forCellReuseIdentifier: "driverCompletedOrderCell")
     
     let nib2 = UINib(nibName: "DriverCancelOrderCell", bundle: nil)
     tableView.register(nib2, forCellReuseIdentifier: "cancelDriverorderCell")
     
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileDataApi()
        driverShowCompleteOrderApi()
        
        let Duty = UserDefaults.standard.integer(forKey: "Duty")
        if Duty == 1{
            topBar.switchCondition.setOn(true, animated: false)
        }
        else{
            topBar.switchCondition.setOn(false, animated: false)
        }
        checkapprovalStatusApiCall()
    }
    
    
    @IBAction func segmentBtnClk(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            print("completed table is ready to show")
            tableView.reloadData()
        }
        else{
            print("canceled table is ready to show")
            driverShowCancelOrderApi()
            tableView.reloadData()
        }
        
    }
    
    
   
    
    
}
extension HistoryVC{
    
    // Check Approval Status api ========
    func checkapprovalStatusApiCall(){
        let param = [String:Any]()
        print(param)
        VehicleDetailsVM.getVehicleDataApi(viewController: self, parameters:param as NSDictionary){(responseObject) in
            print("success")
            self.vehicleapproved = responseObject
            print(responseObject)
            self.approvalKey = self.vehicleapproved?.data?.approval_status
            if self.approvalKey == "approve" {
                //self.getProfileDataApi()
                self.driverCountNotiApiCall()
            }
            else
            {
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: responseObject.msg ?? Constant.BLANK, view: self)
                
            }
        }
    }
    
    // Get profile Details ========
    func getProfileDataApi(){
        let param = [String:Any]()
        ProfileViewModel.getProfileDetails(viewController: self, parameters: param as NSDictionary){responseObject in
            print("Success")
            print(responseObject)
            self.topBar.driverName.text = responseObject.data?.full_name
            let img = responseObject.data?.image ?? ""
            
            if img != ""{
                if let url = URL(string: image_Url + img) {
                    self.topBar.driverImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
                }
            }
            else{
                self.topBar.driverImg.image =  #imageLiteral(resourceName: "profile")
            }
            
            if  UserDefaults.standard.string(forKey: "driverCity") != nil {
                print("through login")
                self.topBar.address.text =  UserDefaults.standard.string(forKey: "driverCity")
            }
            else
            {
                print("through registration")
                self.topBar.address.text = responseObject.data?.current_city
            }
            
        }
    }
    
    // Driver Notification Count ========
    func driverCountNotiApiCall(){
        let param = [String:Any]()
        NotificationViewModel.countNotificationApi(viewController: self, parameters: param as NSDictionary ){(response) in
            print("success")
            self.driverCountNotiModel = response
            self.topBar.countOfNotification.text = "\(self.driverCountNotiModel?.count ?? 0)"
        }
    }
}

extension HistoryVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0{
            return self.completOrderModel?.data.count ?? 0
        }
        else{
            return self.cancelOrderModel?.data.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentControl.selectedSegmentIndex == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "driverCompletedOrderCell", for: indexPath) as! DriverCompletedOrderCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            cell.clientName.text = self.completOrderModel?.data[indexPath.row].user ?? ""
            cell.completetedAt.text = self.completOrderModel?.data[indexPath.row].availability_datetime ?? ""
            cell.orderIdTxt.text = self.completOrderModel?.data[indexPath.row].booking_number ?? ""
            cell.pickupTxt.text = self.completOrderModel?.data[indexPath.row].pickup_location ?? ""
            cell.dropTxt.text = self.completOrderModel?.data[indexPath.row].drop_location ?? ""
            cell.priceTxt.text = "\(self.completOrderModel?.data[indexPath.row].basicprice ?? 0.0)"
            return cell
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cancelDriverorderCell", for: indexPath) as! DriverCancelOrderCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            cell.canceledAt.text = self.cancelOrderModel?.data[indexPath.row].user ?? ""
            cell.pickupTxt.text = self.cancelOrderModel?.data[indexPath.row].pickup_location ?? ""
            cell.dropTxt.text = self.cancelOrderModel?.data[indexPath.row].drop_location ?? ""
            cell.canceledAt.text = self.cancelOrderModel?.data[indexPath.row].pickup_datetime ?? ""
            cell.orderIdTxt.text = self.cancelOrderModel?.data[indexPath.row].booking_number ?? ""
            cell.priceTxt.text = "\(self.completOrderModel?.data[indexPath.row].basicprice ?? 0.0)"
            return cell
        }
    }
    
    
}
extension HistoryVC{
    func driverShowCompleteOrderApi(){
        var param = [String:Any]()
        print(param)
        HistoryViewModel.completeOrderApi(viewController: self, parameters: param as NSDictionary){ response in
        self.completOrderModel = response
            print("success")
            self.tableView.reloadData()
            
        }
    }
    
    func driverShowCancelOrderApi(){
        var param = [String:Any]()
        print(param)
        HistoryViewModel.cancelOrderApi(viewController: self, parameters: param as NSDictionary){ response in
            self.cancelOrderModel = response
                print("success")
                self.tableView.reloadData()
                
            }
    }
    
}



