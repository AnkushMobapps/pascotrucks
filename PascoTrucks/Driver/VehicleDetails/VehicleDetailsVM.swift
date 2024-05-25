//
//  VehicleDetailsVM.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 01/05/24.
//

import Foundation
import UIKit

class VehicleDetailsVM{
    
    class func TransporterListApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(TransporterModel?)->Void) {
        
        DataManager.alamofireNewGetRequest(url: transporterUrl, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            
            print(response!)
            
            if let responseData = response {
                
                let userData = try! JSONDecoder().decode(TransporterModel.self, from: responseData)
                
                if userData.status == Constant.SUCCESS {
                    
                    completion(userData)
                }else {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: "hjagsdfjas" , view: viewcontroller)
                }
            }
        }
    }
    
    // MARK: - vehicle list API
    
    class func VehicleListApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(VehicleModel?)->Void) {
        
        DataManager.alamofireNewVehicleListPostRequest(url: vehicleListUrl, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
            
            print(response!)
            
            if let responseData = response {
                
                let userData = try! JSONDecoder().decode(VehicleModel.self, from: responseData)
                
                if userData.status == Constant.SUCCESS {
                    
                    completion(userData)
                }else {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: "something went wrong" , view: viewcontroller)
                }
            }
        }
    }
    
//    // MARk: - country list API
//    class func CountryListApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(CountryListModel?)->Void) {
//        
//        DataManager.alamofireNewGetRequest(url: countryListUrl, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
//            
//            print(response!)
//            
//            if let responseData = response {
//                
//                let userData = try! JSONDecoder().decode(CountryListModel.self, from: responseData)
//                
//                if userData.status == Constant.SUCCESS {
//                    
//                    completion(userData)
//                }else {
//                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: "something went wrong" , view: viewcontroller)
//                }
//            }
//        }
//    }
    
//    // MARk: - city list API
//    class func CityListApi(viewcontroller:UIViewController,parameters: NSDictionary, completion: @escaping(CityListModel?)->Void) {
//        
//        DataManager.alamofireNewPostRequest(url: cityListUrl, viewcontroller: viewcontroller, parameters: parameters as? [String:AnyObject]){ (response, error) in
//            
//            print(response!)
//            
//            if let responseData = response {
//                
//                let userData = try! JSONDecoder().decode(CityListModel.self, from: responseData)
//                
//                if userData.status == Constant.SUCCESS {
//                    
//                    completion(userData)
//                }else {
//                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: "something went wrong" , view: viewcontroller)
//                }
//            }
//        }
//    }
    
    // MARK: - Approval API
    class func ApprovalApijjjj(viewController:UIViewController, parameter:NSDictionary,image1:Data,image2:Data,image3:Data,imgName1:String,imgName2:String,imgName3:String,completion: @escaping(ApprovalModel?)->Void){
        DataManager.alamofireUploadThreeImage(urlmethod: "http://69.49.235.253:8090/api/approvalrequest/", parameter: parameter as! [String:AnyObject], userImage1: image1, userImage2: image2, userImage3: image3, imageName1:imgName1 , imageName2: imgName2, imageName3: imgName3, fileType: "image/jpeg", viewcontroller: viewController){(response, error) in
            print(response!)
            if let responseData = response{
                let userData = try! JSONDecoder().decode(ApprovalModel.self, from: responseData)
                if userData.status == Constant.SUCCESS{
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title:Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
    }
    
    
    //vehicle details form api
    class func ApprovalApi(viewController:UIViewController, parameters:NSDictionary, Image:Data,frontImage:Data,backImage:Data, ImgName:String,frontImageName:String,backImageName:String, completion: @escaping (ApprovalModel) -> Void) {
            
            
            
            DataManager.alamofireUpload3ImagePostApi(urlmethod: "http://69.49.235.253:8090/api/approvalrequest/", parameter: parameters as! [String : Any], userImage: Image, frontImage: frontImage, backImage: backImage, frontImageName: frontImageName, backImageName: backImageName, imageName: ImgName, fileType: "image/jpeg", viewcontroller: viewController) { (response, error) in
                //
                print(response!)
                
                if let responseData = response {
                    
                    let userData = try! JSONDecoder().decode(ApprovalModel.self, from: responseData)
                    if userData.status == "True" {
                        completion(userData)
                    }else {
                        
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message:"failed", view: viewController)
                    }
                }
            }
        }
    
    
    // vehicle details get and update api
    class func getVehicleDataApi(viewController:UIViewController, parameters:NSDictionary, completion:@escaping(vehicleApprove) -> Void){
        
        DataManager.alamofirewithhadderNewGetRequest(url: "http://69.49.235.253:8090/api/updateapprovalstatus/", viewcontroller: viewController, parameters: parameters as! [String : AnyObject]?){responseObject, responseDict in
        if let responseData = responseObject{
                let userData = try! JSONDecoder().decode(vehicleApprove.self, from: responseData)
                if userData.status == "True" {
                    completion(userData)
                }
                else if userData.status == "False" {
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg ?? Constant.BLANK, view: viewController)
                }
            }
        }
    }  
    // update vehicle details viewModel api
    class func updateVehicleDataApi(viewController:UIViewController, parameter:NSDictionary,image1:Data,image2:Data,image3:Data,imageName1:String,imageName2:String,imageName3:String, completion:@escaping(UpdareVehicleDataModel)->Void){
        DataManager.alamofireUpload3ImagePutApi(urlmethod: "http://69.49.235.253:8090/api/updateapprovalstatus/", parameter: parameter as!  [String:AnyObject], userImage1: image1, userImage2: image2, userImage3: image3, imageName1: imageName1, imageName2: imageName2, imageName3: imageName3, fileType: "image/jpeg", viewcontroller: viewController){
            (response,error) in
            print(response!)
            if let responseData = response{
                let userData = try! JSONDecoder().decode(UpdareVehicleDataModel.self, from:responseData )
                if userData.status == "True"{
                    completion(userData)
                }
                else{
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: userData.msg, view: viewController)
                }
            }
        }
    }
    
    
}




    




