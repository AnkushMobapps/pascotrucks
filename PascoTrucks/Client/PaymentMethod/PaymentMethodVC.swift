//
//  PaymentMethodVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 13/05/24.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation


class PaymentMethodVC: UIViewController,getAddressWithLatLong, UITextFieldDelegate, UITextViewDelegate,getVichleType,getAdditionalService {
    func vichleTypeList(type: String?, typeId: Int) {
        self.vichleTypeTF.text = type
        self.cargoValue = typeId
        self.cargoQtyApi()
        
       
    }
    
    
    
    func serviceList(service: String?) {
        self.additionalServiceTF.text  = service
    }
    
    
    
    func addressWithLatLong(address: String?, latLong: CLLocationCoordinate2D?) {
        if value == "Pick"{
            self.pickTF.text = address
            print(address ?? "")
            
//            self.pickAddress = address
            getCityFromAddress(address ?? "")
        }
        else{
            self.endTF.text = address
//            self.endAddress = address
            getCityFromAddress(address ?? "")
        }
    }
    
    
    @IBOutlet weak var vichleTypeTF: UITextField!
    @IBOutlet weak var topBar: ClientTitleBar!
    @IBOutlet weak var pickTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
      @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var datePickerView: UIView!
    
    @IBOutlet weak var timePickerView: UIView!
    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var walletBtn: UIButton!
    @IBOutlet weak var visaBtn: UIButton!
    @IBOutlet weak var numberQtyTF: UITextField!
    @IBOutlet weak var numberView: UIView!
    
    @IBOutlet weak var qtyTF: UITextField!
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var setView: UIView!
    @IBOutlet weak var setViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    
    @IBOutlet weak var updatePopUpView: UIView!
    @IBOutlet weak var cashRadioImg: UIImageView!
    
    @IBOutlet weak var additionalServiceTF: UITextField!
    @IBOutlet weak var walletRadioImg: UIImageView!
    @IBOutlet weak var visaRadioImg: UIImageView!
     var serviceVehicleId:Int?
    var value:String?
    var date:String?
    var time:String?
    var changeTime:String = ""
    var changeDate:String = ""
    var profileStatus:Int?
    var cargoQtyValue:Int?
    var cargoValue:Int?
    var cargoQty:CargoQtyModel?
    
    var currentValue: Int = 0
       var maxValue: Int = 0
    
    var pickAddress:String?
    var endAddress:String?
    
    var cityy:String = ""
    var cityy1:String?
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var droplatitude: Double = 0.0
    var droplongitude: Double = 0.0
    
    var dateTime:String?
    var paymentMethod:String? = ""
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
       updatePopUpView.isHidden = true
        
        cashView.layer.borderWidth = 0
        cashView.layer.shadowColor = UIColor.lightGray.cgColor
        cashView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cashView.layer.shadowRadius = 2
        cashView.layer.shadowOpacity = 0.3
        cashView.layer.masksToBounds = false
        
        walletView.layer.borderWidth = 0
        walletView.layer.shadowColor = UIColor.lightGray.cgColor
        walletView.layer.shadowOffset = CGSize(width: 0, height: 0)
        walletView.layer.shadowRadius = 2
        walletView.layer.shadowOpacity = 0.3
        walletView.layer.masksToBounds = false
        
        visaView.layer.borderWidth = 0
        visaView.layer.shadowColor = UIColor.lightGray.cgColor
        visaView.layer.shadowOffset = CGSize(width: 0, height: 0)
        visaView.layer.shadowRadius = 2
        visaView.layer.shadowOpacity = 0.3
        visaView.layer.masksToBounds = false
        
        messageView.layer.borderWidth = 0
        messageView.layer.shadowColor = UIColor.lightGray.cgColor
        messageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        messageView.layer.shadowRadius = 2
        messageView.layer.shadowOpacity = 0.3
        messageView.layer.masksToBounds = false
        
        //radio btns
        cashBtn.isSelected = false
        walletBtn.isSelected = false
        visaBtn.isSelected = false
       
