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

    // var signUpModel:SignUpModel?
   
    @IBOutlet weak var countryCodeTxt: UITextField!
    @IBOutlet weak var phoneNoTxt: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var selectedProfile:UIImage?
    var selectedSegment:String?
    var chekRegNumModel:ChekRegisterNUmberModel?
    var deviceNumber:String?
   // var countryCode:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryCodeTxt.delegate = self
        segmentedControl.selectedSegmentIndex = 0
        selectedProfile = UIImage(imageLiteralResourceName: "maskgroup")
        selectedSegment = "user"
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
    
    
    @IBAction func segmentBtnClk(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = "user"
        }
        else if sender.selectedSegmentIndex == 1 {
            selectedSegment = "driver"
        }
    }
    
    

    
    @IBAction func nextBtnClick(_ sender: UIButton) {
     //chekNumberApi()
   }
    
    @IBAction func goToLoginBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

/*
//  TextDemoVC.swift
//  CustomAlert
//
//  Created by Nitin Chauhan on 27/05/24.
//

import UIKit

class TextDemoVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate of the text field
        textField.delegate = self
    }
    
    // UITextFieldDelegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text, and the proposed new text
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Check if this is the first character being added
        if currentText.isEmpty && !string.isEmpty {
            textField.text = "+" + string
            return false // Return false because we've manually changed the text
        }
        
        return true // Allow the text change
    }
}


14:34

*/
