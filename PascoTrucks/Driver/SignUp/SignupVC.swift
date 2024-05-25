//
//  SignupVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 16/04/24.
//

import UIKit
import FirebaseAuth

enum selectScreenType {
    case login
    case Register
  }

class SignupVC: UIViewController{

    // var signUpModel:SignUpModel?
    @IBOutlet weak var countryCodeTxt: UILabel!
    @IBOutlet weak var phoneNoTxt: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var selectedProfile:UIImage?
    var selectedSegment:String?
    var chekRegNumModel:ChekRegisterNUmberModel?
    var deviceNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 0
        selectedProfile = UIImage(imageLiteralResourceName: "maskgroup")
        selectedSegment = "user"
        deviceID()
    }
    
    
    // MARK: - Device ID
    
    func deviceID(){
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        deviceNumber = deviceId
               print(deviceId)
    }
    
    
    @IBAction func segmentBtnClk(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = "user"
        }
        else if sender.selectedSegmentIndex == 1 {
            selectedSegment = "driver"
        }
    }
    
    
    @IBAction func countryCodeBtnclk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryCodeVC") as! CountryCodeVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.CountryCodeDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        chekNumberApi()
   }
    
    @IBAction func goToLoginBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


    // MARK: - Chek Number Api
    
    func chekNumberApi(){
        let param = ["phone_number":phoneNoTxt.text ?? "","user_type":selectedSegment ?? ""]
        print(param)
        SignUpViewModel.chekRegNumberApi(viewController: self, parameters: param as NSDictionary){(response) in
            print("success")
            self.chekRegNumModel = response
        
            
            let value = self.chekRegNumModel?.exists
            if value == 1{
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: self.chekRegNumModel?.msg ?? Constant.BLANK, view: self)
            }
            else {
            let phoneNo = "+91\(self.phoneNoTxt.text ?? "")"
                AuthManager.shared.startAuth(phoneNumber: phoneNo) { (success) in
                    
                    if success {
                        let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountVC") as! VerifyAccountVC
                        vc.selectedType = .Register
                        vc.phoneNumber = self.phoneNoTxt.text
                        vc.deviceID = self.deviceNumber
                        vc.userType = self.selectedSegment
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else {
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Something Wrong", view: self)
                    }
                }
            }
            
        }
    }
}

// MARK: - SelectCountryCode

extension SignupVC:SelectCountryCode{
    func selectCCnCode(countryId: String){
        countryCodeTxt.text = countryId
    }
}
