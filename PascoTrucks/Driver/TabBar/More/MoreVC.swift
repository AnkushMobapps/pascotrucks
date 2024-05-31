//
//  MoreVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 19/04/24.
//

import UIKit
import SDWebImage

class MoreVC: UIViewController {

    
    @IBOutlet weak var topBar: TitleBar!
    var approvalKey:String?
    var driverCountNotiModel:CountNotificationModel?
    var vehicleapproved:vehicleApprove?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topBar.notificationButton = {
            let vc = self.storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
       checkapprovalStatusApiCall()
    }
    

    @IBAction func updateVehicleClk(_ sender: UIButton) {
        if self.approvalKey == "approve" {
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDataAndUpdateVC") as! VehicleDataAndUpdateVC
            self.navigationController?.pushViewController(vc1, animated: true)
        }
        else
        {
       CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Not approved yet !", view: self)
            
        }
        
    }
    
    
    
    @IBAction func myWalletClk(_ sender: UIButton) {
        if self.approvalKey == "approve" {
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "MyWalletVC") as! MyWalletVC
            self.navigationController?.pushViewController(vc2, animated: true)
        }
        else
        {
       CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Not approved yet !", view: self)
            
        }
     }
    
    
    
    
   
}


extension MoreVC{
    
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
                self.getProfileDataApi()
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
                self.topBar.address.text = responseObject.data?.current_city
                let img = responseObject.data?.image ?? ""
                if let url = URL(string: image_Url + img) {
                    self.topBar.driverImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
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
