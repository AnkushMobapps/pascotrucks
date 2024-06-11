//
//  LoginVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 16/04/24.
//

import UIKit
import CoreLocation
import PhoneNumberKit
//hdhgsdhjsd
class LoginVC: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate{
//   var locationManager = CLLocationManager()
//    private let phoneNumberKit = PhoneNumberKit()
//    var dialingPhoneCode:String?
    var selecttypestr:String?
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var selectedSegment:String?
    
    var chekdriverLoginModel:CheckLoginModel?
    var driverloginModel:LoginModel?
    
    var clientCheckLogModel:CheckClientLoginModel?
    var clientLogModel:ClientLoginModel?
    
    var newdeviceNumber:String?
    var verfiedId:String?
    var driverID:Int?
    var loginCity:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCodeTxt.text = UserDefaults.standard.string(forKey: "countryCode")
        print( countryCodeTxt.text)
        
        countryCodeTxt.delegate = self
        segmentedControl.selectedSegmentIndex = 0
        selectedSegment = "user"
        
        deviceID()
        
       
        
    }
    
    
    
//    //MARK: - location find out
//
//  private func requestCurrentLocation() {
//      locationManager.requestLocation()
//  }
//  
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//      guard let location = locations.last else { return }
//      let lat = location.coordinate.latitude
//      let long = location.coordinate.longitude
//      print("Latitude: \(lat), Longitude: \(long)")
//      
//      UserDefaults.standard.setValue(lat, forKey: "latitude")
//      UserDefaults.standard.setValue(long, forKey: "longitude")
//      
//      // Reverse geocode to get the full address, city, country name, and country code
//      let geocoder = CLGeocoder()
//      geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
//          guard let self = self else { return }
//          
//          if let error = error {
//              print("Error in reverse geocoding: \(error.localizedDescription)")
//              return
//          }
//          
//          if let placemark = placemarks?.first {
//              let city = placemark.locality ?? "Unknown city"
//              let country = placemark.country ?? "Unknown country"
//              let isoCountryCode = placemark.isoCountryCode ?? "Unknown country code"
// 
//              UserDefaults.standard.setValue(city, forKey: "driverCity")
//         }
//      }
//      
//      // Stop updating location after getting the current location
//      locationManager.stopUpdatingLocation()
//  }
//  
//  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//      print("Failed to find user's location: \(error.localizedDescription)")
//  }
    
    // MARK: - Example method to select segments
    
    @IBAction func segmentBtnClk(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("First segment selected")
            selectedSegment = "user"
        case 1:
            print("Second segment selected")
            selectedSegment = "driver"
        default:
            break
        }
    }
    
    // MARK: - UITextFieldDelegate method
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == countryCodeTxt else { return true }
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if currentText.isEmpty && !string.isEmpty {
            countryCodeTxt.text = "+" + string
            return false
        }
        
        return true
    }
    
    // MARK: - Device ID
    
    func deviceID(){
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        newdeviceNumber = deviceId
        print(deviceId)
    }
  
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
       
            if self.segmentedControl.selectedSegmentIndex == 0{
                // for client
                self.clientCheckLoginApi()
            }
            else if self.segmentedControl.selectedSegmentIndex == 1{
                //for driver
                self.drivercheckLoginApi()
            }
        
    }
    
    
    @IBAction func goToSignUpBtn(_ sender: UIButton) {
        if segmentedControl.selectedSegmentIndex == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
            vc.userType = self.selectedSegment
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompleteRegistrationVC") as! CompleteRegistrationVC
            vc.userType = self.selectedSegment
            print(self.selectedSegment ?? "")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}



// MARK: -  *******  API ******

extension LoginVC {
    //MARK: - Driver All Login Api
    
