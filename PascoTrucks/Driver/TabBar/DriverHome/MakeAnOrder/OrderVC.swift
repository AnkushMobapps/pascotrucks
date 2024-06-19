//
//  OrderVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 19/04/24.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class OrderVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var vieww: UIView!
    
    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var topBarView: TitleBar!
    
    @IBOutlet weak var endPoint: UILabel!
    @IBOutlet weak var startPoint: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var commisionPrice: UILabel!
    @IBOutlet weak var paymentStatus: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var bidPrice: UITextField!
    @IBOutlet weak var driverAvailability: UITextField!
    var myid:Int?
    
    var map = GMSMapView()
    var pickupCoordinate: CLLocationCoordinate2D?

    var destinationCoordinate: CLLocationCoordinate2D?

    var locationManager = CLLocationManager()

    
    var updateBookingBidsModel:UpdateBookingBidsModel?
    var confirmOrderModel:ConfirmOrderModel?
    
 override func viewDidLoad() {
        super.viewDidLoad()
     
     
        print(myid ?? 0)
       
        receiptView.layer.borderWidth = 0
        receiptView.layer.shadowColor = UIColor.black.cgColor
        receiptView.layer.shadowOffset = CGSize(width: 0, height: 0)
        receiptView.layer.shadowRadius = 2
        receiptView.layer.shadowOpacity = 0.3
        receiptView.layer.masksToBounds = false
        
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getCurrentLocation()
       
    }

    @IBAction func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func getTimeBtnClk(_ sender: UIButton) {
  
        
    }
    
    func setUpMap(lattitude: Double, longitude: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: 15)
        map = GMSMapView.map(withFrame: vieww.bounds, camera: camera)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.delegate = self
        map.clear()
        vieww.addSubview(map)
        map.isMyLocationEnabled = true
        // Creates a marker in the center of the map.
//        self.pin = UIImageView(frame: CGRect(x: self.map.frame.origin.x + self.map.frame.size.width/2 - 25, y:  self.map.frame.size.height/2 - 50, width: 50, height: 50))
//        self.pin.image = UIImage(named: "location 1")
//        self.pin.tintColor = .black
        //self.vieww.addSubview(self.pin)
        map.mapType = .normal
        
        bidingOrderDetailsApiCall()
    }
    
    
    @IBAction func addAvailabilityBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerVC") as! DatePickerVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.selectedDateDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func stratPointAlertBtn(_ sender: UIButton) {
        CommonMethods.showAlertMessage(title: "Pickup Point", message: startPoint.text, view: self)
   }
    
    
    @IBAction func endPointAlertBtn(_ sender: UIButton) {
        CommonMethods.showAlertMessage(title: "Drop Point", message: endPoint.text, view: self)
        
    }
    
    
    

    @IBAction func confirmOrdBtnPres(_ sender: UIButton) {
        confirmOrderapi()
        
     }
}

