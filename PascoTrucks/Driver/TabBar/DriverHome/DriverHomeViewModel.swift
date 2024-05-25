//
//  DriverHomeViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 17/05/24.
//

import Foundation
import UIKit
class DRiverHomeViewModel{
    class func getOrderRequestFromClient(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(BookingRecordListModel?)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: "http://69.49.235.253:8090/api/showbookingriderequests/", viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(BookingRecordListModel.self, from: responseData)
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
