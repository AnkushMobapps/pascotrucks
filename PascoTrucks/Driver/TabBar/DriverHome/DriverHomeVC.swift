//
//  DriverHomeVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 17/04/24.
//

import UIKit
import SDWebImage

class DriverHomeVC : UIViewController {
    
    @IBOutlet weak var topBarView: TitleBar!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    @IBOutlet weak var myTableView: UITableView!
   
    var imgArray = [#imageLiteral(resourceName: "TopCard"),#imageLiteral(resourceName: "TopCard"),#imageLiteral(resourceName: "TopCard")]
    var driverImgArray = [#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup")]
    var driverNameArray = ["Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq","Hamza Tariq"]
    var ratingImgArray = [#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill"),#imageLiteral(resourceName: "starfill")]
    
    var getVehicleDataModel:vehicleApprove?
   
    var getOrdReqModel:BookingRecordListModel?
    var driverCountNotiModel:CountNotificationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getOrdReqFromClient()
//        getProfileDataApi()
//        driverCountNotiApiCall()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkapprovalStatusApiCall()
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
        let tabCell = myTableView.dequeueReusableCell(withIdentifier: "tabCell") as! MyTableViewCell
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
        tabCell.ratingPoints.text = "4.9"
        tabCell.clientOrderId.text = self.getOrdReqModel?.data?[indexPath.row].booking_number ?? ""
        
        return tabCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "OrderVC") as! OrderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func getOrdReqFromClient(){
            let param = [String:Any]()
            DRiverHomeViewModel.getOrderRequestFromClient(viewController: self, parameters: param as NSDictionary){(response) in
                print("success")
                self.getOrdReqModel = response
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
    
    func getProfileDataApi(){
        let param = [String:Any]()
        ProfileViewModel.getProfileDetails(viewController: self, parameters: param as NSDictionary){responseObject in
            print("Success")
            print(responseObject)
            self.topBarView.driverName.text = responseObject.data?.full_name
            let img = responseObject.data?.image ?? ""
            if let url = URL(string: image_Url + img) {
                self.topBarView.driverImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
     
            }
        }
    }
    
    
    func driverCountNotiApiCall(){
        let param = [String:Any]()
        NotificationViewModel.countNotificationApi(viewController: self, parameters: param as NSDictionary ){(response) in
            print("success")
            self.driverCountNotiModel = response
            self.topBarView.countOfNotification.text = "\(self.driverCountNotiModel?.count ?? 0)"
        }
    }
    
    
    //check approval status Api
    func checkapprovalStatusApiCall(){
        let param = [String:Any]()
        print(param)
        VehicleDetailsVM.getVehicleDataApi(viewController: self, parameters:param as NSDictionary){(responseObject) in
            print("success")
            self.getVehicleDataModel = responseObject
            print(responseObject)
            let approval = self.getVehicleDataModel?.data?.approval_status
            //  let approval_key = UserDefaults.standard.value(forKey: "approve")
            if approval == "approve" {
                self.myTableView.isHidden = false
                self.getOrdReqFromClient()
                self.getProfileDataApi()
                self.driverCountNotiApiCall()
            }
            else
            {
                self.myTableView.isHidden = true
                CommonMethods.showAlertMessage(title: Constant.TITLE, message:"Not approved yet", view: self)
            }
        }
    }
    
    
    
    
    
    
}
  

