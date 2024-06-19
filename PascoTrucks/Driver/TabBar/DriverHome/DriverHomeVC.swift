//
//  DriverHomeVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 17/04/24.
//

import UIKit
import SDWebImage

/*
 
 UserDefaults.standard.setValue(lat, forKey: "latitude")
 UserDefaults.standard.setValue(long, forKey: "longitude")
 
*/
class DriverHomeVC : UIViewController {
    @IBOutlet weak var noBidsComment: UILabel!
    @IBOutlet weak var topBarView: TitleBar!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    @IBOutlet weak var myTableView: UITableView!
    var city:String?
    var lat:String?
    var long:String?
    var currentLocation:String?
    var imgArray = [#imageLiteral(resourceName: "TopCard"),#imageLiteral(resourceName: "TopCard"),#imageLiteral(resourceName: "TopCard")]
    var driverImgArray = [#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup")]
    var driverNameArray = ["Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq"]
    var ratingImgArray = [#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill")]
    var deviceId:String?
    var updateLocationModel:UpdateDriverLocationModel?
    var getVehicleDataModel:vehicleApprove?
    var getOrdReqModel:BookingRecordListModel?
    var driverCountNotiModel:CountNotificationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let nib1 = UINib(nibName: "GetOrderFromClientCell", bundle: nil)
        myTableView.register(nib1, forCellReuseIdentifier: "getOrderFromClientCell")
        
        noBidsComment.isHidden = true
        self.topBarView.notificationButton = {
            let vc = self.storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getProfileDataApi()
        checkapprovalStatusApiCall()
        let Duty = UserDefaults.standard.integer(forKey: "Duty")
        if Duty == 1{
            topBarView.switchCondition.setOn(true, animated: false)
        }
        else{
            topBarView.switchCondition.setOn(false, animated: false)
        }
    }
    
    // MARK: - all button on horigontal stack view
    
    
    @IBAction func shareLocationBtnClk(_ sender: UIButton) {
       
    }
    
    
    @IBAction func supportBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "DriverSupportVC") as! DriverSupportVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func updateLocationBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "DriverupdateLocationVC") as! DriverupdateLocationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func emergencyBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "DriverEmergencyVC") as! DriverEmergencyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
}


// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension DriverHomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImgCell", for: indexPath) as! ImgCell
        cell.cellImage.image = imgArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = ImageCollectionView.bounds.width
        return CGSize(width: widht, height: 206)
    }
    
}

extension DriverHomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getOrdReqModel?.data?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabCell = myTableView.dequeueReusableCell(withIdentifier: "getOrderFromClientCell") as! GetOrderFromClientCell
      //  tabCell.clientImg.image = driverImgArray[indexPath.row]
        tabCell.selectionStyle = .none
        tabCell.backgroundColor = .none
        
        tabCell.clientName.text = self.getOrdReqModel?.data?[indexPath.row].user ?? ""
        print(tabCell.clientName.text ?? "")
        
        let img = self.getOrdReqModel?.data?[indexPath.row].user_image ?? ""
        if let url = URL(string: image_Url + img){
            tabCell.clientImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
        }
        
        tabCell.pickupPoint.text = self.getOrdReqModel?.data?[indexPath.row].pickup_location ?? ""
        
        tabCell.dropPoint.text = self.getOrdReqModel?.data?[indexPath.row].drop_location ?? ""
      
        tabCell.price.text = "$\(String(self.getOrdReqModel?.data?[indexPath.row].basicprice ?? 0.0))"
        
        tabCell.ratingPoints.text = "4.9"
        
        tabCell.clientOrderId.text = self.getOrdReqModel?.data?[indexPath.row].booking_number ?? ""
        
        tabCell.orderidBtn = {
            CommonMethods.showAlertMessage(title: "Order Id", message: tabCell.clientOrderId.text, view: self)
        }
        tabCell.dateAndTime.text = self.getOrdReqModel?.data?[indexPath.row].created_at
        return tabCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "OrderVC") as! OrderVC
        vc.myid = self.getOrdReqModel?.data?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func getOrdReqFromClient(){
            let param = [String:Any]()
            DRiverHomeViewModel.getOrderRequestFromClient(viewController: self, parameters: param as NSDictionary){(response) in
                print("success")
                self.getOrdReqModel = response
                if self.getOrdReqModel?.data?.count == 0{
                    self.noBidsComment.isHidden = false
                }
                else{
                    self.noBidsComment.isHidden = true
                }
                self.myTableView.reloadData()
            }
        }

}
extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 30
        let standardWidth: CGFloat = 55
  transform = CGAffineTransform(scaleX: standardHeight, y: standardWidth)
    }
}


// MARK: -  **********   API    ************

extension DriverHomeVC {
    
// Get profile Details ======== for driver name
    func getProfileDataApi(){
        let param = [String:Any]()
        ProfileViewModel.getProfileDetails(viewController: self, parameters: param as NSDictionary){responseObject in
            print("Success")
            print(responseObject)
            self.topBarView.driverName.text = responseObject.data?.full_name
            
            let img = responseObject.data?.image ?? ""
            
            if img != ""{
                if let url = URL(string: image_Url + img) {
                    self.topBarView.driverImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
                }
            }
            else{
                self.topBarView.driverImg.image =  #imageLiteral(resourceName: "profile")
            }
          
                if  UserDefaults.standard.string(forKey: "cityName") != nil {
                    print("through login")
                    print(UserDefaults.standard.string(forKey: "cityName"))
                    self.topBarView.address.text =  UserDefaults.standard.string(forKey: "cityName")
                  
                    self.city = UserDefaults.standard.string(forKey: "cityName")
                    
                    self.lat = UserDefaults.standard.string(forKey: "lat")
                    self.long = UserDefaults.standard.string(forKey: "long")
                    self.currentLocation = self.city
                    
                    self.updateDriverLocationApiCall()
                }
                else
                {
                    print("through registration")
                    self.topBarView.address.text = responseObject.data?.current_city
                }
//            }
        }
    }
    
// Driver Count Notification ========
    func driverCountNotiApiCall(){
        let param = [String:Any]()
        NotificationViewModel.countNotificationApi(viewController: self, parameters: param as NSDictionary ){(response) in
            print("success")
            self.driverCountNotiModel = response
            self.topBarView.countOfNotification.text = "\(self.driverCountNotiModel?.count ?? 0)"
        }
    }
    
// Check Driver Approval Status  ========
    func checkapprovalStatusApiCall(){
        let param = [String:Any]()
        print(param)
        VehicleDetailsVM.getVehicleDataApi(viewController: self, parameters:param as NSDictionary){(responseObject) in
            print("success")
            self.getVehicleDataModel = responseObject
            print(responseObject)
           let approval = self.getVehicleDataModel?.data?.approval_status
            print(approval ?? "")
           if approval == "approve" {
                self.myTableView.isHidden = false
                self.getOrdReqFromClient()
                self.driverCountNotiApiCall()
          
           }
            else
            {
                self.myTableView.isHidden = true
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: responseObject.msg ?? Constant.BLANK, view: self)
            }
        }
    }
   
    //update driver locat api
    func updateDriverLocationApiCall(){

      var param = [String:Any]()
        param = ["current_city":city ?? "", "current_location":currentLocation ?? "", "current_latitude":lat ?? "", "current_longitude":long ?? ""]
        print(param)
        DRiverHomeViewModel.updateDriverLocationApi(viewController: self, parameters: param as NSDictionary){ response in
            print("Success")
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: response?.msg, view: self)
            self.updateLocationModel = response
        }
    }

}

