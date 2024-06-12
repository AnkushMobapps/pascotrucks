//
//  HistoryViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 12/06/24.
//

import Foundation
import UIKit
class HistoryViewModel{
    //complete order api
    class func completeOrderApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverShowCompleteOrderModel?)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: drivercompleteOrder_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverShowCompleteOrderModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
            
        }
    }
    // cancel order api
    class func cancelOrderApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverShowCancelOrderModel?)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: drivercancelOrder_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverShowCancelOrderModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
            
        }
    }
}