       datePickerView.isHidden = true
       timePickerView.isHidden = true
       datePicker.minimumDate = Date()
       datePicker.date = Date()
       timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
       datePicker.addTarget(self, action: #selector(dateeChanged), for: .valueChanged)
       
       setViewHeightContraint.constant = 230
       numberView.isHidden = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.profileStatus = UserDefaults.standard.integer(forKey: "profile")
        print(profileStatus)
        
        if profileStatus != 0{
            updatePopUpView.isHidden = true
        }
        else{
            updatePopUpView.isHidden = false
        }
    
    }
    
//    func getCityFromAddress(_ address: String) {
//           let geocoder = CLGeocoder()
//           geocoder.geocodeAddressString(address) { (placemarks, error) in
//               if let error = error {
//                   print("Error: \(error.localizedDescription)")
//                   return
//               }
//               
//               guard let placemark = placemarks?.first else {
//                   print("No placemark found")
//                   return
//               }
//               
//               if let city = placemark.locality {
//                   if self.cityy == ""{
//                       self.cityy = city
//                       print("City: \(self.cityy)")
//                   }
//                   else{
//                       self.cityy1 = city
//                       print("City1: \(self.cityy1)")
//                   }
//                  
//                   // City name is now stored in the variable 'city'
//               } else {
//                   print("City not found in the address components")
//               }
//           }
//       }
    
    
    
    
    func getCityFromAddress(_ address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                return
            }
            
