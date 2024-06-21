//
//  CurrentLocationOfOrderVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 23/04/24.
//

import UIKit
import SDWebImage
import MapKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class CurrentLocationOfOrderVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
   // vc.driverStatusText = self.driverOngoingLM?.data?[indexPath.row].driver_status  ?? ""
   // vc.driverStatusID = self.driverOngoingLM?.data?[indexPath.row].driver_status_id



    
    @IBOutlet weak var mapView: UIView!
    
    var map = GMSMapView()
    
    var pickupCoordinate: CLLocationCoordinate2D?

    var destinationCoordinate: CLLocationCoordinate2D?

    var locationManager = CLLocationManager()
    
    var city:String?
    var lat:String?
    var long:String?
    var currentLocation:String?
    
    let startLatitude: CLLocationDegrees? = nil
    let startLongitude: CLLocationDegrees? = nil
    let endLatitude: CLLocationDegrees? = nil
    let endLongitude: CLLocationDegrees? = nil
    
    var driverStatusText:String?
    var driverStatusID:Int?
    
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var cursorView: UIView!
    @IBOutlet weak var topBarView: TitleBar!
    @IBOutlet weak var driverStatusTxt: UILabel!
    
    @IBOutlet weak var clientImg: UIImageView!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var pickUp: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var drop: UILabel!
    
    var id:Int?
    var driverConfirmBDM:DriverConfirmBidDetailsModel?
    var updateLocationModel:UpdateDriverLocationModel?
    var driverCBM:driverCompleteBookingModel?
    var driverStartTripM:driverStartTripModel?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.driverStatusTxt.text = driverStatusText
        self.lat = UserDefaults.standard.string(forKey: "lat")
        print(self.lat ?? "")
        self.long = UserDefaults.standard.string(forKey: "long")
        
        // this id will pass as a parameter into get details
        print(id ?? 0)
       
        cursorView.layer.borderWidth = 0
        cursorView.layer.shadowColor = UIColor.black.cgColor
        cursorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cursorView.layer.shadowRadius = 2
        cursorView.layer.shadowOpacity = 0.3
        cursorView.layer.masksToBounds = false
    
        
        backBtnView.layer.borderWidth = 0
        backBtnView.layer.shadowColor = UIColor.black.cgColor
        backBtnView.layer.shadowOffset = CGSize(width: 0, height: 1)
        backBtnView.layer.shadowRadius = 2
        backBtnView.layer.shadowOpacity = 0.3
        backBtnView.layer.masksToBounds = false
        
        completeBtn.isHidden = true

}
    override func viewWillAppear(_ animated: Bool) {
     
          getCurrentLocation()
    }
    
    @IBAction func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func goForPickUpBtnPress(_ sender: UIButton) {
     driverCompleteBookingMethod()
    }
    
    @IBAction func selectDriverStatus(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryCodeVC") as! CountryCodeVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.listType = "driverStatus"
        vc.selectListTypeDelegate = self
        self.present(vc, animated: true, completion: nil)
      }
}

extension CurrentLocationOfOrderVC:SelectListType{
    
    func selectListType(dataName: String, dataId: Int) {
      
        self.driverStatusTxt.text = dataName
        
        self.driverStartTripMethod(driverStatus:"\(dataId)") //  api call Update Status For client
        

    }
    
    //  =======min hrs sec conversion=====
      func convertSecondsToTimeComponents(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
          let hours = seconds / 3600
          let minutes = (seconds % 3600) / 60
          let remainingSeconds = seconds % 60
          return (hours, minutes, remainingSeconds)
      }
    
    // MARK: - =========== All Api
    
