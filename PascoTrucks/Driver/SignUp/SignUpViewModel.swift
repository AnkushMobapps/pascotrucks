//
//  SignUpViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 29/04/24.
//

import Foundation
import UIKit
class SignUpViewModel{
    let shareInstance = SignUpViewModel()
    
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
}


