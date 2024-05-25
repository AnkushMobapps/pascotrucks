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
    
    // MARK: - Register API
    class func submitRegApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (RegisterModel?) -> Void) {
        DataManager.alamofireNewPostRequest(url:driver_complete_registration_Url , viewcontroller: viewController, parameters: parameters as?  [String : AnyObject]){
            (response, error) in
            print(response!)
            if let responseData = response {
                let userData = try! JSONDecoder().decode(RegisterModel.self, from: responseData)
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