    func driverConfirmBidingDetailMethod(){      //TODO:  Pickup & Drop location get
        var param = [String:Any]()
        print(param)
        DriverOrderViewModel.driverConfirmBisDetailsApi(viewController: self, parameters: param as NSDictionary){ response in
            self.driverConfirmBDM = response
             print("success")
            
            let img = self.driverConfirmBDM?.data?.user_image ?? ""
            if let url = URL(string: image_Url + img){
                self.clientImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
          
            self.pickUp.text = self.driverConfirmBDM?.data?.pickup_location ?? ""
            self.drop.text = self.driverConfirmBDM?.data?.drop_location ?? ""
            let duration = self.driverConfirmBDM?.data?.duration ?? 0
            let timeComponents = self.convertSecondsToTimeComponents(seconds: duration)
            print("Hours: \(timeComponents.hours), Minutes: \(timeComponents.minutes), Seconds: \(timeComponents.seconds)")
            let fullduration = "\(timeComponents.minutes) min, \(timeComponents.seconds) sec"
            self.time.text = fullduration
            print(self.lat ?? "")
            print(self.long ?? "")
            
            if self.driverStatusID == nil{
                print(self.driverStatusID ?? 0)
                  self.pickupCoordinate = CLLocationCoordinate2DMake(Double("\(self.lat ?? "")") ?? 0.0, Double("\(self.long ?? "")") ?? 0.0)
                  
                  self.destinationCoordinate = CLLocationCoordinate2DMake(Double("\(self.driverConfirmBDM?.data?.pickup_latitude ?? 0.0)") ?? 0.0, Double("\(self.driverConfirmBDM?.data?.pickup_longitude ?? 0.0)") ?? 0.0)
                  
                  //====== route draw ======
                  
                  self.getRouteSteps(from: self.pickupCoordinate!, to: self.destinationCoordinate!)
              }
              else {
                  print(self.driverStatusID ?? 0)
                  self.driverStartTripMethod(driverStatus:"\(self.driverStatusID ?? 0)") //  api call Update Status For client
              }
         }
     }
    

    
    //  ===== update driver locat api =====
        func updateDriverLocationApiCall(){
            
            self.city = UserDefaults.standard.string(forKey: "cityName")
            self.lat = UserDefaults.standard.string(forKey: "lat")
            print(self.lat ?? "")
            self.long = UserDefaults.standard.string(forKey: "long")
            print(self.long ?? "")
            self.currentLocation = self.city
            
            var param = [String:Any]()
            param = ["current_city":city ?? "", "current_location":currentLocation ?? "", "current_latitude":lat ?? "", "current_longitude":long ?? ""]
            print(param)
            DRiverHomeViewModel.updateDriverLocationApi(viewController: self, parameters: param as NSDictionary){ response in
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: response?.msg, view: self)
                self.updateLocationModel = response
            }
        }
    
    // =========driver start trip api======
    
    func driverStartTripMethod(driverStatus:String){
        self.updateDriverLocationApiCall()
        var param = [String:Any]()
        param = ["driver_status":driverStatus]
        print(param)
        DRiverHomeViewModel.driverStartTripApi(viewController: self, parameters: param as NSDictionary){
            response in
            print("strat trip api is successful")
            self.driverStartTripM = response
            
            self.pickupCoordinate = CLLocationCoordinate2DMake(Double("\(25.9875)") ?? 0.0, Double("\(79.4489)") ?? 0.0)
                
            self.destinationCoordinate = CLLocationCoordinate2DMake(Double("\(self.driverConfirmBDM?.data?.drop_latitude ?? 0.0)") ?? 0.0, Double("\(self.driverConfirmBDM?.data?.drop_longitude ?? 0.0)") ?? 0.0)
            
           // ====== route draw ======
            
            self.getRouteSteps(from: self.pickupCoordinate!, to: self.destinationCoordinate!)
            
        }
    }
    
      // ========driver completeBooking api=======
    func driverCompleteBookingMethod(){
        let param = [String:Any]()
        DRiverHomeViewModel.driverCompleteBookingApi(viewController: self, parameters: param as NSDictionary){ response in
            self.driverCBM = response
            print(self.driverCBM?.msg ?? "")
            
        }
    }
}

extension CurrentLocationOfOrderVC{
    //=========get current location by google map=======
     func getCurrentLocation() {
         locationManager.requestWhenInUseAuthorization()
         var currentLoc: CLLocation!
         if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
             CLLocationManager.authorizationStatus() == .authorizedAlways) {
             currentLoc = locationManager.location
             if currentLoc != nil {
                 let geocoder = GMSGeocoder()
                 geocoder.reverseGeocodeCoordinate(currentLoc.coordinate) { response, error in
                     guard let address = response?.firstResult(), let lines = address.lines else {
                         return
                     }
                     print(lines)
                     //self.addressTF.text = lines.joined(separator: "\n")
                     print(lines.joined(separator: "\n"))
                     //self.coordinate = currentLoc.coordinate
                     //print( self.coordinate!)
                     self.setUpMap(lattitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
                 }
                 
             }
             else {
                 setUpMap(lattitude: 28.6061, longitude: 77.3694)
             }
         }
     }
     
