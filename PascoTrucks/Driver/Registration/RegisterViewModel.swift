//
//  RegisterViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 04/05/24.
//

import Foundation
import UIKit
class RegisterViewModel{
    let shareInstance = RegisterViewModel()
 
    
    // MARK: - VerifyAccountVC OTP textfileds validation
    class func Validation(viewController:VerifyAccountVC, completion:@escaping()->Void){
        if viewController.txtOTP1.text == Constant.BLANK {
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill empty OTP field", view: viewController)
        }
        else if viewController.txtOTP2.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill empty OTP field", view: viewController)
        }
        else if viewController.txtOTP3.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill empty OTP field", view: viewController)
        }
        else if viewController.txtOTP4.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill empty OTP field", view: viewController)
        }
        else if viewController.txtOTP5.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill empty OTP field", view: viewController)
        }
        else if viewController.txtOTP5.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill empty OTP field", view: viewController)
        }
        else{
            completion()
        }
    }
    
    // MARK: - CompleteRegistrationVC textfileds validation

    class func Validation(viewController:CompleteRegistrationVC, completion:@escaping()->Void){
        if viewController.nameTxt.text == Constant.BLANK {
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill your name", view: viewController)
        }
        else if viewController.phoneNoTxt.text?.count ?? 0>10 || viewController.phoneNoTxt.text?.count ?? 0<10{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "phone no digit should be 10", view: viewController)
        }
        else if viewController.countryCode.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill the country code", view: viewController)
        }
        else if viewController.emailTxt.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill the email", view: viewController)
        }
        else if viewController.emailTxt.text?.isValidEmail() == false{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill the correct email", view: viewController)
        }
        else if viewController.cityTxt.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please select a city", view: viewController)
        }
        else{
            completion()
        }
    }
    
    
    
    
    // MARK: - Register API

    class func chekRegNumberApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ChekRegisterNUmberModel?) -> Void) {
        DataManager.alamofireNewPostRequest(url: chekRegNum_Url, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(ChekRegisterNUmberModel.self, from: userResponse)
                if userData.status == "True" {
                    completion(userData)
                }

                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
       }
    }
  class func submitRegApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (DriverRegisterModel?) -> Void) {
        DataManager.alamofireNewPostRequest(url:driver_complete_registration_Url , viewcontroller: viewController, parameters: parameters as?  [String : AnyObject]){
            (response, error) in
            print(response!)
            if let responseData = response {
                let userData = try! JSONDecoder().decode(DriverRegisterModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
                }
            }
        }
        
    }
    
    
    // MARK: - Client Register ViewModel
    
    class func ClientRegApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ClientRegisterModel?) -> Void) {
        DataManager.alamofireNewPostRequest(url:cleintRegister_Url , viewcontroller: viewController, parameters: parameters as?  [String : AnyObject]){
            (response, error) in
            print(response!)
            if let responseData = response {
                let userData = try! JSONDecoder().decode(ClientRegisterModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
                }
            }
        }
        
    }
    
}
