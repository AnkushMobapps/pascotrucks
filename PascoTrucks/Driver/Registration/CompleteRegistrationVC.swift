//
//  CompleteRegistrationVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 04/05/24.
//

import UIKit
import SDWebImage
import CoreLocation

class CompleteRegistrationVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,CLLocationManagerDelegate, UITextFieldDelegate {
   
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneNoTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var countryCode: UITextField!
    
    var device_Id:String?
    var userType:String?
    // var userid:String?
    
    var fullAddress:String?
    var lang:String?
    var lat:String?
    var currentCity:String?
    let geocoder = CLGeocoder()
    
    var chekRegNumModel:ChekRegisterNUmberModel?
    var cityID:Int?
    var currentLat:String?
    var currentLong:String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        deviceID()  
        
        countryCode.delegate = self
        
        //by default country code through location
        countryCode.text = UserDefaults.standard.value(forKey: "countryCode") as? String
        
        //by defualt city and county on textfield
        print("city Name = ", UserDefaults.standard.string(forKey: "cityName") as Any)
        currentCity = UserDefaults.standard.string(forKey: "cityName")
        cityTxt.text = currentCity
        print(cityTxt.text ?? "")
        fullAddress = "sector 59,280301"
        print(fullAddress)
        
    }
    
// MARK: - UITextFieldDelegate method(by default + in country code field)
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       guard textField == countryCode else { return true }
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if currentText.isEmpty && !string.isEmpty {
            countryCode.text = "+" + string
            return false
        }
        return true
    }
    
    
// MARK: - Finding longitude and latitude using current city
    func getCoordinates(for city: String, completion: @escaping (CLLocation?, Error?) -> Void) {
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                completion(nil, NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No location found"]))
                return
            }
            completion(location, nil)
        }
    }
    
    
    // MARK: - Device ID
    
    func deviceID(){
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        device_Id = deviceId
        print(deviceId)
    }
    
    
    @IBAction func selectCityClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "DropDownListVC") as! DropDownListVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.listType = "City"
        vc.countryCode = self.countryCode.text ?? ""
        vc.selectrowdelegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func submitRegBtnClk(_ sender: Any) {
        
        RegisterViewModel.Validation(viewController: self){
            self.chekNumberApi()
        }
      }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
}





// MARK: - ************    API   ***************

extension CompleteRegistrationVC {
    // MARK: - Chek Number Api for Both User And driver
    
    func chekNumberApi(){
        let param = ["phone_number":phoneNoTxt.text ?? "","user_type":userType ?? ""]
        print(param)
        RegisterViewModel.chekRegNumberApi(viewController: self, parameters: param as NSDictionary){(response) in
            print("success")
            self.chekRegNumModel = response
            
            let value = self.chekRegNumModel?.exists
            if value == 1{
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: self.chekRegNumModel?.msg ?? Constant.BLANK, view: self)
            }
            else {
                let phoneNo = (self.countryCode.text ?? "")+"\(self.phoneNoTxt.text ?? "")"
                AuthManager.shared.startAuth(phoneNumber: phoneNo) { (success) in

                    if success {
                        let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
                        vc.selectedType = .Register
                        vc.selectedCountryCode = self.countryCode.text ?? ""
                        vc.phoneNumber = self.phoneNoTxt.text ?? ""
                        vc.deviceID = self.device_Id
                        vc.userType = self.userType
                        vc.name = self.nameTxt.text ?? ""
                        vc.email = self.emailTxt.text ?? ""
                        vc.city = self.cityTxt.text ?? ""
                        print(self.cityTxt.text ?? "")
                        vc.currentLocation = self.fullAddress
                        vc.currentLatitude = self.currentLat
                        print(self.currentLat)
                        vc.currentLangitude = self.currentLong
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else {
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Something Wrong", view: self)
                    }
                }
                //without firebase
                
//                let vc = self.storyboard?.instantiateViewController(identifier:"VerifyAccountVC") as! VerifyAccountVC
//                vc.selectedType = .Register
//                vc.selectedCountryCode = self.countryCode.text ?? ""
//                vc.phoneNumber = self.phoneNoTxt.text ?? ""
//                vc.deviceID = self.device_Id
//                vc.userType = self.userType
//                vc.name = self.nameTxt.text ?? ""
//                vc.email = self.emailTxt.text ?? ""
//                vc.city = self.cityTxt.text ?? ""
//                print(self.cityTxt.text ?? "")
//                vc.currentLocation = self.fullAddress
//                vc.currentLatitude = self.currentLat
//                print(self.currentLat)
//                vc.currentLangitude = self.currentLong
//                self.navigationController?.pushViewController(vc, animated: true)
//                print(self.currentLong)
            }
            
        }
    }
}

extension CompleteRegistrationVC:selectList{
    func selcetrow(rowid: String, typeID: Int?) {
        cityTxt.text = rowid
      
        // Example city name
        let cityName = cityTxt.text ?? ""
        
    // Get coordinates for the selected city (long and lat using current city)
        getCoordinates(for: cityName) { (location, error) in
            if let error = error {
                print("Error getting coordinates: \(error)")
            } else if let location = location {
                var currentLat = location.coordinate.latitude
                self.currentLat = String(currentLat)
                var currentLong = location.coordinate.longitude
                self.currentLong = String(currentLong)
                print("Latitude: \(currentLat), Longitude: \(currentLong)")
            }
        }

        self.cityID = typeID ?? 0
    }
}

