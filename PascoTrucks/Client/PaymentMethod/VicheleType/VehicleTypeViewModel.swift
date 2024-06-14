//
//  VehicleTypeViewModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 13/06/24.
//

import Foundation
import UIKit

class VehicleTypeViewModel{
    static var shareInstance = VehicleTypeViewModel()
    
    
    class func vehicleTypeApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(VehichleTypeModel?)->Void) {
        
        DataManager.alamofireNewPostwithHadderRequest(url:vehicleType_Url, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            print(response!)
            
            if let responseData = response {
                let userData = try! JSONDecoder().decode(VehichleTypeModel.self, from: responseData)
                print(userData)
                if userData.status == "True" {
                    completion(userData)
                }
                else {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg , view: viewcontroller)
                }
            }
        }
    }
}