    func drivercheckLoginApi(){
        LoginViewModel.Validation(viewController: self){
            
            var param = [String:Any]()
            
            param = ["phone_number":self.phoneTF.text ?? "" ,"user_type":self.selectedSegment ?? "","phone_verify":self.newdeviceNumber ?? ""]
            print(param)
            LoginViewModel.checkLoginApi(viewController: self, parameters: param as NSDictionary){(response) in
                print("success")
                self.chekdriverLoginModel = response
                let logindevice = self.chekdriverLoginModel?.login
                
                if logindevice == 1{
                    print("login with same device")
                    self.driverloginApiMetnod()
                }
                
                else{
                    CommonMethods.showAlertMessageWithOkAndCancel(title: Constant.TITLE, message: "Verify Your Account", view: self) {
                    let phoneNo = (self.countryCodeTxt.text ?? "")+(self.phoneTF.text ?? "")
//                     AuthManager.shared.startAuth(phoneNumber: phoneNo) { (success) in
//                     if success {
                    let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
                    vc.selectedType = .login
                    vc.selectedCountryCode = self.countryCodeTxt.text ?? ""
                    vc.phoneNumber = self.phoneTF.text ?? ""
                    vc.deviceID = self.newdeviceNumber
                    vc.userType = self.selectedSegment
                    print(self.selectedSegment)
                    self.navigationController?.pushViewController(vc, animated: true)
                     }
//                     else {
//                      CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Something Wrong",                   view: self)
//                     }
                     // }
                    // }
              }
           }
        }
   }
    
    // driverLogin api for different device
    func verifyDeviceLogin(){
        
    }
    
    // driverLogin api for same device
    func driverloginApiMetnod(){
        let param = [ "phone_number":phoneTF.text ?? "", "user_type" : selectedSegment ?? ""] as [String : Any]
        print(param)
       LoginViewModel.LoginApi(viewcontroller: self, parameters: param as NSDictionary){
            (responseObject) in
            print("Success")
            self.driverloginModel = responseObject
            let approvalKey = self.driverloginModel?.approved
            let driverId = self.driverloginModel?.user_id
            UserDefaults.standard.set(driverId, forKey: "user_id")
            self.driverID = UserDefaults.standard.integer(forKey: "user_id")
            print(self.driverID ?? "")
            let tokkken = self.driverloginModel?.token?.access
            UserDefaults.standard.setValue(tokkken, forKey: "token")
           
           let refresh_tokkken = self.driverloginModel?.token?.refresh
           UserDefaults.standard.setValue(refresh_tokkken, forKey: "refresh_tokkken")
           
            UserDefaults.standard.setValue(approvalKey, forKey: "approve")
            
            // approved from admin or not
            if approvalKey == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBar") as! MyTabBar
              
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if approvalKey == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBar") as! MyTabBar
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            else{
                CommonMethods.showAlertMessageWithHandler(title: Constant.TITLE, message: responseObject?.msg ?? Constant.BLANK, view: self) {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as! VehicleDetailsVC
                    //add vehicle details for login user_id
                    vc.userID = self.driverloginModel?.user_id ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    //MARK: - Client All Login Api
    //checkLogin
    func clientCheckLoginApi(){
        let param = ["phone_number":phoneTF.text ?? "","user_type":selectedSegment ?? "","phone_verify":newdeviceNumber]
        print(param)
        LoginViewModel.ClientcheckLoginApi(viewController: self, parameters: param as NSDictionary){(response) in
            print("success")
            self.clientCheckLogModel = response
            let logindevice = self.clientCheckLogModel?.Login
            if logindevice == 0{
                                let phoneNo = "+91\(self.phoneTF.text ?? "")"
                                AuthManager.shared.startAuth(phoneNumber: phoneNo) { (success) in
                
                                    if success{
                                        let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
                                        vc.userType = self.selectedSegment
                                        vc.phoneNumber = self.phoneTF.text ?? ""
                                        vc.selectedType = .login
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                    else{
                                        let alert = UIAlertController(title: "", message: "Something Wrong", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                                        nil))
                                        self.present(alert, animated: true, completion: nil)
                                    }
                
                                }
//                
//                let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
//                vc.userType = se
//                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            else{
                self.clientLoginApiMetnod()
            }
            
             
        }
    }
    
    
    
    
    // MARK: - Client Login Api
    func clientLoginApiMetnod(){
        let param = [ "phone_number":phoneTF ?? "", "user_type" : selectedSegment ?? ""] as [String : Any]
        print(param)
        LoginViewModel.ClientLoginApi(viewcontroller: self, parameters: param as NSDictionary){
            (responseObject) in
            print("Success")
            self.clientLogModel = responseObject
            
            let userId = self.clientLogModel?.user_id
            UserDefaults.standard.setValue(userId, forKey: "user_ID")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientTabBarViewController") as! ClientTabBarViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    
    
    
}


