//
//  UpdateProfileViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 06/05/24.
//

import Foundation
import UIKit

class UpdateProfileViewModel{
    // MARK: - Update ProfileVC validation
    class func Validation(viewController:ProfileVC, completion:@escaping()->Void){
        if viewController.selectedProfile == nil{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please select any image", view: viewController)
        }
        else if viewController.nameTxt.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill driver name", view: viewController)
        }
        else if viewController.emailTxt.text == Constant.BLANK{
            CommonMethods.showAlertMessage(title: Constant.TITLE, message: "please fill driver email", view: viewController)
        }
      else{
            completion()
        }
    }
    class func updateProfileData(viewController:UIViewController, parameter:NSDictionary,image:Data,imageName:String, completion:@escaping(UpdareProfileModel)->Void){
        DataManager.alamofireNewUpdatePutRßequest(urlmethod: updateddriverProfiledata_Url, parameter:parameter as! [String : Any], userImage: image, imageName:imageName, fileType: "image/jpeg", viewcontroller: viewController ){ (responseObject, responseDict) in
            if let responseData = responseObject{
                let userData = try!JSONDecoder().decode(UpdareProfileModel.self, from:responseData)
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
