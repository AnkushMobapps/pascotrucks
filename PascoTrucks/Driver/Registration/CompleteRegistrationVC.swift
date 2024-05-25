//
//  CompleteRegistrationVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 04/05/24.
//

import UIKit
import SDWebImage
import CoreLocation

class CompleteRegistrationVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneNoTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var countryCode: UILabel!
    
    var registerModel:RegisterModel?
    // var userid:String?
    var index:Int?
    var selectedImg:UIImage?
    var locationManager: LocationManager?
    var phonenumber:String?
    var deviceId:String?
    var userType:String?
    var countryName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNoTxt.text = phonenumber
        
        cityTxt.text = UserDefaults.standard.string(forKey:"city_Name")
        print(cityTxt.text)
        countryName = UserDefaults.standard.string(forKey:"country_Name")
        
        locationManager = LocationManager()
                  getLatitudeAndLongitude()
        
      }
    
    
    // Example method to access latitude and longitude
      func getLatitudeAndLongitude() {
          if let latitude = locationManager?.locationManager?.location?.coordinate.latitude,
             let longitude = locationManager?.locationManager?.location?.coordinate.longitude {
              print("Latitude: \(latitude), Longitude: \(longitude)")
              
          }
          else
          {
              print("Unable to get location.")
          }
      }
    
    
    @IBAction func selectCountryCodeBtnClk(_ sender: UIButton)
    {
    
    }
    
    @IBAction func submitRegBtnClk(_ sender: Any) {
        selectedImg = UIImage(imageLiteralResourceName: "maskgroup")
        submitDriverRegApiMetnod()
    }
    
   @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
}

// MARK: - ************    API   ***************

extension CompleteRegistrationVC {
    //driverRegistrationApi
    func submitDriverRegApiMetnod(){
         let param = [ "user_type": userType ?? "","phone_number":phonenumber ?? "","full_name":nameTxt.text ?? "" ,"email": emailTxt.text ?? "","current_location":"East", "phone_verify":"mahi", "current_city":cityTxt.text ?? "", "current_latitude":"345.0", "current_longitude":"678.0"]
        print(param)
        
         RegisterViewModel.submitRegApi(viewController: self, parameters: param as NSDictionary) { (response) in
             print(response!)
             print("Success")
             self.registerModel = response
             print(self.registerModel?.data?.current_city ?? "")
             let tokkken = self.registerModel?.token?.access
             UserDefaults.standard.setValue(tokkken, forKey: "token")
             
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as! VehicleDetailsVC
             vc.cityName = self.cityTxt.text
             vc.countryName = self.countryName
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


