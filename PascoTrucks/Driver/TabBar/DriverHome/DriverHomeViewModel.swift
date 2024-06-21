//
//  DriverHomeViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 17/05/24.
//

import Foundation
import UIKit

class DRiverHomeViewModel{
    
    
// MARK: - On Off Duty api
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
    
    
// MARK: - Get Order Request From client
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
    
// MARK: - Biding details
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
  
// MARK: - confirm order validation
    class func COValidation(viewController:OrderVC, completion:@escaping()->Void){
        
        if viewController.bidPrice.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Please enter bid price", view: viewController)
        }
        else if viewController.driverAvailability.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please select date and time", view: viewController)
         }
       
      else{
            completion()
        }
    }
    
// MARK: - confirm order api
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
    
// MARK: - update driver location
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
    
// MARK: - Driver Complete Booking
    //driverCompleteBooking_url+myId
    /*
     let id = viewController.driverConfirmBDM?.data?.id ?? 0
     print(id)
     let myId = String(id)+"/"
     */
    class func driverCompleteBookingApi(viewController:CurrentLocationOfOrderVC,parameters:NSDictionary,completion:@escaping(driverCompleteBookingModel?)->Void){
        let id = viewController.driverConfirmBDM?.data?.id ?? 0
        print(id)
        let myId = String(id)+"/"
        DataManager.alamofireNewPostwithHadderRequest(url:driverCompleteBooking_url+myId , viewcontroller: viewController, parameters: parameters as? [String:AnyObject]) {(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(driverCompleteBookingModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }
    }
    
// MARK: - Driver Start Trip
    class func driverStartTripApi(viewController:CurrentLocationOfOrderVC,parameters:NSDictionary,completion:@escaping(driverStartTripModel?)->Void){
        let id = viewController.driverConfirmBDM?.data?.id ?? 0
        print(id)
        let myId = String(id)+"/"
        DataManager.alamofireNewPostwithHadderRequest(url:driverStartTrip_url+myId , viewcontroller: viewController, parameters: parameters as? [String:AnyObject]) {(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(driverStartTripModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }
    }
    
    // MARK: - Near By Driver List Api
 //NearbyVehicle/
    class func nearByDriverListApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(NearByDriverModel?)->Void){
       
        DataManager.alamofireNewPostwithHadderRequest(url: nearBtDriverList_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]) {(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(NearByDriverModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }
    }
   
 // MARK: - Help Request to perticular driver
 //NearbyVehicle/
    class func helpReqToPerticularDriverApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(PerticularDriverHelpReqModel?)->Void){
        let id = parameters["driver_id"] as? Int
        print(id ?? 0)
        let myId = String(id ?? 0)+"/"
        print(myId)
        DataManager.alamofireNewPostwithHadderRequest(url: perDriEmrHelp_url+myId, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]) {(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(PerticularDriverHelpReqModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }
    }
    
// MARK: - emergency Contact List
    class func EmergencyContactListApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(EmergencyContactListModel?)->Void){
       
        DataManager.alamofirewithhadderNewGetRequest(url: driverEmergContactList_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(EmergencyContactListModel.self, from: responseData)
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
