//
//  reqeustOrderViewModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 17/06/24.
//

import Foundation
import UIKit

class RequestOrderViewModel{
    let shareInstance = RequestOrderViewModel()

class func requestOrderApi(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(resqustOrderModel) -> Void){
    
    DataManager.alamofirewithhadderNewGetRequest(url: orderRequestApi, viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
    if let responseData = responseObject{
            let userData = try! JSONDecoder().decode(resqustOrderModel.self, from: responseData)
            if userData.status == "True" {
                completion(userData)
            }
            else if userData.status == "False" {
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
            }
        }
    }
}

    // MARK: AllBidsViewModel
    
    
    class func allBidsApi(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(AllBidsModel) -> Void){
        
        DataManager.alamofirewithhadderNewGetRequest(url: allBids_Url, viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
        if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(AllBidsModel.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
                }
            }
        }
    }


    // MARK: Active Status ViewModel
    
    class func AcceptOrderApi(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(ActiveOrderModel) -> Void){
        
        DataManager.alamofirewithhadderNewGetRequest(url: acceptOrder_Url, viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
        if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(ActiveOrderModel.self, from: responseData)
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
