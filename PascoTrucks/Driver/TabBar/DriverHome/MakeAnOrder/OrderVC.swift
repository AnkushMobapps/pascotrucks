//
//  OrderVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 19/04/24.
//

import UIKit

class OrderVC: UIViewController{
    
    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var topBarView: TitleBar!
    
    @IBOutlet weak var endPoint: UILabel!
    @IBOutlet weak var startPoint: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var commisionPrice: UILabel!
    @IBOutlet weak var paymentStatus: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var bidPrice: UITextField!
    @IBOutlet weak var driverAvailability: UITextField!
    var myid:Int?
    var updateBookingBidsModel:UpdateBookingBidsModel?
    var confirmOrderModel:ConfirmOrderModel?
    
 override func viewDidLoad() {
        super.viewDidLoad()
        print(myid ?? 0)
       
        receiptView.layer.borderWidth = 0
        receiptView.layer.shadowColor = UIColor.black.cgColor
        receiptView.layer.shadowOffset = CGSize(width: 0, height: 0)
        receiptView.layer.shadowRadius = 2
        receiptView.layer.shadowOpacity = 0.3
        receiptView.layer.masksToBounds = false
        
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bidingOrderDetailsApiCall()
    }

    @IBAction func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func getTimeBtnClk(_ sender: UIButton) {
  
        
    }
    
    
    @IBAction func addAvailabilityBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerVC") as! DatePickerVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.selectedDateDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func stratPointAlertBtn(_ sender: UIButton) {
        CommonMethods.showAlertMessage(title: "Pickup Point", message: startPoint.text, view: self)
   }
    
    
    @IBAction func endPointAlertBtn(_ sender: UIButton) {
        CommonMethods.showAlertMessage(title: "Drop Point", message: endPoint.text, view: self)
        
    }
    
    
    

    @IBAction func confirmOrdBtnPres(_ sender: UIButton) {
        confirmOrderapi()
     }
}

extension OrderVC{
    func bidingOrderDetailsApiCall(){
        let param = ["id":myid]
        DRiverHomeViewModel.updatebookingbid(viewController: self, parameters: param as NSDictionary){
            response in
            self.updateBookingBidsModel = response
            
            self.startPoint.text = self.updateBookingBidsModel?.data?.pickup_location ?? ""
            print(self.startPoint.text ?? "")
            
            self.endPoint.text = self.updateBookingBidsModel?.data?.drop_location ?? ""
            self.paymentStatus.text = self.updateBookingBidsModel?.data?.payment_status ?? ""
            
            self.commisionPrice.text = "$\(String(self.updateBookingBidsModel?.data?.commision_price ?? 0.0))"
            
            self.totalAmount.text = "$\(String(self.updateBookingBidsModel?.data?.basicprice ?? 0.0))"
        }
    }
    
    func confirmOrderapi(){
        var param = [String : Any]()
        
         param = ["id":myid ?? 0, "availability_datetime":driverAvailability.text ?? "", "bid_price":bidPrice.text ?? ""]
        print(param)
        DRiverHomeViewModel.confirmOrderApi(viewController: self, parameters: param as NSDictionary){response in
            self.confirmOrderModel = response
            print("success")
            let vc = self.storyboard?.instantiateViewController(identifier: "MyTabBar") as! MyTabBar
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
  
}
extension OrderVC:selectedDate{
    func selDate(date: String?, timeTxt: String?) {
        self.driverAvailability.text = "\(date ?? "") \(timeTxt ?? "")"
    }
  
}
