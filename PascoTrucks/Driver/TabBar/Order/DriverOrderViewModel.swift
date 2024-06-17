//
//  DriverOrderViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 10/06/24.
//

import Foundation
import UIKit
class DriverOrderViewModel{
    
    //driver biding status list
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
    
    
   //driver pending bid details
    class func driverPendingBisDetailsApi(viewController:DriverBidingDetailsVC,parameters:NSDictionary,completion:@escaping(DriverPendingBidDetailsModel?)->Void){
         
        let id = viewController.id ?? 0
        print(id)
        let myId = "\(id)"+"/"
        DataManager.alamofirewithhadderNewGetRequest(url: driverPendingBidDetails_url+myId, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverPendingBidDetailsModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
            
        }
    }
    
    
    //driver_status_list api
    class func driverStatusListApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverStatusListModel?)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: driverStatusList_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverStatusListModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
            
        }
    }
    
    //driver confirm bid deatils api
    //DriverConfirmBidDetailsModel
    class func driverConfirmBisDetailsApi(viewController:CurrentLocationOfOrderVC,parameters:NSDictionary,completion:@escaping(DriverConfirmBidDetailsModel?)->Void){
         
        let id = viewController.id ?? 0
        print(id)
        let myId = "\(id)"+"/"
        DataManager.alamofirewithhadderNewGetRequest(url: driverConfirmBidDetails_url+myId, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverConfirmBidDetailsModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
            
        }
    }
    
    //http://69.49.235.253:8090/api/bookdriver-ongoing/
    class func driverOngoingBidListApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverOngoingListModel?)->Void){
        DataManager.alamofirewithhadderNewGetRequest(url: driverOngoingBidList_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverOngoingListModel.self, from: responseData)
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
