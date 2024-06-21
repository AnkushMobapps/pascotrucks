//
//  DriverNotesViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 11/06/24.
//

import Foundation
import UIKit
class DriverNotesViewModel{
    
    // add notes api
    class func driverAddNoteApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverNoteModel?)->Void){
        
        DataManager.alamofireNewPostwithHadderRequest(url: driverAddNote_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]) {(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverNoteModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }
    }
    
  // get notes api
    class func driverGetNotesApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(DriverGetNotesModel?)->Void){
        
        DataManager.alamofirewithhadderNewGetRequest(url: driverGetNote_url, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(DriverGetNotesModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }

    }
    
    
    //driverDeleteNoteModel
    class func driverDeleteNotesApi(viewController:UIViewController,parameters:NSDictionary,completion:@escaping(driverDeleteNoteModel?)->Void){
        
//        let id = viewController.noteAndReminderTa
        let param = parameters["Id"] as? Int
        print(param)
        let myid = String(param ?? 0)+"/"
        print(myid)
        
        DataManager.alamofirewithhadderNewGetRequest(url: driverDeleteNote_url+myid, viewcontroller: viewController, parameters: parameters as? [String:AnyObject]){(response , error) in
            print("success")
            if let responseData = response{
                let userData = try! JSONDecoder().decode(driverDeleteNoteModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else{
//                    CommonMethods.showAlertMessage(title: Constant.TITLE, message:userData.msg, view: viewController)
                }
            }
        }

    }
}

/*
 
    class func BidsJob(ViewController:UIViewController,Parameter:NSDictionary,Complition:@escaping (BidsModel?)-> Void) {
        let param = Parameter["request_id"] as? Int
        print(param)
        let myid = String(param ?? 0)+"/"
        print(Show_Bids+myid)
        ServiceHandler.alamofireGetRequestWithHeader(url: Show_Bids+myid, viewcontroller: ViewController) { (responseObject, responseDict) in
            if let responseData = responseObject {
                let userData = try! JSONDecoder().decode(BidsModel.self, from: responseData)
                if userData.Status == "True" {
                    Complition(userData)
                }
                else if userData.Status == "False" {
                    CommonMethods.showAlertMessage(title: "", message: userData.message ?? "", view: ViewController)
                }
            }
        }
 */