extension OrderVC{
    func bidingOrderDetailsApiCall(){
        let param = ["id":myid]
        DRiverHomeViewModel.updatebookingbid(viewController: self, parameters: param as NSDictionary){
            response in
            self.updateBookingBidsModel = response
            
            let duration = self.updateBookingBidsModel?.data?.duration ?? 0
            let timeComponents = self.convertSecondsToTimeComponents(seconds: duration)
            print("Hours: \(timeComponents.hours), Minutes: \(timeComponents.minutes), Seconds: \(timeComponents.seconds)")
            let fullduration = "\(timeComponents.minutes) min, \(timeComponents.seconds) sec"
            self.totalTime.text = fullduration
            
            
             let distance = self.updateBookingBidsModel?.data?.total_distance ?? 0.0
////            let distance = 50000.00
//             let convertedDistance = self.convertDistanceToKilometersAndMeters(distanceInMeters: distance)
//            print("Distance: \(convertedDistance.kilometers) km \(convertedDistance.meters) m") // Output: "Distance: 0 km 245.0 m"
            
            // round to single digit example
                   
          let formattedDistance = self.formatToSingleDecimalPlace(distance)
          print(formattedDistance)  // Output: 3.1
          self.totalDistance.text = "\(formattedDistance)km"
          print(self.totalDistance.text ?? "")
            
         self.startPoint.text = self.updateBookingBidsModel?.data?.pickup_location ?? ""
            print(self.startPoint.text ?? "")
            
            self.endPoint.text = self.updateBookingBidsModel?.data?.drop_location ?? ""
            self.paymentStatus.text = self.updateBookingBidsModel?.data?.payment_status ?? ""
            
            self.commisionPrice.text = "$\(String(self.updateBookingBidsModel?.data?.commision_price ?? 0.0))"
            
            self.totalAmount.text = "$\(String(self.updateBookingBidsModel?.data?.basicprice ?? 0.0))"
            
            self.pickupCoordinate = CLLocationCoordinate2DMake(Double("\(self.updateBookingBidsModel?.data?.pickup_latitude ?? 0.0)") ?? 0.0, Double("\(self.updateBookingBidsModel?.data?.pickup_longitude ?? 0.0)") ?? 0.0)
            
            self.destinationCoordinate = CLLocationCoordinate2DMake(Double("\(self.updateBookingBidsModel?.data?.drop_latitude ?? 0.0)") ?? 0.0, Double("\(self.updateBookingBidsModel?.data?.drop_longitude ?? 0.0)") ?? 0.0)
            
            //====== route draw ======
            
            self.getRouteSteps(from: self.pickupCoordinate!, to: self.destinationCoordinate!)

        }
    }
    
    func confirmOrderapi(){
        DRiverHomeViewModel.COValidation(viewController:self){
            var param = [String : Any]()
            
            param = ["id":self.myid ?? 0, "availability_datetime":self.driverAvailability.text ?? "", "bid_price":self.bidPrice.text ?? ""]
            print(param)
            DRiverHomeViewModel.confirmOrderApi(viewController: self, parameters: param as NSDictionary){response in
                self.confirmOrderModel = response
                print("success")
                let vc = self.storyboard?.instantiateViewController(identifier: "MyTabBar") as! MyTabBar
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
}

extension OrderVC:selectedDate{
    func selDate(date: String?, timeTxt: String?) {
        self.driverAvailability.text = "\(date ?? "") \(timeTxt ?? "")"
    }
  
}
extension OrderVC{
    
  //  min hrs sec conversion
    func convertSecondsToTimeComponents(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        return (hours, minutes, remainingSeconds)
    }
//   // km conversion
//    
//    func convertDistanceToKilometersAndMeters(distanceInMeters: Double) -> (kilometers: Int, meters: Double) {
//        // Calculate the total kilometers
//        let kilometers = Int(distanceInMeters / 1000)
//        
//        // Calculate the remaining meters
//        let remainingMeters = distanceInMeters.truncatingRemainder(dividingBy: 1000)
//        
//        return (kilometers, remainingMeters)
//    }
//   
    
    //round to single digit after decimal
       func formatToSingleDecimalPlace(_ value: Double) -> String {
           let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 1
           formatter.minimumFractionDigits = 1
           formatter.roundingMode = .halfUp
           return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
       }
}
extension OrderVC {
    
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
                    marker1.icon = UIImage(named: "purpletruck")
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
                    marker2.icon = UIImage(named: "purpletruck")
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
        polyline.strokeColor = .systemPink//UIColor(red: 255/255, green: 213/255, blue: 30/255, alpha: 1.0)
        
        
//        let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: pickupCoordinate!, coordinate: destinationCoordinate!))
//        map.moveCamera(cameraUpdate)
       let currentZoom = map.camera.zoom
        map.animate(toZoom: currentZoom + 0.4)//
       
     
        
    }
}

extension OrderVC {
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
    
}
