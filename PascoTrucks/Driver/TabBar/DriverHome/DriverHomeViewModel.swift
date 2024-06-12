//
//  DriverHomeViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 17/05/24.
//

import Foundation
import UIKit
class DRiverHomeViewModel{
    class func onOffDutyApi(view:UIView, parameter:NSDictionary,completion:@escaping(MarkOnAndOffDutyModel)->Void){
        DataManager.alamofirePutwithHadderRequest(url: onOffDuty_url, view: view, parameters: parameter as? [String:AnyObject]){ (responseObject, responseDict) in
            if let responseData = responseObject{
                let userData = try!JSONDecoder().decode(MarkOnAndOffDutyModel.self, from:responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
//                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: view)
                    print("something went wrong")
                }
            }
         }
    }
    
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
    
  //biding details
    class func updatebookingbid(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(UpdateBookingBidsModel?)->Void){
        let id = parameters["id"] as? Int
               print(id)
               let myId = String(id ?? 0)+"/"
              print(myId)
        DataManager.alamofirewithhadderNewGetRequest(url: updateBidingDetails_url+myId, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(UpdateBookingBidsModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
            
        }
    }
    
    
    //confirm order api
    class func confirmOrderApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(ConfirmOrderModel?)->Void){
        let id = parameters["id"] as? Int
               print(id)
               let myId = String(id ?? 0)+"/"
              print(myId)
        DataManager.alamofireNewPutwithHadderRequest(url: confirmOrder_url+myId, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(ConfirmOrderModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }
    }
    
    
    ///2024-04-12 15:30:00
    
    
    //update driver location api

    class func updateDriverLocationApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(UpdateDriverLocationModel?)->Void){
       
        DataManager.alamofireNewPostwithHadderRequest(url: driverUpdateLocation_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]) {(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(UpdateDriverLocationModel.self, from: responseData)
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
