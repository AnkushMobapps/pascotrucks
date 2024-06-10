//
//  MyOrderVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 20/05/24.
//new code add

import UIKit
import SDWebImage

class MyOrderVC: UIViewController {

@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var topBar: TitleBar!
@IBOutlet weak var segmentControl: UISegmentedControl!
//var sagementcontrolStr:String?
var vehicleapproved:vehicleApprove?
var approvalKey:String?
var driverCountNotiModel:CountNotificationModel?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getProfileDataApi()
        topBar.notificationButton = {
            let vc = self.storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
       // sagementcontrolStr = "First"
        segmentControl.selectedSegmentIndex = 0
        
       
         
         let nib1 = UINib(nibName: "BidingStatusCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: "bidingOrderCell")
         
         let nib2 = UINib(nibName: "CurrentOrderCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "currentOrdCell")
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
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
            print("biding table is ready to show")
            tableView.reloadData()
        }
        else{
            print("order table is ready to show")
            tableView.reloadData()
        }
        
    }
    
    
    
}

extension MyOrderVC{
    
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
                if let url = URL(string: image_Url + img) {
                    self.topBar.driverImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
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
extension MyOrderVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0{
            return 40
        }
        else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentControl.selectedSegmentIndex == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "bidingOrderCell", for: indexPath) as! BidingStatusCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentOrdCell", for: indexPath) as! CurrentOrderCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            return cell
        }
    }
    
    
}
