//
//  DataManager.swift
//  Shamsaha
//
//  Created by Narendra Kumar on 04/05/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
import Foundation

class DataManager: NSObject {
    
    typealias completion = ((Data?, NSDictionary?)->())
    
    class func alamofireWithJSONPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String]?, completionHandler: @escaping completion) {
        print(parameters as Any)
      KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        /*
        let headers: HTTPHeaders = [
               "Content-Type": "application/json",
               "Accept-Language": "en",
               "Authorization": "Bearer yourAccessToken"
           ]*/
        
            AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
         
    }
    
    //for driver registration,check registrtaion number and ChekLOgin And Login, update device number
    class func alamofireNewPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
    // driver logout , update driver location
    class func alamofireLogOutNewPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        AF.request(url, method: .post, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
//    //for client registration cheklogin and login
//    class func alamofireNewClientPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
//        print(parameters as Any)
//        
//        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
//       AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
//                switch response.result {
//                case .success:
//                    print(response)
//                    if let data = response.data {
//                        print("JSON: \(data)")
//                        let jsonObject = JSON(data)
//                        print("JSON: \(jsonObject)")
//                        KRProgressHUD.dismiss()
//                        completionHandler(response.data, nil)
//                    }
//                    break
//                case .failure( _):
//                      KRProgressHUD.dismiss()
//                }
//            })
//    }
//    
    // for driver vehicle list
    class func alamofireNewVehicleListPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        AF.request(url, method: .post, parameters: parameters, headers: headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
         
    }
    
//    //for login driver
//    class func alamofireNewLOginPostRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
//        print(parameters as Any)
//        
//        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
//        AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
//                switch response.result {
//                case .success:
//                    print(response)
//                    if let data = response.data {
//                        print("JSON: \(data)")
//                        let jsonObject = JSON(data)
//                        print("JSON: \(jsonObject)")
//                        KRProgressHUD.dismiss()
//                        completionHandler(response.data, nil)
//                    }
//                    break
//                case .failure( _):
//                      KRProgressHUD.dismiss()
//                }
//            })
//         
//    }
    
    class func alamofireNewPostwithHadderRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        

        AF.request(url, method: .post, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
         
    }
    
    
    
    class func alamofireNewGetRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
          print(parameters as Any)
          
          KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
          AF.request(url, method: .get, parameters: parameters, headers:headerParam() ).responseData(completionHandler:{ response in
                  switch response.result {
                  case .success:
                      print(response)
                      if let data = response.data {
                          print("JSON: \(data)")
                          let jsonObject = JSON(data)
                          print("JSON: \(jsonObject)")
                          KRProgressHUD.dismiss()
                          completionHandler(response.data, nil)
                      }
                      break
                  case .failure( _):
                        KRProgressHUD.dismiss()
                  }
              })
      }
    
  
    
    //==========APi with token hadder get method ===========
    //profile get data api , vehicle get data api , home order request from client , showNotification,UpdateBookingBids
    
    class func alamofirewithhadderNewGetRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
   
        AF.request(url, method: .get, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
//    //==========APi with token hadder put method ===========
//    class func alamofirewithhadderPutRequestApi(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
//        print(parameters as Any)
//        
//        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
//         AF.request(url, method: .put, parameters: parameters, headers:DataManager.headerParam() ).responseData(completionHandler:{ response in
//                switch response.result {
//                case .success:
//                    print(response)
//                    if let data = response.data {
//                        print("JSON: \(data)")
//                        let jsonObject = JSON(data)
//                        print("JSON: \(jsonObject)")
//                        KRProgressHUD.dismiss()
//                        completionHandler(response.data, nil)
//                    }
//                    break
//                case .failure( _):
//                      KRProgressHUD.dismiss()
//                }
//            })
//    }
    
    //==========APi with token hadder get method ===========
    //client service data api
    
    class func alamofirewithhadderNewGetClientRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        let headers: HTTPHeaders = [
                       "Accept": "application/json",
                       "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxMDQyNjAxLCJpYXQiOjE3MTU4NTg2MDEsImp0aSI6ImFlZTk4MmU3MTM4MDRjNDg4NDE1NGVhYzdhMWEwNDJlIiwidXNlcl9pZCI6OTN9.X6Mv6_Ov8CJxJa4bFaXg8IWs_zvG2zf33e1Wg3nZhJo",
                   ]
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
    
//==========APi without activity indecator ===========
    
    class func alamofireNewPostRequestwithoutactivityindicator(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        //KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        
            AF.request(url, method: .post, parameters: parameters, headers: nil).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                       // KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _): break
                      //KRProgressHUD.dismiss()
                }
            })
    }
    
    //==========APi without activity indecator ===========
    
    class func alamofirewithhadderwithoutactivityNewGetRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)

        AF.request(url, method: .get, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                       
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _): break
                    
                }
            })
    }

    
    //===============Upload file  ====================
    
    //userImg: Image, userFile: file, ImgName: ImgName, fileName: fileName, fileType: "pdf"
    
    class func alamofireUploadFile(urlmethod: String, parameter: [String: Any], userImg: Data!, userFile: Data!, ImgName: String, fileName: String,fileType: String, imgType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if CommonMethods.isInternetAvailable() == true {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                let imageData = userFile
                //"image/jpeg"
                if fileType == "image/jpeg" {
                    if let data = userImg {
              
                        multipartFormData.append(data, withName: fileName, fileName: "filename" + ".jpeg", mimeType: fileType)
                    }
                } else {
                    if let data = imageData {
                        multipartFormData.append(data, withName: fileName, fileName: "filename" + ".pdf", mimeType: fileType)
                    }
                }
                
                //===============
                
                let imageDataaa = userImg
                //"image/jpeg"
                if imgType == "image/png" {
                    if let data = imageDataaa {
              
                        multipartFormData.append(data, withName: ImgName, fileName: "filename" + ".png", mimeType: imgType)
                    }
                } else {
                    if let data = imageData {
                        multipartFormData.append(data, withName: fileName, fileName: "filename" + ".pdf", mimeType: fileType)
                    }
                }
                
                //=================
                
            }, to: urlmethod, method: .post, headers: DataManager.headerParam()).responseJSON { responseObject in
                switch(responseObject.result) {
                case .success(_):
                    KRProgressHUD.dismiss()
                    print(responseObject.value!)
                    let statusCode = responseObject.response?.statusCode
                    if statusCode == 200 {
                        let result = responseObject.value! as! [String : Any]
                        completion(responseObject.data, result as NSDictionary)
                    } else {
                        let result = responseObject.value! as! [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                    }
                    break
                case .failure(_):
                    KRProgressHUD.dismiss()
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: responseObject.error?.localizedDescription ?? "Something went wrong", view: viewcontroller)
                    break
                }
            }
        } else {
            KRProgressHUD.dismiss()
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    
    
    
    //==============New Method made By pkram==================================
    
    
    class func alamofireUploadMultipleFile(urlmethod: String, parameter: [String: Any], imageData1: Data!, imageData2: Data!, imageData3: Data!, imageData4: Data!, imageData5: Data!, imageData6: Data!, viewcontroller : UIViewController!, completionHandler: @escaping completion) {
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if CommonMethods.isInternetAvailable() == true {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                multipartFormData.append(imageData1, withName: "avatar", fileName: "image1.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData2, withName: "identification_image", fileName: "image2.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData3, withName: "license_image_front", fileName: "image3.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData4, withName: "license_image_back", fileName: "image4.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData5, withName: "health_passport_image", fileName: "image5.png", mimeType: "image/jpeg")
                multipartFormData.append(imageData6, withName: "freelance_license_image", fileName: "image6.png", mimeType: "image/jpeg")

            }, to: urlmethod, method: .post, headers: DataManager.headerParam()).response { response in
                KRProgressHUD.dismiss()
                switch(response.result){
                case .success(_):
                    let statusCode = response.response?.statusCode
                    if statusCode == 200 {
                        if let data = response.data {
                            print("JSON: \(data)")
                            let jsonObject = JSON(data)
                            print("JSON: \(jsonObject)")
                            KRProgressHUD.dismiss()
                            completionHandler(response.data, nil)
                        }
                        
                    }
                    else if statusCode == 400 {
                        let result = response.value as? [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as! String, view: viewcontroller)
                    }
                    else if statusCode == 422 {
                        let result = response.value as? [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as! String, view: viewcontroller)
                    }
                    else {
                        let result = response.value as? [String : Any]
                        CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as! String, view: viewcontroller)
                    }
                    
                case .failure(let error):
                    print(error)
                    CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                }
            }
        } else {
            KRProgressHUD.dismiss()
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
        }
    }
    
    
    // upload 3 images
    class func alamofireUploadThreeImage(urlmethod: String, parameter: [String: Any], userImage1: Data!,userImage2: Data!,userImage3: Data!,imageName1: String,imageName2:String,imageName3: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
            
                    KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
               if CommonMethods.isInternetAvailable() == true {
                AF.upload(multipartFormData: { multipartFormData in
                    for (key, value) in parameter {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    // 1st img
                    let imageData1 = userImage1
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData1 {
                            multipartFormData.append(data, withName: imageName1, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    } 
                    else {
                        if let data = imageData1 {
                            multipartFormData.append(data, withName: imageName1, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                    
                    //second img
                    let imageData2 = userImage2
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData2 {
                            multipartFormData.append(data, withName: imageName2, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData2 {
                            multipartFormData.append(data, withName: imageName2, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                    
                    //3rd img
                    let imageData3 = userImage3
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData3 {
                            multipartFormData.append(data, withName: imageName3, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData3 {
                            multipartFormData.append(data, withName: imageName3, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                }, to: urlmethod, method: .post, headers:headerParam()).responseJSON { responseObject in
                    switch(responseObject.result) {
                    case .success(let value):
                        let statusCode = responseObject.response?.statusCode
                        if statusCode == 200 {
                            KRProgressHUD.dismiss()
                            if let data = value as? [String:Any] {
                                completion(responseObject.data, data as NSDictionary)
                            }
                        }
                        else if statusCode == 401 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else if statusCode == 422 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        
                    case .failure(let error):
                        print(error)
                        KRProgressHUD.dismiss()
                        CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                    }
                }
            } else {
                KRProgressHUD.dismiss()
                CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
            }
        }
    
    
    //upload sigle image
    class func alamofireUploadImage(urlmethod: String, parameter: [String: Any], userImage: Data!,imageName: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
            
                    KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
               if CommonMethods.isInternetAvailable() == true {
                AF.upload(multipartFormData: { multipartFormData in
                    for (key, value) in parameter {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    let imageData = userImage
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData {
                            multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                        }
                    } else {
                        if let data = imageData {
                            multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".pdf", mimeType: fileType)
                        }
                    }
                }, to: urlmethod, method: .post, headers: nil).responseJSON { responseObject in
                    switch(responseObject.result) {
                    case .success(let value):
                        let statusCode = responseObject.response?.statusCode
                        if statusCode == 200 {
                            KRProgressHUD.dismiss()
                            if let data = value as? [String:Any] {
                                completion(responseObject.data, data as NSDictionary)
                            }
                        }
                        else if statusCode == 401 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else if statusCode == 422 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        
                    case .failure(let error):
                        print(error)
                        KRProgressHUD.dismiss()
                        CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                    }
                }
            } else {
                KRProgressHUD.dismiss()
                CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
            }
        }
    
   
 //update with upoading single image
    class func alamofireNewUpdatePutRßequest(urlmethod: String, parameter: [String: Any], userImage: Data!,imageName: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
            
                    KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
               if CommonMethods.isInternetAvailable() == true {
                AF.upload(multipartFormData: { multipartFormData in
                    for (key, value) in parameter {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    let imageData = userImage
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData {
                            multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                        }
                    } else {
                        if let data = imageData {
                            multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".pdf", mimeType: fileType)
                        }
                    }
                }, to: urlmethod, method: .put, headers: headerParam()).responseJSON { responseObject in
                    switch(responseObject.result) {
                    case .success(let value):
                        let statusCode = responseObject.response?.statusCode
                        if statusCode == 200 {
                            KRProgressHUD.dismiss()
                            if let data = value as? [String:Any] {
                                completion(responseObject.data, data as NSDictionary)
                            }
                        }
                        else if statusCode == 401 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else if statusCode == 422 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        
                    case .failure(let error):
                        print(error)
                        KRProgressHUD.dismiss()
                        CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                    }
                }
            } else {
                KRProgressHUD.dismiss()
                CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
            }
        }
    
    // 3Image  with diffrent key
    //addvehicle form api
    class func alamofireUpload3ImagePostApi(urlmethod: String, parameter: [String: Any], userImage: Data!,frontImage:Data!,backImage:Data!,frontImageName: String,backImageName: String,imageName: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
        if CommonMethods.isInternetAvailable() == true {
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameter {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
 
                let imageData = userImage
                //"image/jpeg"
                if fileType == "image/jpeg" {
                    if let data = imageData {
                        multipartFormData.append(data, withName: imageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                    }
                }
                let frontimageData = frontImage
                //"image/jpeg"
                if fileType == "image/jpeg" {
                    if let data = frontimageData {
                        multipartFormData.append(data, withName: frontImageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                    }
                }
                let backimageData = backImage
                //"image/jpeg"
                if fileType == "image/jpeg" {
                    if let data = backimageData {
                        multipartFormData.append(data, withName: backImageName, fileName: "imageName" + ".jpeg", mimeType: fileType)
                    }
                }
                
            }, to: urlmethod, method: .post, headers: DataManager.headerParam()).responseData(completionHandler: { response in
                
                switch response.result {
                case .success:
                    let statusCode = response.response?.statusCode
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        let result = jsonObject.dictionaryObject
                        
                        if statusCode == 200 {
                            completion(response.data, nil)
                            KRProgressHUD.dismiss()
                        }
                        else if statusCode == 401 {
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as? String, view: viewcontroller)
                            KRProgressHUD.dismiss()
                        }
                        else if statusCode == 422 {
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as? String, view: viewcontroller)
                            KRProgressHUD.dismiss()
                        }
                        else if statusCode == 500 {
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as? String, view: viewcontroller)
                            KRProgressHUD.dismiss()
                        }
                        else {
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result?["message"] as? String, view: viewcontroller)
                            KRProgressHUD.dismiss()
                        }
                    }
                    break
                case .failure( _):
                    CommonMethods.showAlertMessage(title: Constant.TITLE, message: "Please try again.", view: viewcontroller)
                    KRProgressHUD.dismiss()
                }
            })
            
        }else {
            CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
            KRProgressHUD.dismiss()
        }
    }
    
   // vehicleData show api
      class func alamofireUpload3ImgGetApi(urlmethod: String, parameter: [String: Any], userImage1: Data!,userImage2: Data!,userImage3: Data!,imageName1: String,imageName2:String,imageName3: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
            
                    KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
               if CommonMethods.isInternetAvailable() == true {
                AF.upload(multipartFormData: { multipartFormData in
                    for (key, value) in parameter {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    // 1st img
                    let imageData1 = userImage1
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData1 {
                            multipartFormData.append(data, withName: imageName1, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData1 {
                            multipartFormData.append(data, withName: imageName1, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                    
                    //second img
                    let imageData2 = userImage2
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData2 {
                            multipartFormData.append(data, withName: imageName2, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData2 {
                            multipartFormData.append(data, withName: imageName2, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                    
                    //3rd img
                    let imageData3 = userImage3
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData3 {
                            multipartFormData.append(data, withName: imageName3, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData3 {
                            multipartFormData.append(data, withName: imageName3, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                }, to: urlmethod, method: .get, headers:headerParam()).responseJSON { responseObject in
                    switch(responseObject.result) {
                    case .success(let value):
                        let statusCode = responseObject.response?.statusCode
                        if statusCode == 200 {
                            KRProgressHUD.dismiss()
                            if let data = value as? [String:Any] {
                                completion(responseObject.data, data as NSDictionary)
                            }
                        }
                        else if statusCode == 401 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else if statusCode == 422 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        
                    case .failure(let error):
                        print(error)
                        KRProgressHUD.dismiss()
                        CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                    }
                }
            } else {
                KRProgressHUD.dismiss()
                CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
            }
        }
//vehicle update with 3 images
    class func alamofireUpload3ImagePutApi(urlmethod: String, parameter: [String: Any], userImage1: Data!,userImage2: Data!,userImage3: Data!,imageName1: String,imageName2:String,imageName3: String,fileType: String, viewcontroller : UIViewController!, completion:@escaping completion) {
            
                    KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)
               if CommonMethods.isInternetAvailable() == true {
                AF.upload(multipartFormData: { multipartFormData in
                    for (key, value) in parameter {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    // 1st img
                    let imageData1 = userImage1
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData1 {
                            multipartFormData.append(data, withName: imageName1, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData1 {
                            multipartFormData.append(data, withName: imageName1, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                    
                    //second img
                    let imageData2 = userImage2
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData2 {
                            multipartFormData.append(data, withName: imageName2, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData2 {
                            multipartFormData.append(data, withName: imageName2, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                    
                    //3rd img
                    let imageData3 = userImage3
                    //"image/jpeg"
                    if fileType == "image/jpeg" {
                        if let data = imageData3 {
                            multipartFormData.append(data, withName: imageName3, fileName: "filename" + ".jpeg", mimeType: fileType)
                        }
                    }
                    else {
                        if let data = imageData3 {
                            multipartFormData.append(data, withName: imageName3, fileName: "filename" + ".pdf", mimeType: fileType)
                        }
                    }
                }, to: urlmethod, method: .put, headers:headerParam()).responseJSON { responseObject in
                    switch(responseObject.result) {
                    case .success(let value):
                        let statusCode = responseObject.response?.statusCode
                        if statusCode == 200 {
                            KRProgressHUD.dismiss()
                            if let data = value as? [String:Any] {
                                completion(responseObject.data, data as NSDictionary)
                            }
                        }
                        else if statusCode == 401 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else if statusCode == 422 {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        else {
                            KRProgressHUD.dismiss()
                            let result = responseObject.value! as! [String : Any]
                            CommonMethods.showAlertMessage(title: Constant.TITLE, message: result["message"] as! String, view: viewcontroller)
                        }
                        
                    case .failure(let error):
                        print(error)
                        KRProgressHUD.dismiss()
                        CommonMethods.showAlertMessage(title: Constant.BLANK, message: (error.localizedDescription), view: viewcontroller)
                    }
                }
            } else {
                KRProgressHUD.dismiss()
                CommonMethods.showAlertMessage(title: Constant.BLANK, message: Constant.MESSAGE_NETWORK, view: viewcontroller)
            }
        }
    
   //driver confirm order api
  class func alamofireNewPutwithHadderRequest(url:String,viewcontroller : UIViewController!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
        print(parameters as Any)
        
        KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)

        AF.request(url, method: .put, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                switch response.result {
                case .success:
                    print(response)
                    if let data = response.data {
                        print("JSON: \(data)")
                        let jsonObject = JSON(data)
                        print("JSON: \(jsonObject)")
                        KRProgressHUD.dismiss()
                        completionHandler(response.data, nil)
                    }
                    break
                case .failure( _):
                      KRProgressHUD.dismiss()
                }
            })
    }
    
    //on off duty
    class func alamofirePutwithHadderRequest(url:String,view : UIView!, parameters:[String:AnyObject]?, completionHandler: @escaping completion) {
          print(parameters as Any)
          
          KRProgressHUD.show(withMessage: Constant.PROGRESS_TITLE)

          AF.request(url, method: .put, parameters: parameters, headers: DataManager.headerParam()).responseData(completionHandler:{ response in
                  switch response.result {
                  case .success:
                      print(response)
                      if let data = response.data {
                          print("JSON: \(data)")
                          let jsonObject = JSON(data)
                          print("JSON: \(jsonObject)")
                          KRProgressHUD.dismiss()
                          completionHandler(response.data, nil)
                      }
                      break
                  case .failure( _):
                        KRProgressHUD.dismiss()
                  }
              })
           
      }

    
    //==============================================================
    
    class func headerParam() -> HTTPHeaders {
        var headerParam = HTTPHeaders()
        headerParam["Authorization"] = "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "")" //"\(UserDefaults.standard.value(forKey: "token") ?? "")"
        headerParam["Accept-Language"] = "en"
        headerParam["Accept"] = "application/json"
       return headerParam
    }
}

