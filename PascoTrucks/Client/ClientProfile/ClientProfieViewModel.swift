//
//  ClientProfieViewModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 12/06/24.
//

import Foundation
import UIKit
class ClientProfileViewModel{
    
    // MARK: - Update ProfileVC validation
    class func Validation(viewController:ClientProfileVC, completion:@escaping()->Void){
        if viewController.selectedProfile == nil{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.emptyImage, view: viewController)
        }
        else if viewController.userNameTF.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.emptyNameTxt, view: viewController)
        }
        else if viewController.emailidTF.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.emptyEmailTxt, view: viewController)
        }
        else if viewController.emailidTF.text?.isValidEmail() == false{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: Constant.emailNotValid, view: viewController)
        }
      else{
            completion()
        }
    }
    class func clientUpdateProfileApi(viewController:UIViewController, parameter:NSDictionary,image:Data,imageName:String, completion:@escaping(ClientProfileModel)->Void){
        DataManager.alamofireNewUpdatePutRßequest(urlmethod: clientUpdateProfile_Url, parameter:parameter as! [String : Any], userImage: image, imageName:imageName, fileType: "image/jpeg", viewcontroller: viewController ){ (responseObject, responseDict) in
            if let responseData = responseObject{
                let userData = try!JSONDecoder().decode(ClientProfileModel.self, from:responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
                }
            }
         }
    }
    
    // MARK: - Get Profile ViewModel
    class func getProfileApi(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(GetProfileModel) -> Void){
        
        DataManager.alamofirewithhadderNewGetRequest(url: getProfile_Url, viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
        if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(GetProfileModel.self, from: responseData)
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
