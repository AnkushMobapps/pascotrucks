//
//  LogoutViewModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 12/06/24.
//

import Foundation
import UIKit

class LogoutViewModel{
    static var shareInstance = LoginViewModel()
    
    class func LogoutApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(LogoutModel?)->Void){
        DataManager.alamofireNewPostwithHadderRequest(url: clientLogout_Url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){
            (response, error) in
            if let responseData = response{
                let userData = try! JSONDecoder().decode(LogoutModel.self, from: responseData)
                print(userData)
                if userData.Status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
    }
}
