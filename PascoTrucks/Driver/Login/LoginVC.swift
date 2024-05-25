//
//  LoginVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 16/04/24.
//

import UIKit

class LoginVC: UIViewController{
    var selecttypestr:String?
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var countryCodeTxt: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var selectedSegment:String?
    var chekdriverLoginModel:CheckLoginModel?
    var driverloginModel:LoginModel?
    var clientCheckLogModel:CheckClientLoginModel?
    var clientLogModel:ClientLoginModel?
    // var user_Type:String?
    var deviceNumber:String?
    
    var verfiedId:String?
    var driverID:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTF.text = "1919191919"
        selectedSegment = "user"
        loginBtn.GradientColor(colorOne: #colorLiteral(red: 0.8352941176, green: 0.6549019608, blue: 0.3764705882, alpha: 1), colorTwo: #colorLiteral(red: 0.6117647059, green: 0.4705882353, blue: 0.231372549, alpha: 1))
        
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    // MARK: - Device ID
    
    func deviceID(){
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        deviceNumber = deviceId
               print(deviceId)
    }
    
    
    
    
    
    
    
    
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
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
    
    @IBAction func countryCodeBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryCodeVC") as! CountryCodeVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        //  vc.viaLoginStr = "yes"
        vc.CountryCodeDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
        
        
        
        if segmentedControl.selectedSegmentIndex == 0{
            // for client
            clientCheckLoginApi()
        }
        else if segmentedControl.selectedSegmentIndex == 1{
            //for driver
            checkLoginApi()
        }
        
    }
    
    
    @IBAction func goToSignUpBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension LoginVC:selectList{
    func selcetrow(rowid: String, typeID: Int?) {
        countryCodeTxt.text = rowid
    }
    
}

// MARK: -  *******  API ******

extension LoginVC {
    func checkLoginApi(){
        let param = ["phone_number":phoneTF.text ?? "","user_type":selectedSegment ?? "","phone_verify":"mahi"]
        print(param)
        LoginViewModel.checkLoginApi(viewController: self, parameters: param as NSDictionary){(response) in
            print("success")
            self.chekdriverLoginModel = response
            let logindevice = self.chekdriverLoginModel?.login
            
            if logindevice == 1{
                           self.driverloginApiMetnod()
                       }
                       else{
                           // CommonMethods.showAlertMessageWithOkAndCancel(title: Constant.TITLE, message: "Verify Your Account", view: self) {
                           let phoneNo = "+91\(self.phoneTF.text ?? "")"
                           // AuthManager.shared.startAuth(phoneNumber: phoneNo) { (success) in
                           
                           // if success {
                           let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
                           vc.selectedType = .login
                           vc.phoneNumber = self.phoneTF.text
//                           vc.deviceID = self.newDeviceId
                           vc.userType = self.selectedSegment
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
    
    func verifyDeviceLogin(){
        
    }
    
    // Login Api Same Device
    // driverLogin
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
    
    
    //client
    //checkLogin
    func clientCheckLoginApi(){
        let param = ["phone_number":phoneTF.text ?? "","user_type":selectedSegment ?? "","phone_verify":deviceNumber]
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

extension LoginVC:SelectCountryCode{
    func selectCCnCode(countryId: String) {
        countryCodeTxt.text = countryId
    }
}






