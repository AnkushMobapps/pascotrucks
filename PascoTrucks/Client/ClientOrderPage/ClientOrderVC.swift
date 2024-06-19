//
//  ClientOrderVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 13/05/24.
//

import UIKit

class ClientOrderVC: UIViewController {
    @IBOutlet weak var topBar: ClientTitleBar!
    @IBOutlet weak var tbView1: UIView!
    @IBOutlet weak var tbView2: UIView!
    @IBOutlet weak var tbView3: UIView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var allBidTBView: UITableView!
    @IBOutlet weak var acceptBidTBView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var totalPrice:String?
    var dateTime:String?
    var tootalDistance:String?
    var requestOrder:resqustOrderModel?
    var allBids:AllBidsModel?
    var accepetOrder:ActiveOrderModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        tbView2.isHidden = true
        tbView3.isHidden = true
        
        requestOrderApi()
        allBidsApi()
        accepetOrderApi()
        
    }
    
    
    @IBAction func segmentsBtnClk(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tbView1.isHidden = false
            tbView2.isHidden = true
            tbView3.isHidden = true
            requestOrderApi()
        }
        else if sender.selectedSegmentIndex == 1{
            tbView1.isHidden = true
            tbView2.isHidden = false
            tbView3.isHidden = true
            allBidsApi()
        }
        else{
            tbView1.isHidden = true
            tbView2.isHidden = true
            tbView3.isHidden = false
            accepetOrderApi()
        }
    }
    
}
extension ClientOrderVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == orderTableView{
            return requestOrder?.data?.count ?? 0
        }
        else if tableView == allBidTBView{
            return allBids?.data?.count ?? 0
        }
        else{
            return accepetOrder?.data?.count ?? 0 
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == orderTableView{
            let cell = orderTableView.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderCell
            cell.nameLbl.text = requestOrder?.data?[indexPath.row].user ?? ""
            cell.orderId.text = requestOrder?.data?[indexPath.row].booking_number ?? ""
//            cell.priceLbl.text = "\(requestOrder?.data?[indexPath.row].basicprice ?? 0)"
            cell.nameLbl.text = requestOrder?.data?[indexPath.row].user ?? ""
           let value = requestOrder?.data?[indexPath.row].user ?? ""
            
            
            let inputDateString = requestOrder?.data?[indexPath.row].pickup_datetime ?? ""

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
            
            cell.dateLbl.text = outputDateString
             
            
            
            
            
            
            let Price = Double(requestOrder?.data?[indexPath.row].basicprice ?? 0.0)
             
              let foormattedDistance = self.frmatToSingleDecimalPlace(Price)
                       print(foormattedDistance)  // Output: 3.1
                       
            cell.priceLbl.text = "$\(foormattedDistance)"
                    
            
            
            
            
            
            print(value)
           
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            return cell
        }
        else if tableView == allBidTBView {
            let cell = allBidTBView.dequeueReusableCell(withIdentifier: "allBidCell", for: indexPath) as! AllBidCell
            cell.nameLbl.text = self.allBids?.data?[indexPath.row].user ?? ""
//            cell.pricelbl.text = self.allBids?.data?[indexPath.row].basicprice ??
         
            cell.orderId.text = self.allBids?.data?[indexPath.row].booking_number ?? ""
     
            let inputDateString = self.allBids?.data?[indexPath.row].pickup_datetime ?? ""

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
            
            cell.dateLbl.text = outputDateString
            self.dateTime =   cell.dateLbl.text
             
            
            
            
            
            
            let Price = Double(allBids?.data?[indexPath.row].basicprice ?? 0.0)
             
              let foormattedDistance = self.fmatToSingleDecimalPlace(Price)
                       print(foormattedDistance)  // Output: 3.1
                       
            cell.pricelbl.text = "$\(foormattedDistance)"
            
//            totalPrice =  cell.pricelbl.text
            
            
//            let distance = Double(allBids?.data?[indexPath.row].total_distance ?? 0.0)
//             
//              let formattedDistance = self.totalDistance(distance)
//                       print(formattedDistance)  // Output: 3.1
//                       
//            self.tootalDistance = "$\(foormattedDistance)"
          
            
           
            
                    
            
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            return cell
        }
        
        else{
            let cell = acceptBidTBView.dequeueReusableCell(withIdentifier: "acceptBidCell", for: indexPath) as! AcceptBidCell
            cell.nameLbl.text = self.accepetOrder?.data?[indexPath.row].user ?? ""
            cell.orderIdLbl.text = self.accepetOrder?.data?[indexPath.row].booking_number ?? ""
            cell.statusLbl.text = self.accepetOrder?.data?[indexPath.row].booking_status ?? ""
    
        
            
            let inputDateString = self.accepetOrder?.data?[indexPath.row].pickup_datetime ?? ""

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
            
            cell.dateLbl.text = outputDateString
             
            
            
            
            
            
            let Price = Double(accepetOrder?.data?[indexPath.row].basicprice ?? 0.0)
             
              let foormattedDistance = self.fmtToSingleDecimalPlace(Price)
                       print(foormattedDistance)  // Output: 3.1
                       
            cell.estimatePrizeLbl.text = "$\(foormattedDistance)"
       
            
            
            
            
            
           
            
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            
            // Cell Btn Action
            
            cell.nextButton = {
                let vc = self.storyboard?.instantiateViewController(identifier: "TrackLocationVC") as! TrackLocationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
        
        //round to single digit after decimal
           
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == allBidTBView{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientOrderDetailsVC") as! ClientOrderDetailsVC
            
            vc.name  = self.allBids?.data?[indexPath.row].user ?? ""
            vc.orderId = self.allBids?.data?[indexPath.row].booking_number ?? ""
         
           
         
         
         
          
            vc.picckupLocation = self.allBids?.data?[indexPath.row].pickup_location ?? ""
            vc.dropLocation = self.allBids?.data?[indexPath.row].drop_location ?? ""
            vc.id = self.allBids?.data?[indexPath.row].id ?? 0
            
            
            
            let Price = Double(allBids?.data?[indexPath.row].basicprice ?? 0.0)
             
              let foormattedDistance = self.fmatToSingleDecimalPlace(Price)
                       print(foormattedDistance)  // Output: 3.1
                       
            totalPrice = "$\(foormattedDistance)"
            
            vc.totalPrice =  self.totalPrice
           
            
            
            let distance = Double(allBids?.data?[indexPath.row].total_distance ?? 0.0)
             
              let formattedDistance = self.totalDistance(distance)
                       print(formattedDistance)  // Output: 3.1
                       
            self.tootalDistance = "\(formattedDistance)km"
            vc.distance = tootalDistance
         
            
            
            
            let inputDateString = self.allBids?.data?[indexPath.row].pickup_datetime ?? ""

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
            
            self.dateTime = outputDateString
            vc.dateTime = dateTime
            
            
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if tableView == acceptBidTBView {
            
            let vc = self.storyboard?.instantiateViewController(identifier: "TrackLocationVC") as! TrackLocationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    // MARK: requestOrderApi
    
    func requestOrderApi(){
        let param = [String:Any] ()
        RequestOrderViewModel.requestOrderApi(viewController: self, parameters: param as NSDictionary){
            response in
            self.requestOrder = response
            print("Success")
            self.orderTableView.reloadData()
        }
    }
    
    // MARK: AllbidsApi
    
    func allBidsApi(){
        let param = [String:Any] ()
        RequestOrderViewModel.allBidsApi(viewController: self, parameters: param as NSDictionary) {
            response in
            
            self.allBids = response
            print("Success")
            self.allBidTBView.reloadData()
        }
        
    }
    
        // MARK: AccpetOrder Api
    
    func accepetOrderApi(){
        let param = [String:Any] ()
        RequestOrderViewModel.AcceptOrderApi(viewController: self, parameters: param as NSDictionary) {
            response in
            self.accepetOrder = response
            
            print("Success")
            self.acceptBidTBView.reloadData()
        }
    }
    
  
    
    

    
    func frmatToSingleDecimalPlace(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    func fmatToSingleDecimalPlace(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    
    func fmtToSingleDecimalPlace(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    func totalDistance(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
