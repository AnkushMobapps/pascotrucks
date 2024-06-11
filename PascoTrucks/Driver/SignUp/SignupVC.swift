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

class SignupVC: UIViewController, UITextFieldDelegate{


 
   
    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var phoneNoTxt: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var selectedProfile:UIImage?
    var selectedSegment:String?
    var chekRegNumModel:ChekRegisterNUmberModel?
    var deviceNumber:String?
   // var countryCode:String?
  var userType:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        countryCodeTxt.delegate = self
        self.countryCodeTxt.text = UserDefaults.standard.string(forKey: "countryCode")
        print( self.countryCodeTxt.text)
        deviceID()
       
    }
    //MARK: - country code + signwith code
    
    // UITextFieldDelegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text, and the proposed new text
        let currentText = countryCodeTxt.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Check if this is the first character being added
        if currentText.isEmpty && !string.isEmpty {
            countryCodeTxt.text = "+" + string
            return false // Return false because we've manually changed the text
        }
        return true // Allow the text change
    }
    
    // MARK: - Device ID
    
    func deviceID(){
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        deviceNumber = deviceId
               print(deviceId)
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
                    vc.userType = self.userType
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
