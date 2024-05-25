//
//  ClientHomeViewModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 16/05/24.
//

import Foundation
import UIKit
class ClientHomeViewModel{
    let shareInstance = ClientHomeViewModel()
// MARK: - Service List Api
    class func clientServicelistApi(viewController:UIViewController, parameters:NSDictionary,completion: @escaping (ClientServiceModel?) -> Void) {
        DataManager.alamofirewithhadderNewGetClientRequest(url: "http://69.49.235.253:8090/api/service-lists/", viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
        if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(ClientServiceModel.self, from: responseData)
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
