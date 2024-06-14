//
//  ConfirmOrderVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 15/05/24.
//

import UIKit
import SDWebImage

class ConfirmOrderVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dotLine1: UIView!
    @IBOutlet weak var dotLine2: UIView!
    @IBOutlet weak var dotLine3: UIView!
    @IBOutlet weak var vehicleNameLbl: UILabel!
    
    @IBOutlet weak var expectedTimeLbl: UILabel!
    @IBOutlet weak var kmLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var timeeLbl: UILabel!
    @IBOutlet weak var vehicleImg: UIImageView!
    
    
    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet weak var timeTF: UITextField!
    
    var startDate:String?
    var timee:String?
    
    var date:String?
    var time:String?
    var changeTime:String = ""
    var changeDate:String = ""
    
    var serviceVehicleId:Int?
    var latitude:Double = 0.0
    var longnitude:Double = 0.0
    var droplatitude:Double = 0.0
    var droplongnitude:Double = 0.0
    var numberQty:String?
    var pickUpLocation:String?
    var pickUpCity:String?
    var dropLocation:String?
    var dropCity:String?
    var dateTime:String?
    var paymentMethod:String?
    var message:String?
    var bookRide:PaymentMethodModel?
    var chekCharge:ChekChargesModel?
    var additionalId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dotLine1.drawDottedLine(start: CGPoint(x: dotLine1.bounds.minX, y: dotLine1.bounds.minY), end: CGPoint(x: dotLine1.bounds.maxX, y: dotLine1.bounds.minY), view: dotLine1)
        
        dotLine2.drawDottedLine(start: CGPoint(x: dotLine2.bounds.minX, y: dotLine2.bounds.minY), end: CGPoint(x: dotLine2.bounds.maxX, y: dotLine2.bounds.minY), view: dotLine2)
        
        dotLine3.drawDottedLine(start: CGPoint(x: dotLine3.bounds.minX, y: dotLine3.bounds.minY), end: CGPoint(x: dotLine3.bounds.maxX, y: dotLine3.bounds.minY), view: dotLine3)
        
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false
        
        self.dateTF.text = startDate ?? ""
        self.timeTF.text = timee ?? ""
        
        chekChargesApi()
        
    }
    
    
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func proceedBtnTapped(_ sender: UIButton) {
        rideBookingApi()
    }
    
    @IBAction func startDateBtnTapped(_ sender: UIButton) {
        //        self.datePickerView.isHidden = false
    }
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        //        self.timePickerView.isHidden = false
    }
    
    
    
    
    
    
    @IBAction func gestureBtnClk(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
    //    @IBAction func tapGuestureBtnClick(_ sender: UITapGestureRecognizer) {
    //        self.dismiss(animated: true)
    //    }
    
    
    // MARK: Ride Booking Api
    
    func rideBookingApi(){
        let param = ["cargo": serviceVehicleId ?? 0 , "cargo_quantity": numberQty ?? "", "pickup_location": pickUpLocation ?? "","pickup_city": pickUpCity ?? "","drop_location": dropLocation ?? "","drop_city": dropCity ?? "", "pickup_latitude":latitude,"pickup_longitude":longnitude,"drop_latitude":droplatitude,"drop_longitude":droplongnitude,"pickup_datetime":dateTime ?? "","payment_method":paymentMethod ?? "", "message":message, "additional_service":additionalId] as [String : Any]
        print(param)
        PaymentMethodViewModel.bookRideApi(viewcontroller: self, parameters: param as NSDictionary) {
            response in
            self.bookRide = response
            print("Success")
            CommonMethods.showAlertMessageWithHandler(title: Constant.BLANK, message: self.bookRide?.msg ?? "", view: self){
                self.dismiss(animated: true)
                self.navigationController?.popViewController(animated: true)
                //                self.dismiss(animated: true) {
                //                            // After dismissing the popup, push the tab bar controller
                //                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                //                               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                //                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //                                if let tabBarController = storyboard.instantiateViewController(withIdentifier: "ClientTabBarViewController") as? ClientTabBarViewController {
                //                                    sceneDelegate.window?.rootViewController = tabBarController
                //                                    sceneDelegate.window?.makeKeyAndVisible()
                //                                }
                //                            }
                //                        }
                //                        delegate?.didDismissPopup()
            }
        }
    }
    
    // MARK: chekChargesApi
    
    func chekChargesApi(){
        
        let param = ["cargo": serviceVehicleId ?? 0,"pickup_location": pickUpLocation ?? "","drop_location": dropLocation ?? "","pickup_latitude":latitude,"pickup_longitude":longnitude,"drop_latitude":droplatitude,"drop_longitude":droplongnitude] as [String : Any]
        
        PaymentMethodViewModel.chekChargesApi(viewcontroller: self, parameters: param as NSDictionary) {
            response in
            self.chekCharge = response
            print("Success")
            
            let img = self.chekCharge?.cargoimage ?? ""
            if let url = URL(string: image_Url + img) {
                self.vehicleImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
                
                self.vehicleNameLbl.text = self.chekCharge?.cargoname ?? ""
              
              
                let distance = Double(self.chekCharge?.distance ?? 0.0)
                self.vehicleNameLbl.text = self.chekCharge?.cargoname ?? ""
                self.totalAmountLbl.text = "$\(self.chekCharge?.price ?? 0).00"
                
                
                let formattedDistance = self.formatToSingleDecimalPlace(distance)
                         print(formattedDistance)  // Output: 3.1
                         
                         self.kmLbl.text = "\(formattedDistance)km"
                         print(self.kmLbl.text ?? "")
                
                let minut = self.chekCharge?.duration?.minutes ?? 0
                let hours = self.chekCharge?.duration?.hours ?? 0
                let total = "\(hours) :\(minut) hrs"
                
                self.expectedTimeLbl.text = total
                self.timeeLbl.text  = total
                
                
            }
        }
        
        
    }
    
    
    //round to single digit after decimal
       func formatToSingleDecimalPlace(_ value: Double) -> String {
           let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 1
           formatter.minimumFractionDigits = 1
           formatter.roundingMode = .halfUp
           return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
       }
    
    
    
}


//dotted line
extension UIView{
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
}



// MARK: - UIGestureRecognizerDelegate

extension ConfirmOrderVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

