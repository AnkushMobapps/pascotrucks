//
//  DriverBidingDetailsVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 04/06/24.
//

import UIKit
import SDWebImage

class DriverBidingDetailsVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var clientImg: UIImageView!
    
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var pickUp: UILabel!
    
    @IBOutlet weak var drop: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var orderId: UILabel!
    
    @IBOutlet weak var basicPrice: UILabel!
    
    @IBOutlet weak var bidPrice: UILabel!
    
    @IBOutlet weak var commission: UILabel!
    var id:Int?
    
    var driverPendingBidDM:DriverPendingBidDetailsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id ?? 0)
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false
       
    }
    override func viewWillAppear(_ animated: Bool) {
        driverPendingBidDetails()
    }
    

    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
     }
    

}


extension DriverBidingDetailsVC{
    
    //round to single digit after decimal
       func formatToSingleDecimalPlace(_ value: Double) -> String {
           let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 1
           formatter.minimumFractionDigits = 1
           formatter.roundingMode = .halfUp
           return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
       }
    
    func driverPendingBidDetails(){
        var param = [String:Any]()
        print(param)
        DriverOrderViewModel.driverPendingBisDetailsApi(viewController: self, parameters: param as NSDictionary){
            response in
            self.driverPendingBidDM = response
            
            let img = self.driverPendingBidDM?.data?.user_image ?? ""
            if let url = URL(string: image_Url + img){
                self.clientImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
            
            self.clientName.text = self.driverPendingBidDM?.data?.user ?? ""
            self.dateAndTime.text = self.driverPendingBidDM?.data?.created_at ?? ""
            self.orderId.text = self.driverPendingBidDM?.data?.booking_number ?? ""
            self.pickUp.text = self.driverPendingBidDM?.data?.pickup_location ?? ""
            self.drop.text = self.driverPendingBidDM?.data?.drop_location ?? ""
            
            let distance = self.driverPendingBidDM?.data?.total_distance ?? 0.0
            let formattedDistance = self.formatToSingleDecimalPlace(distance)
                    print(formattedDistance)  // Output: 3.1
                    
                    self.distance.text = "\(formattedDistance)km"
                    print(self.distance.text ?? "")
            
            self.basicPrice.text = "\(self.driverPendingBidDM?.data?.basicprice ?? 0.0)"
            
            self.bidPrice.text = "\(self.driverPendingBidDM?.data?.bid_price ?? 0.0)"
            
            self.commission.text = "\(self.driverPendingBidDM?.data?.commision_price ?? 0.0)"
            
        }
    }
}
/*
 let img = self.getOrdReqModel?.data?[indexPath.row].user_image ?? ""
 if let url = URL(string: image_Url + img){
     tabCell.clientImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
 }
 */
