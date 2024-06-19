//
//  OrderDetailsViewModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 18/06/24.
//

import Foundation
import UIKit

class OrderDetailsViewModel{
    let shareInstance = OrderDetailsViewModel()
    
    
    class func orderDetailsApi(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(OrderdetailsModel) -> Void){
        
        let param = parameters["id"] as? Int
               print(param)
               let myid = String(param ?? 0)+"/"
             
        
        DataManager.alamofirewithhadderNewGetRequest(url: orderDetails_Url+myid, viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
            if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(OrderdetailsModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
                }
            }
        }
    }
    
    
    // MARK: Assign Job ViewModel
    
    class func assignBookingApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(AssignBookingModel?)->Void) {
        
        let param = parameters["id"] as? Int
               print(param)
               let myid = String(param ?? 0)+"/"
        
        DataManager.alamofireNewPostwithHadderRequest(url:assignBooking_Url+myid, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            print(response!)
            
            if let responseData = response {
                let userData = try! JSONDecoder().decode(AssignBookingModel.self, from: responseData)
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
