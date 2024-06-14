//
//  PaymentMethodViewModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 13/06/24.
//

import Foundation
import UIKit

class PaymentMethodViewModel{
    static var shareInstance = PaymentMethodViewModel()
    
    
    class func bookRideApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(PaymentMethodModel?)->Void) {
        
        DataManager.alamofireNewPostwithHadderRequest(url:paymentMethod_url, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            print(response!)
            
            if let responseData = response {
                let userData = try! JSONDecoder().decode(PaymentMethodModel.self, from: responseData)
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
    
    
 // MARK: - Cargo Qty ViewModel
    
    class func CargoQtyApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(CargoQtyModel?)->Void) {
        
        DataManager.alamofireNewPostwithHadderRequest(url:cargoQty_Url, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            print(response!)
            
            if let responseData = response {
                let userData = try! JSONDecoder().decode(CargoQtyModel.self, from: responseData)
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
    
    
 // MARK: Chek Charges ViewModel
    
    class func chekChargesApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(ChekChargesModel?)->Void) {
        
        DataManager.alamofireNewPostwithHadderRequest(url:chekCharges_Url, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            print(response!)
            
            if let responseData = response {
                let userData = try! JSONDecoder().decode(ChekChargesModel.self, from: responseData)
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
