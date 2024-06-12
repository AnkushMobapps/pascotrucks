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
}
