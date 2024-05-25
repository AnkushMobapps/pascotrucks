//
//  NotificationViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 18/05/24.
//

import Foundation
import UIKit
class NotificationViewModel{
    // MARK: show Notification Model
    class func showNotificationApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(ShowNotificationModel)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: driverShowNotificationUrl, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response, error) in
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(ShowNotificationModel.self, from: userResponse)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
}
  // MARK: count notification model
    class func countNotificationApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(CountNotificationModel)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: driverCountNotificationUrl, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response, error) in
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(CountNotificationModel.self, from: userResponse)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
}
    
 // MARK: delete perticular notification model
    class func deletePerticularNotifiApi(viewController:UIViewController, parameters:NSDictionary,completion:@escaping(DeletePerticularNotifiModel?)->Void){
        DataManager.alamofireNewPostwithHadderRequest(url:driverDeletePertNotifiUrl, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response, error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(DeletePerticularNotifiModel.self, from: userResponse)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg , view: viewController)
                }
            }
            
        }
    }
    
    
// MARK: - clear All notification model
    class func clearAllNotifiApi(viewController:UIViewController,parameter:NSDictionary,completion:@escaping(ClearAllNotifiModel?)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: driverClearAllNotifiUrl, viewcontroller: viewController, parameters: parameter as? [String:AnyObject]){
            (response,error) in
            print(response!)
            if let userResponse = response{
                let userData = try! JSONDecoder().decode(ClearAllNotifiModel.self, from: userResponse)
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


