//
//  VarifyAccountVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 17/04/24.
//

import UIKit

class VerifyAccountVC: UIViewController {
    
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var txtOTP5: UITextField!
    @IBOutlet weak var txtOTP6: UITextField!
    @IBOutlet weak var phoneNo: UILabel!
    var selectedCountryCode:String?
    var phoneNumber:String?
    var deviceID:String?
    var userId:String?
    var driverID:Int?
    
   var selectedType: selectScreenType?
   var userType:String?
    var name:String?
    var email:String?
    var city:String?
    var currentLocation:String?
    var currentLatitude:String?
    var currentLangitude:String?
    var driverloginModel:LoginModel?
    var clientLogModel:ClientLoginModel?
    
    //var selectedSegment:String?
    
    var driverRegisterModel:DriverRegisterModel?
    
   var clientRegister:ClientRegisterModel?
   var driverUpdateDeviceModel:DriverUpdateDeviceLoginModel?
    
   override func viewDidLoad() {
        super.viewDidLoad()
       phoneNo.text = (selectedCountryCode ?? "") + (phoneNumber ?? "")
        print(city)
        txtOTP1.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP2.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP3.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP4.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP5.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP6.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        
        self.userId = UserDefaults.standard.string(forKey: "user_id")
        
    }
    
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendOTPBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBAction func verifyBtn(_ sender: UIButton) {
        currentLatitude = UserDefaults.standard.string(forKey: "lat")
        print(currentLatitude ?? "")
        currentLangitude = UserDefaults.standard.string(forKey: "long")
        print(currentLangitude ?? "")
        
        let all = "\(self.txtOTP1.text ?? "")"+"\(self.txtOTP2.text ?? "")"+"\(self.txtOTP3.text ?? "")"+"\(self.txtOTP4.text ?? "")"+"\(self.txtOTP5.text ?? "")"+"\(self.txtOTP6.text ?? "")"
        
                AuthManager.shared.varifyCode(smsCode: all) { [self] (success) in
                    if success {
        
        if self.selectedType == .Register{
            
            if self.userType == "driver"{
                
                
                self.submitDriverRegApiMetnod()
                
            }
            else{
                 self.clientRegisterApi()
            }
            
        }
        
        
        else if self.selectedType == .login{
            
            if self.userType == "driver"{
                driverUpdateDeviceApi()
            }
            else{
                clientLoginApiMetnod()
            }
            
        }

                    }
        
                    else {
//                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Something Wrong", view: self)
                    }
    }
    }
    
// MARK: Move cursor from one textfield to another textfield automatically
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text
        if text?.utf16.count == 1{
            switch textField {
            case txtOTP1:
                txtOTP2.becomeFirstResponder()
                break
            case txtOTP2:
                txtOTP3.becomeFirstResponder()
                break
            case txtOTP3:
                txtOTP4.becomeFirstResponder()
                break
            case txtOTP4:
                txtOTP5.becomeFirstResponder()
                break
            case txtOTP5:
                txtOTP6.becomeFirstResponder()
                break
            case txtOTP6:
                txtOTP6.resignFirstResponder()
                break
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case txtOTP1:
                txtOTP1.becomeFirstResponder()
                break
            case txtOTP2:
                txtOTP1.becomeFirstResponder()
                break
            case txtOTP3:
                txtOTP2.becomeFirstResponder()
                break
            case txtOTP4:
                txtOTP3.becomeFirstResponder()
                break
            case txtOTP5:
                txtOTP4.becomeFirstResponder()
                break
            case txtOTP6:
                txtOTP5.becomeFirstResponder()
                break
            default:
                break
            }
        }
    }
}

    
extension VerifyAccountVC{
    
