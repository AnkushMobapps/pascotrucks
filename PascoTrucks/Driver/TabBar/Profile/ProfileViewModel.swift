//
//  ProfileViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 03/05/24.
//

import Foundation
import UIKit
class ProfileViewModel{
let shareInstance = ProfileViewModel()
 // MARK: - Get Profile Details
//http://69.49.235.253:8090/api/user-update-profile/
    
    class func getProfileDetails(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(ProfileDataModel) -> Void){
        
        DataManager.alamofirewithhadderNewGetRequest(url: getDriverProfileData_Url, viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
        if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(ProfileDataModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
                }
            }
        }
    }
   
}
