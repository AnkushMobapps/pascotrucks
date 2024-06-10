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
        if (viewController.txtOTP1.text == Constant.BLANK || viewController.txtOTP2.text == Constant.BLANK || viewController.txtOTP3.text == Constant.BLANK || viewController.txtOTP4.text == Constant.BLANK || viewController.txtOTP5.text == Constant.BLANK || viewController.txtOTP6.text == Constant.BLANK){
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Please enter empty OTP field", view: viewController)
        }

        else{
            completion()
        }
    }
    
    
    // MARK: - CompleteRegistrationVC textfileds validation

    class func Validation(viewController:CompleteRegistrationVC, completion:@escaping()->Void){
        if viewController.nameTxt.text == Constant.BLANK {
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.emptyNameTxt, view: viewController)
        }
        else if viewController.emailTxt.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.emptyEmailTxt, view: viewController)
        }
        else if viewController.emailTxt.text?.isValidEmail() == false{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.emailNotValid, view: viewController)
        }
        else if viewController.countryCode.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.CountryCode, view: viewController)
        }
        else if viewController.phoneNoTxt.text == Constant.BLANK {
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.phoneNumber, view: viewController)
        }

        else if viewController.cityTxt.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.CityTEXTFIELD, view: viewController)
        }
        else{
            completion()
        }
    }
    
    
  // MARK: - Select City on behalf of country code api
    class func selectCityApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (SelectCityModel?) -> Void) {
        DataManager.alamofireNewPostRequest(url: selectCity_url, viewcontroller: viewController, parameters:parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(SelectCityModel.self, from: userResponse)
                if userData.status == "True" {
                    completion(userData)
                }

                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
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
