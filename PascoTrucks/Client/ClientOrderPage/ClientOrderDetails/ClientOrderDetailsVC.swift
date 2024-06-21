//
//  ClientOrderDetailsVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 16/05/24.
//

import UIKit
import SDWebImage

class ClientOrderDetailsVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var topBar: ClientTitleBar!
    @IBOutlet weak var orderIcLbl: UILabel!
    @IBOutlet weak var pickUpLocation: UILabel!
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var satusLbl: UILabel!
    
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    var name:String?
    var orderId:String?
    var picckupLocation:String?
    var dropLocation:String?
    var distance:String?
    var totalPrice:String?
    var dateTime:String?
    var bookId:Int?
    var orderDetails:OrderdetailsModel?
    var id:Int?
    var aasignBook:AssignBookingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userView.layer.borderWidth = 0
        userView.layer.shadowColor = UIColor.black.cgColor
        userView.layer.shadowOffset = CGSize(width: 0, height: 0)
        userView.layer.shadowRadius = 2
        userView.layer.shadowOpacity = 0.3
        userView.layer.masksToBounds = false
        print(distance ?? "")
        print(dateTime ?? "")
        print(totalPrice ?? "")
        
        
        
        self.nameLbl.text = name ?? ""
        self.orderIcLbl.text = orderId ?? ""
        self.totalPriceLbl.text = totalPrice ?? ""
        self.distanceLbl.text = distance ?? ""
        self.pickUpLocation.text = picckupLocation ?? ""
        self.dropLocationLbl.text = dropLocation ?? ""
        self.dateTimeLbl.text = dateTime ?? ""
        
        orderDetailsApi()
    
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated:  true)
    }
    
   

}

extension ClientOrderDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetails?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bidsDetailsTVC
        cell.nameLbl.text = self.orderDetails?.data?[indexPath.row].driver ?? ""
        cell.orderIdLbl.text = self.orderDetails?.data?[indexPath.row].booking_number ?? ""
        cell.pickupLocationLbl.text = self.orderDetails?.data?[indexPath.row].pickup_location ?? ""
        cell.dropLocationLbl.text = self.orderDetails?.data?[indexPath.row].drop_location ?? ""
       
        
        let img = self.orderDetails?.data?[indexPath.row].driver_image ?? ""
      
        if let url = URL(string: image_Url + img) {
            cell.profileImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            
        }
        
        let inputDateString = self.orderDetails?.data?[indexPath.row].pickup_datetime ?? ""

        // Step 1: Convert the input string to a Date object
        let inputDateFormatter = ISO8601DateFormatter()
        guard let date = inputDateFormatter.date(from: inputDateString) else {
            fatalError("Unable to parse date string")
        }
        
        // Step 2: Convert the Date object to the desired string format
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputDateFormatter.amSymbol = "AM"
        outputDateFormatter.pmSymbol = "PM"

        let outputDateString = outputDateFormatter.string(from: date)
        print(outputDateString)  // Output: 2024-06-21 05:14 PM
        
        cell.dateTimeLbl.text = outputDateString
        
        
        
        let Price = Double(self.orderDetails?.data?[indexPath.row].upfront_payment ?? 0.0)
         
          let formattedDistance = self.upfrontPrice(Price)
                   print(formattedDistance)  // Output: 3.1
                   
        cell.upfrontPaymentLbl.text = "$\(formattedDistance)"
        
        
        
        let basicPrice = Double(self.orderDetails?.data?[indexPath.row].basicprice ?? 0.0)
         
          let foormattedDistance = self.estimatePrice(basicPrice)
                   print(formattedDistance)  // Output: 3.1
                   
        cell.estimatePriceLbl.text = "$\(foormattedDistance)"
        
        
        let bidPrice = Double(self.orderDetails?.data?[indexPath.row].bid_price ?? 0.0)
         
          let fooormattedDistance = self.bidPrice(bidPrice)
                   print(formattedDistance)  // Output: 3.1
                   
        cell.bidPriceLbl.text = "$\(fooormattedDistance)"
        
        
        let distance = Double(self.orderDetails?.data?[indexPath.row].total_distance ?? 0.0)
         
          let foooormattedDistance = self.distanceValue(distance)
                   print(formattedDistance)  // Output: 3.1
                   
        cell.distanceLbl.text = "\(foooormattedDistance)km"
        
        
        // Cell Button Action
        
        cell.acceptedButton = {
            self.bookId = self.orderDetails?.data?[indexPath.row].id ?? 0
            self.orderAssignApi()
        }
        
        
        
        return cell
    }
    
    
    // MARK: Order Details api
    
    func orderDetailsApi(){
        let  param = ["id":id ?? 0]
        print(param)
        OrderDetailsViewModel.orderDetailsApi(viewController: self, parameters: param as NSDictionary) {
            response in
            self.orderDetails = response
            print("Success")
            
            self.myTableView.reloadData()
            
        }
    }
    
    // MARK: Assign Booking Api
    
    func orderAssignApi(){
        let param = ["id":bookId ?? 0 ,"payment_amount": "0.0", "payment_type":"wallet" ] as [String : Any]
        OrderDetailsViewModel.assignBookingApi(viewcontroller: self, parameters: param as NSDictionary) {
            response in
            self.aasignBook = response
            print("Success")
            CommonMethods.showAlertMessageWithHandler(title: Constant.BLANK, message: self.aasignBook?.msg ?? "", view: self){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientTabBarViewController") as! ClientTabBarViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
    }
    
    
    
    func upfrontPrice(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    func estimatePrice(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    func bidPrice(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    func distanceValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    
  
    
    

    
    
}
