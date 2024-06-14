//
//  DriverOrderViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 10/06/24.
//

import Foundation
import UIKit
class DriverOrderViewModel{
    class func getDriverBidingStatusApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverBidingStatusModel?)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: driverBidingstatus_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverBidingStatusModel.self, from: responseData)
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
