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
    
    // for driver
    
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
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: "something went wrong" , view: viewcontroller)
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
    
    
    //for client
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
