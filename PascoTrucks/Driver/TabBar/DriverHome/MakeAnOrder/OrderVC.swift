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
            
            let duration = self.updateBookingBidsModel?.data?.duration ?? 0
            let timeComponents = self.convertSecondsToTimeComponents(seconds: duration)
            print("Hours: \(timeComponents.hours), Minutes: \(timeComponents.minutes), Seconds: \(timeComponents.seconds)")
            let fullduration = "\(timeComponents.minutes) min, \(timeComponents.seconds) sec"
            self.totalTime.text = fullduration
            
            
             let distance = self.updateBookingBidsModel?.data?.total_distance ?? 0.0
////            let distance = 50000.00
//             let convertedDistance = self.convertDistanceToKilometersAndMeters(distanceInMeters: distance)
//            print("Distance: \(convertedDistance.kilometers) km \(convertedDistance.meters) m") // Output: "Distance: 0 km 245.0 m"
            
            // round to single digit example
                   
          let formattedDistance = self.formatToSingleDecimalPlace(distance)
          print(formattedDistance)  // Output: 3.1
          self.totalDistance.text = "\(formattedDistance)km"
          print(self.totalDistance.text ?? "")
            
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
extension OrderVC{
    
  //  min hrs sec conversion
    func convertSecondsToTimeComponents(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        return (hours, minutes, remainingSeconds)
    }
//   // km conversion
//    
//    func convertDistanceToKilometersAndMeters(distanceInMeters: Double) -> (kilometers: Int, meters: Double) {
//        // Calculate the total kilometers
//        let kilometers = Int(distanceInMeters / 1000)
//        
//        // Calculate the remaining meters
//        let remainingMeters = distanceInMeters.truncatingRemainder(dividingBy: 1000)
//        
//        return (kilometers, remainingMeters)
//    }
//   
    
    //round to single digit after decimal
       func formatToSingleDecimalPlace(_ value: Double) -> String {
           let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 1
           formatter.minimumFractionDigits = 1
           formatter.roundingMode = .halfUp
           return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
       }
}
