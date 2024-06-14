//
//  AddtionalServiceViewModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 13/06/24.
//

import Foundation
import UIKit

class AddtionalServiceViewModel{
    static var shareInstance = AddtionalServiceViewModel()
    
    class func addtionalServiceApi(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(AddtioalServiceModel) -> Void){
        
        DataManager.alamofirewithhadderNewGetRequest(url: addtionalService_Url, viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
            if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(AddtioalServiceModel.self, from: responseData)
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
