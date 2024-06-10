//
//  LoginViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 29/04/24.
//

import Foundation
import UIKit

class LoginViewModel{
   static var shareInstance = LoginViewModel()
    
    // MARK: - Logn VC textfileds validation
    
    class func Validation(viewController:LoginVC, completion:@escaping()->Void){
        if viewController.phoneTF.text == Constant.BLANK {
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Please enter your Phone Number", view: viewController)
        }
     
        else if viewController.countryCodeTxt.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Please enter the country code", view: viewController)
        }
        else{
            completion()
        }
    }
    
    
    // MARK: - Driver All api methods are here
   
    class func LoginApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(LoginModel?)->Void) {
        
        DataManager.alamofireNewPostRequest(url: driver_login_Url, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            print(response!)
            
            if let responseData = response {
                let userData = try! JSONDecoder().decode(LoginModel.self, from: responseData)
                print(userData)
                if userData.status == Constant.SUCCESS {
                    completion(userData)
                }
                else {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg , view: viewcontroller)
                }
            }
        }
    }
    
    class func checkLoginApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(CheckLoginModel?)->Void){
        DataManager.alamofireNewPostRequest(url: driver_chek_login, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){
            (response, error) in
            if let responseData = response{
                let userData = try! JSONDecoder().decode(CheckLoginModel.self, from: responseData)
                print(userData)
                if userData.status == Constant.SUCCESS {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
    }
    
    class func driverUpdateDeviceApi(viewController:UIViewController, parameter:NSDictionary,completion:@escaping(DriverUpdateDeviceLoginModel?)->Void){
        DataManager.alamofireNewPostRequest(url: driver_update_deviceId_Url, viewcontroller: viewController, parameters: parameter as! [String:AnyObject]){
            (response, error) in
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(DriverUpdateDeviceLoginModel.self, from: userResponse)
                if userData.status == "True"{
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
                
            }
            
        }
    }
     
    class func driverLogOutApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverLogOutModel?)->Void){
        DataManager.alamofireLogOutNewPostRequest(url: driver_logout_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){
            (response, error) in
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverLogOutModel.self, from: responseData)
                print(userData)
                if userData.Status == Constant.SUCCESS {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
    }
    
   // MARK: - Client All api methods are here
    class func ClientLoginApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(ClientLoginModel?)->Void) {
        
        DataManager.alamofireNewPostRequest(url:"http://69.49.235.253:8090/api/user-login/", viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            print(response!)
            if let responseData = response {
                let userData = try! JSONDecoder().decode(ClientLoginModel.self, from: responseData)
                print(userData)
                if userData.status == Constant.SUCCESS {
                    completion(userData)
                }
                else {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: "something went wrong" , view: viewcontroller)
                }
            }
        }
    }
    
    
    class func ClientcheckLoginApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(CheckClientLoginModel?)->Void){
        DataManager.alamofireNewPostRequest(url:"http://69.49.235.253:8090/api/check-login/", viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){
            (response, error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(CheckClientLoginModel.self, from: responseData)
                print(userData)
                if userData.status == Constant.SUCCESS {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
    }
}