            if let city = placemark.locality {
                if self.cityy == "" {
                    self.cityy = city
                    print("City: \(self.cityy)")
                } else {
                    self.cityy1 = city
                    print("City1: \(self.cityy1)")
                }
                
                if let location = placemark.location {
                    let latitude = location.coordinate.latitude
                    let longitude = location.coordinate.longitude
                    print("Latitude: \(latitude), Longitude: \(longitude)")
                    
                    // Store latitude and longitude in your variables if needed
                    
                    if self.latitude == 0.0{
                        self.latitude = latitude
                        self.longitude = longitude
                    }
                    else {
                        self.droplatitude = latitude
                        self.droplongitude = longitude
                    }
                    
                    
                } else {
                    print("Location not found in the placemark")
                }
            } else {
                print("City not found in the address components")
            }
        }
    }

    
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Time Picker
       
        @objc func timeChanged(_ datePicker: UIDatePicker) {
            let selectedDate = timePicker.date
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mma"
            let timeString = timeFormatter.string(from: selectedDate)
            self.changeTime = timeString
        
            print("Selected Time: \(timeString)")
            self.timeTF.text = self.changeTime
            
        }
       
       
       
       
       //MARK: - Get current date and time
       
       func CurrentDateAndTimeGet(){
           
           let currentDateAndTime = Date()
           
           // Extract date components
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd-MM-yyyy"
           let currentDate = dateFormatter.string(from: currentDateAndTime)
           print("Current Date: \(currentDate)")
           self.changeDate = currentDate
           self.dateTF.text = self.changeDate
       }
   
        
       
       // MARK: - Date Picker
       
        @objc func dateeChanged(_ datePicker: UIDatePicker) {
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: selectedDate)
            self.changeDate = dateString
            self.dateTF.text =   self.changeDate
            print(changeDate)
            print("Selected Date: \(dateString)")
        }
    
    
    
    @IBAction func plusBtnTapped(_ sender: UIButton) {
        if currentValue < maxValue {
                    currentValue += 1
                    qtyTF.text = "\(currentValue)"
                }
    }
    
    @IBAction func minusBtnTapped(_ sender: UIButton) {
        
        if currentValue > 0 {
            currentValue -= 1
            qtyTF.text = "\(currentValue)"
        }

    }
    
    
    
    
    
    
    @IBAction func cashBtnClk(_ sender: UIButton) {
        
        self.paymentMethod = "wallet"
            cashRadioImg.image = UIImage(named: "filledRadio")
            walletRadioImg.image = UIImage(named: "radioUnfilled")
            visaRadioImg.image = UIImage(named: "radioUnfilled")
       
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func yesBtnTapped(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientTabBarViewController") as! ClientTabBarViewController
//        checkYesstr = "1"
//        self.navigationController?.pushViewController(vc, animated: true)
       self.tabBarController?.selectedIndex = 4
    }
    
    
    
    
    @IBAction func dateOkBtnTapped(_ sender: UIButton) {
        if self.changeDate == ""{
            CurrentDateAndTimeGet()
        }
        datePickerView.isHidden  = true
    }
    @IBAction func addtionalServiceBtnTapped(_ sender: UIButton) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "AddtionalServiceVC") as! AddtionalServiceVC
                        targetVC.modalPresentationStyle = .overFullScreen
                        targetVC.modalTransitionStyle = .crossDissolve
                        
        targetVC.delegate = self
                        self.present(targetVC, animated: true, completion: nil)
    }
    
    @IBAction func dateCutBtnTapped(_ sender: UIButton) {
        datePickerView.isHidden  = true
    }
    @IBAction func timeOkBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = true
    }
    
    @IBAction func timeCutBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = true
    }
    
    
    
    
    
    
    
    @IBAction func walletBtnClk(_ sender: UIButton) {
      
        self.paymentMethod = "wallet"
            walletRadioImg.image = UIImage(named: "filledRadio")
            cashRadioImg.image = UIImage(named: "radioUnfilled")
            visaRadioImg.image = UIImage(named: "radioUnfilled")
           
       
//
//        
    }
    
    
    
    
    
    
    @IBAction func visaBtnClk(_ sender: UIButton) {
          self.paymentMethod = "wallet"
            visaRadioImg.image = UIImage(named: "filledRadio")
            cashRadioImg.image = UIImage(named: "radioUnfilled")
            walletRadioImg.image = UIImage(named: "radioUnfilled")
           }
    
    @IBAction func vichcleTypeBtnTapped(_ sender: UIButton) {
        
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "VicheleTypeVC") as! VicheleTypeVC
                        targetVC.modalPresentationStyle = .overFullScreen
                        targetVC.modalTransitionStyle = .crossDissolve
        targetVC.vehicleid = serviceVehicleId ?? 0
        print(serviceVehicleId)
                        
        targetVC.delegate = self
                        self.present(targetVC, animated: true, completion: nil)
                    
        
    }
    
    @IBAction func confirmOrderBtnClk(_ sender: UIButton) {
        
        if pickTF.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Enter Pickup Locaton", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if endTF.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Enter Drop Locaton", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if qtyTF.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Enter Quantity", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if dateTF.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Enter Date", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if timeTF.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Enter Time", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if additionalServiceTF.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Add Additional Service", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        else if paymentMethod == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Select Payment Method", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
           
            let vc = self.storyboard?.instantiateViewController(identifier: "ConfirmOrderVC") as! ConfirmOrderVC
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
           // vc.listType = "Language"
           // vc.selectrowdelegate = self
            vc.serviceVehicleId = self.serviceVehicleId ?? 0
            vc.pickUpLocation = self.pickTF.text ?? ""
            vc.dropLocation = self.endTF.text ?? ""
            vc.pickUpCity = self.cityy
            vc.dropCity = self.cityy1 ?? ""
            vc.latitude = self.latitude
            vc.longnitude = self.longitude
            vc.droplatitude = self.droplatitude
            vc.droplongnitude = self.droplongitude
            print(self.droplatitude)
            print(self.droplongitude)
            vc.paymentMethod = self.paymentMethod
            self.dateTime =  "\(changeDate) \(changeTime)"
            vc.additionalId = cargoValue
            vc.startDate = changeDate
            vc.timee = changeTime
            
            vc.dateTime = dateTime
            vc.message = self.messageTextView.text ?? ""
            vc.numberQty = self.qtyTF.text ?? ""
            
            
            self.present(vc, animated: true, completion: nil)
            
            
        }
        
        
        
        
        
      
        
    }
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = false
    }
    @IBAction func dateBtnTapped(_ sender: UIButton) {
        datePickerView.isHidden = false
    }
    
    
    
    @IBAction func pickDestinationBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "PinaddressVC") as! PinaddressVC
        self.value = "End"
        vc.delegate = self
     
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func pickPointBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "PinaddressVC") as! PinaddressVC
        self.value = "Pick"
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    // MARK: CargoQty Api
    func cargoQtyApi() {
            var param = [String: Any]()
            param = [
                "cargo": cargoValue ?? 0,
                "pickup_location": pickTF.text ?? "",
                "pickup_city": cityy,
                "drop_location": endTF.text ?? "",
                "drop_city": cityy1
            ]
            print(param)
        PaymentMethodViewModel.CargoQtyApi(viewcontroller: self, parameters: param as NSDictionary) { [self]
            response in
            self.cargoQty = response
            print("Success")
            self.numberQtyTF.text = "\(self.cargoQty?.available_driver ?? 0)"
            let value = self.cargoQty?.available_driver ?? 0
            
           maxValue  = value
//                    qtyTF.text = "\(currentValue)"
            
            if self.numberQtyTF.text != ""{
                self.numberView.isHidden = false
                setViewHeightContraint.constant = 290
            }

            else{
                numberView.isHidden = true
                setViewHeightContraint.constant = 230
            }
        }
    }
    
    
   
    
    
}