    // driver registration api
    func submitDriverRegApiMetnod(){
        RegisterViewModel.Validation(viewController: self){
            var param = [String:Any]()
            param = [ "user_type": self.userType ?? "", "phone_number":self.phoneNumber ?? "", "full_name":self.name ?? "" ,"email": self.email ??
                      "", "current_location":self.currentLocation ?? "", "phone_verify":self.deviceID ?? "", "current_city":self.city ?? "", "current_latitude":self.currentLatitude ?? "", "current_longitude":self.currentLangitude ?? "", "phone_token":"gdssdfdhdfgfg"]
            print(param)
        
            RegisterViewModel.submitRegApi(viewController: self, parameters: param as NSDictionary) { (response) in
                print(response!)
                print("Success")
                self.driverRegisterModel = response
                print(self.driverRegisterModel?.data?.current_city ?? "")
                let tokkken = self.driverRegisterModel?.token?.access
                UserDefaults.standard.setValue(tokkken, forKey: "token")
                UserDefaults.standard.removeObject(forKey: "driverCity")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as! VehicleDetailsVC
                vc.deviceId = self.deviceID
                vc.currentCity = self.city
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    // MARK: driver update device api call
   
    func driverUpdateDeviceApi(){
        let param = ["phone_number":phoneNumber ?? "","phone_verify":deviceID  ?? ""]
        print(param)
        LoginViewModel.driverUpdateDeviceApi(viewController: self, parameter: param as NSDictionary){response in
            print(response!)
            self.driverUpdateDeviceModel = response
            self.driverloginApiMetnod()
//            CommonMethods.showAlertMessageWithOkAndCancel(title: Constant.TITLE, message: self.driverUpdateDeviceModel?.msg ?? Constant.BLANK, view: self) {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBar") as! MyTabBar
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
        }
    }
    
    // MARK: Driver Login api Api
    func driverloginApiMetnod(){
        let param = [ "phone_number":phoneNumber ?? "", "user_type" : userType ?? "","phone_token":"gdssdfdhdfgfg"] as [String : Any]
        print(param)
       LoginViewModel.LoginApi(viewcontroller: self, parameters: param as NSDictionary){
            (responseObject) in
            print("Success")
            self.driverloginModel = responseObject
            let approvalKey = self.driverloginModel?.approved
            let driverId = self.driverloginModel?.user_id
            UserDefaults.standard.set(driverId, forKey: "user_id")
           
           let userType = self.driverloginModel?.user_type
           UserDefaults.standard.set(userType, forKey: "user_type")
           
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
    
    // MARK: Client Register Api
    
    func clientRegisterApi(){
        var param = [String:Any]()
        param = ["phone_number": phoneNumber ?? "", "user_type":userType ?? 0, "phone_verify":deviceID ?? "","phone_token":"gdssdfdhdfgfg"]
        print(param)
        RegisterViewModel.ClientRegApi(viewController: self, parameters: param as NSDictionary) {
            response in
            self.clientRegister = response
            
            let userId = self.clientRegister?.data?.user_id
            UserDefaults.standard.setValue(userId, forKey: "user_ID")
                       
                       let profileStatus = self.clientRegister?.profile ?? 0
                       UserDefaults.standard.setValue(profileStatus, forKey: "profile")
                       
                       let tokkken = self.clientRegister?.token?.access
                       UserDefaults.standard.setValue(tokkken, forKey: "token")
            
            let refresh_tokkken = self.clientRegister?.token?.refresh ?? ""
            UserDefaults.standard.setValue(refresh_tokkken, forKey: "refresh_token")
            
            
            let vc = self.storyboard?.instantiateViewController(identifier: "ClientTabBarViewController") as! ClientTabBarViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
  
     // MARK: - Client Login Api
     func clientLoginApiMetnod(){
     let param = [ "phone_number":phoneNumber ?? "", "user_type" : userType ?? 0,"phone_token":"gdssdfdhdfgfg"] as [String : Any]
     print(param)
     LoginViewModel.ClientLoginApi(viewcontroller: self, parameters: param as NSDictionary){
     (responseObject) in
     print("Success")
     self.clientLogModel = responseObject
     
         let userId = self.clientLogModel?.user_id
         UserDefaults.standard.setValue(userId, forKey: "user_ID")
         
         
         let profileStatus = self.clientLogModel?.profile ?? 0
         UserDefaults.standard.setValue(profileStatus, forKey: "profile")
                    
         let tokkken = self.clientLogModel?.token?.access
         UserDefaults.standard.setValue(tokkken, forKey: "token")
                    
         let refresh_tokkken = self.clientLogModel?.token?.refresh ?? ""
         UserDefaults.standard.setValue(refresh_tokkken, forKey: "refresh_token")
     
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientTabBarViewController") as! ClientTabBarViewController
     self.navigationController?.pushViewController(vc, animated: true)
     
     }
     }
     
     }