    func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        print(source)
        print(destination)
        let session = URLSession.shared
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\("AIzaSyA3KVnFOiaKNlhi4hJB8N2pB8tyoe_rRxQ")")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                
                print("error in JSONSerialization")
                return
                
            }
            guard let routes = jsonResult["routes"] as? [Any] else {
                return
            }
            
            guard let route = routes[0] as? [String: Any] else {
                return
            }
            
            guard let legs = route["legs"] as? [Any] else {
                return
            }
            guard let leg = legs[0] as? [String: Any] else {
                return
            }
            guard let distance = leg["distance"] as? [String:Any] else {
                return
            }
            guard let distanceText = distance["text"] as? String else {
                return
            }
            guard let duration = leg["duration"] as? [String:Any] else {
                return
            }
            guard let durationText = duration["text"] as? String else {
                return
            }
            
            print(distanceText)
            print(durationText)
            
            let formattedString = distanceText.replacingOccurrences(of: ",", with: "")
            
            let fomatedArray = formattedString.components(separatedBy: " ")
            
            let onlyTotalDistance = fomatedArray[0]
        
            guard let steps = leg["steps"] as? [Any] else {
                return
            }
            for item in steps {
                
                guard let step = item as? [String: Any] else {
                    return
                }
                
                guard let polyline = step["polyline"] as? [String: Any] else {
                    return
                }
                
                guard let polyLineString = polyline["points"] as? String else {
                    return
                }
                
                DispatchQueue.main.async {
                    let marker1 =  GMSMarker()
                    marker1.icon = UIImage(named: "tttttttttttttt")
                    marker1.position = CLLocationCoordinate2DMake(source.latitude, source.longitude)
                    
                    let geocoder = GMSGeocoder()
                    geocoder.reverseGeocodeCoordinate(marker1.position) { response, error in
                        guard let address = response?.firstResult(), let lines = address.lines else {
                            return
                        }
                        marker1.title = lines.joined(separator: "\n")
                        UIView.animate(withDuration: 0.25) {
                            self.view.layoutIfNeeded()
                        }
                    }
                    marker1.map = self.map
                    
                    let marker2 = GMSMarker()
                    marker2.icon = UIImage(named: "pin 1")
                    marker2.position = CLLocationCoordinate2DMake(destination.latitude, destination.longitude)
                    
                    let geocoder2 = GMSGeocoder()
                    geocoder2.reverseGeocodeCoordinate(CLLocationCoordinate2DMake(destination.latitude, destination.longitude)) { response, error in
                        guard let address = response?.firstResult(), let lines = address.lines else {
                            return
                        }
                        marker2.title = lines.joined(separator: "\n")
                        UIView.animate(withDuration: 0.25) {
                            self.view.layoutIfNeeded()
                        }
                    }
                    //self.map.settings.compassButton = true
                    marker2.map = self.map
                    self.drawPath(from: polyLineString)
                }
                
            }
        })
        task.resume()
    }
    
    func drawPath(from polyStr: String)
    {
    
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 8.0
        polyline.map = map // Google MapView
        polyline.map?.isTrafficEnabled = true
        polyline.strokeColor = .red//UIColor(red: 255/255, green: 213/255, blue: 30/255, alpha: 1.0)
       
  //        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: pickupCoordinate!, coordinate: destinationCoordinate!))
//        map.moveCamera(cameraUpdate)
        let currentZoom = map.camera.zoom
        map.animate(toZoom: currentZoom + 0.4)//
   }
    
    func setUpMap(lattitude: Double, longitude: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: 15)
        map = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.delegate = self
        map.clear()
        mapView.addSubview(map)
        map.isMyLocationEnabled = true
        map.mapType = .normal
        driverConfirmBidingDetailMethod()
        
    }
  }


/*
 //calculate ===== difference between distance =======

 let startLocation = CLLocation(latitude: Double("\(self.lat ?? "")") ?? 0.0, longitude: Double("\(self.long ?? "")") ?? 0.0)
 
 let endLocation = CLLocation(latitude: self.driverConfirmBDM?.data?.pickup_latitude ?? 0.0, longitude: self.driverConfirmBDM?.data?.pickup_longitude ?? 0.0)
 
 let distanceInMeters = startLocation.distance(from: endLocation)
 print("Distance in meters: \(distanceInMeters)")

 if distanceInMeters == 50 {
     self.completeBtn.isHidden = false
 }
 else {
     self.completeBtn.isHidden = true
 }
 */
