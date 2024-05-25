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
    
    var phoneNumber:String?
    var deviceID:String?
    var selectedType: selectScreenType?
    var userId:String?
    var userType:String?
    var clientRegister:ClientRegisterModel?
    var driverloginModel:LoginModel?
    var driverID:Int?
    var selectedSegment:String?
    var clientLogModel:ClientLoginModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtOTP1.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP2.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP3.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        txtOTP4.addTarget(self, action: #selector(self.textFieldDidChangeSelection), for: UIControl.Event.editingChanged)
        
        self.userId = UserDefaults.standard.string(forKey: "user_id")
        
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        
        let all = "\(self.txtOTP1.text ?? "")"+"\(self.txtOTP2.text ?? "")"+"\(self.txtOTP3.text ?? "")"+"\(self.txtOTP4.text ?? "")"+"\(self.txtOTP5.text ?? "")"+"\(self.txtOTP6.text ?? "")"
        
        AuthManager.shared.varifyCode(smsCode: all) { (success) in
            //            if success {
            //
            //                if self.selectedType == .Register{
            //                    if self.userType == "driver"{
            //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompleteRegistrationVC") as! CompleteRegistrationVC
            //                        vc.phonenumber = self.phoneNumber
            //                        vc.deviceId = self.deviceID
            //                        vc.userType = self.userType
            //                        self.navigationController?.pushViewController(vc, animated: true)
            //                    }
            //                    else{
            //                        self.clientRegisterApi()
            //                    }
            //
            //
            //                }
            //                else if self.selectedType == .login{
            //                    self.loginApiMetnod()
            //                }
            //
            //            }
            //            else {
            //                CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Something Wrong", view: self)
            //            }
            
            
            
            if self.userType ==  "driver"{
                
                if self.selectedType == .Register{
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompleteRegistrationVC") as! CompleteRegistrationVC
                    vc.phonenumber = self.phoneNumber
                    vc.deviceId = self.deviceID
                    vc.userType = self.userType
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    self.loginApiMetnod()
                }
                
            }
            
            
            else if self.userType ==  "user" {
                
                if self.selectedType == .Register{
                    self.clientRegisterApi()
                    
                }
                else{
                    self.clientLoginApiMetnod()
                }
                
            }
            
        }
    }
    
    
    @IBAction func goToSignInBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
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
                txtOTP5.resignFirstResponder()
                break
            case txtOTP5:
                txtOTP6.resignFirstResponder()
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
    
    
    // MARK: Client Register Api
    
    func clientRegisterApi(){
        let param = ["phone_number": phoneNumber ?? "", "user_type":userType ?? 0, "phone_verify":deviceID ?? ""] as [String : Any]
        print(param)
        RegisterViewModel.ClientRegApi(viewController: self, parameters: param as NSDictionary) {
            response in
            self.clientRegister = response
            
            let userId = self.clientRegister?.data?.user_id
            UserDefaults.standard.setValue(userId, forKey: "user_ID")
            
            let vc = self.storyboard?.instantiateViewController(identifier: "ClientTabBarViewController") as! ClientTabBarViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    
    // MARK: - Driver Login Api
    
    
    func loginApiMetnod(){
        let param = [ "phone_number":phoneNumber, "user_type" : selectedSegment ?? ""] as [String : Any]
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
            
            
            if approvalKey == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabBar") as! MyTabBar
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if approvalKey == 2 {
                CommonMethods.showAlertMessageWithHandler(title: Constant.TITLE, message: responseObject?.msg ?? Constant.BLANK, view: self) {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as! VehicleDetailsVC
                    vc.userID = self.driverloginModel?.user_id ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            else{
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: responseObject?.msg ?? Constant.BLANK, view: self)
            }
        }
    }
        
    // MARK: - Client Login Api
    func clientLoginApiMetnod(){
        let param = [ "phone_number":phoneNumber ?? "", "user_type" : selectedSegment ?? ""] as [String : Any]
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
