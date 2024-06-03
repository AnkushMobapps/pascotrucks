//
//  LoginVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 16/04/24.
//

import UIKit
import CoreLocation

class LoginVC: UIViewController, UITextFieldDelegate{
    
    var locationManager: LocationManager?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        loginBtn.GradientColor(colorOne: #colorLiteral(red: 0.8352941176, green: 0.6549019608, blue: 0.3764705882, alpha: 1), colorTwo: #colorLiteral(red: 0.6117647059, green: 0.4705882353, blue: 0.231372549, alpha: 1))
        
        locationManager = LocationManager()
        // getLatitudeAndLongitude()
        
        countryCodeTxt.delegate = self
        segmentedControl.selectedSegmentIndex = 0
        selectedSegment = "user"
        
        deviceID()
      countryCodeTxt.text = UserDefaults.standard.value(forKey: "countryCode") as? String
        print( countryCodeTxt.text ?? "countryCode")
     }
    
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
            let param = ["phone_number":self.phoneTF.text ?? "" ,"user_type":self.selectedSegment ?? "","phone_verify":self.newdeviceNumber]
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
                    //CommonMethods.showAlertMessageWithOkAndCancel(title: Constant.TITLE, message: "Verify Your Account", view: self) {
                    let phoneNo = (self.countryCodeTxt.text ?? "")+(self.phoneTF.text ?? "")
                    // AuthManager.shared.startAuth(phoneNumber: phoneNo) { (success) in
                    
                    // if success {
                    let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
                    vc.selectedType = .login
                    vc.phoneNumber = self.phoneTF.text
                    vc.deviceID = self.newdeviceNumber
                    vc.userType = self.selectedSegment
                    print(self.selectedSegment)
                    self.navigationController?.pushViewController(vc, animated: true)
                    // }
                    // else {
                    //  CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Something Wrong", view: self)
                    // }
                    //  }
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
                //                let phoneNo = "+91\(self.phoneTF.text ?? "")"
                //                AuthManager.shared.startAuth(phoneNumber: phoneNo) { (success) in
                //
                //                    if success{
                //                        let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
                //                        vc.selectedSegment = self.selectedSegment
                //                        vc.phoneNumber = self.phoneTF.text ?? ""
                //                        vc.selectedType = .login
                //                        self.navigationController?.pushViewController(vc, animated: true)
                //                    }
                //                    else{
                //                        let alert = UIAlertController(title: "", message: "Something Wrong", preferredStyle: .alert)
                //                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                //                                                        nil))
                //                        self.present(alert, animated: true, completion: nil)
                //                    }
                //
                //                }
                
                let vc = self.storyboard?.instantiateViewController(identifier: "ClientTabBarViewController") as! ClientTabBarViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            else{
                let vc = self.storyboard?.instantiateViewController(identifier: "ClientTabBarViewController") as! ClientTabBarViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            //            if logindevice == 1{
            ////                self.clientLoginApiMetnod()
            //            }
            //            else{
            //                CommonMethods.showAlertMessageWithOkAndCancel(title: Constant.TITLE, message: "Verify Your Account", view: self) {
            //                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVerifyNoVC") as! LoginVerifyNoVC
            //                    self.navigationController?.pushViewController(vc, animated: true)
            //                }
            //            }
        }
    }
}


