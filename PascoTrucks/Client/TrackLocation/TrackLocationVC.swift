//
//  TrackLocationVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 30/05/24.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

protocol gAddressWithLatLong: AnyObject {
    func addressWithLatLong(address:String?, latLong:CLLocationCoordinate2D?)
     
}

class TrackLocationVC: UIViewController,GMSAutocompleteViewControllerDelegate, GMSMapViewDelegate, CLLocationManagerDelegate
{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
    }
    
    @IBOutlet weak var vieww: UIView!
   
    @IBOutlet weak var searchLocationView: UIView!
    @IBOutlet weak var searchLocationTF: UITextField!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var confirmLocationBtn: UIButton!
    @IBOutlet weak var addressTF: UITextView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var showDetailsBtn: UIButton!
    @IBOutlet weak var hideDetailsBtn: UIButton!
    @IBOutlet weak var statusViewHeight: NSLayoutConstraint!
    @IBOutlet weak var durationTimeLbl: UILabel!
    @IBOutlet weak var pickupLocationLbl: UILabel!
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    
    var pickupCoordinate: CLLocationCoordinate2D?
    var destinationCoordinate: CLLocationCoordinate2D?
    var coordinate: CLLocationCoordinate2D?
    var map = GMSMapView()
    var marker = GMSMarker()
    var pin = UIImageView()
    weak var delegate:getAddressWithLatLong?
    var locationManager = CLLocationManager()
    var hosting_id:String?
    var lattitude:String?
    var longitude:String?
    var uploadImg:UIImage?
    var currentLoc:Float?
    var titleValue:String?
    var editHostCreate:String?
    var tracLocation:TrackLocationModel?
    var bookedid:Int?
    var Update = Timer()
    var currentPolyline: GMSPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geetCurrentLocation()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
       
       searchLocationTF.addTarget(self, action: #selector(configurePlaces(_:)), for: .editingDidBegin)
        
        statusViewHeight.constant = 200
        detailsView.isHidden = true
        hideDetailsBtn.isHidden = true
       
        locationApi()
        
        self.Update =  Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.Update.invalidate()
    }
    
    @objc func fireTimer() {
         locationApi()
       
    }
    
    
    
    
    @IBAction func saveAndCloseBtnAction(_ sender: UIButton) {
      
        
    }
    
  
    
    @IBAction func confirmLocationBtnAction(_ sender: UIButton) {
        delegate?.addressWithLatLong(address: addressTF.text ?? "blank Address" , latLong: coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addressBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func hideDetailsBtnTapped(_ sender: UIButton) {
        statusViewHeight.constant = 200
        detailsView.isHidden = true
        hideDetailsBtn.isHidden = true
        showDetailsBtn.isHidden = false
    }
    
    @IBAction func showDetailsBtnTapped(_ sender: UIButton) {
        statusViewHeight.constant = 400
        detailsView.isHidden = false
        hideDetailsBtn.isHidden = false
        showDetailsBtn.isHidden = true
    }
    
    
    @objc func configurePlaces(_ textField: UITextField) {
        print("activated")
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Break down the creation of the fields variable into simpler steps
        let nameField = GMSPlaceField.name.rawValue
        let placeIDField = GMSPlaceField.placeID.rawValue
        let coordinateField = GMSPlaceField.coordinate.rawValue
        let addressComponentsField = GMSPlaceField.addressComponents.rawValue
        let formattedAddressField = GMSPlaceField.formattedAddress.rawValue
        
        let combinedFieldsValue = nameField | placeIDField | coordinateField | addressComponentsField | formattedAddressField
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: combinedFieldsValue)
        autocompleteController.placeFields = fields
        
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter // or filter.types = .none in newer versions
        
        autocompleteController.autocompleteFilter = filter
        autocompleteController.modalPresentationStyle = .fullScreen
        
        present(autocompleteController, animated: true, completion: nil)
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("Inside idleCameraPosition")
        print("lattitude \(position.target.latitude)")
        print("longitude \(position.target.longitude)")
        
        //MARK: Get Lattitude & Longitude --------
        self.lattitude = String(position.target.latitude)
        self.longitude = String(position.target.longitude)
        
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(position.target) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            print(lines)
            self.searchLocationTF.text = lines.joined(separator: "\n") //--------Location Search TextField-----//
            //                self.pickupAddress = self.pickupLocationTF.text
            print(lines.joined(separator: "\n"))
            self.pickupCoordinate = position.target
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("Drag")
        print("address  \(marker.position)")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            print(lines)
            self.searchLocationTF.text = lines.joined(separator: "\n")
            print(lines.joined(separator: "\n"))
            self.pickupCoordinate = marker.position
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("Old Coordinate - \(marker.position)")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            print(lines)
            self.addressTF.text = lines.joined(separator: "\n")
            //                self.pickupAddress = lines.joined(separator: "\n")
            print(lines.joined(separator: "\n"))
            self.pickupCoordinate = marker.position
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("New Coordinate - \(marker.position)")
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            print(lines)
            self.searchLocationTF.text = lines.joined(separator: "\n")
            //                self.pickupAddress = lines.joined(separator: "\n")
            print(lines.joined(separator: "\n"))
            self.pickupCoordinate = marker.position
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: locationApi
    
    func locationApi() {
        let param = ["driverbookedid": bookedid ?? 0]
        print(param)
        TrackLocationViewModel.trackLocationApi(viewcontroller: self, parameters: param as NSDictionary) { response in
            self.tracLocation = response
            print("Success")
            
            self.pickupLocationLbl.text = self.tracLocation?.data?.pickup_location ?? ""
            self.dropLocationLbl.text = self.tracLocation?.data?.drop_location ?? ""
            self.priceLbl.text = "\(self.tracLocation?.data?.bid_price ?? 0.0)"
            self.durationTimeLbl.text = "\(self.tracLocation?.data?.duration ?? 0.0)"
            self.distanceLbl.text = "\(self.tracLocation?.data?.total_distance ?? 0.0)"
            
            self.statusLbl.text = self.tracLocation?.data?.driver_status ?? ""
            if self.statusLbl.text == "On the way" {
                self.pickupCoordinate = CLLocationCoordinate2DMake(Double("\(self.tracLocation?.data?.current_latitude ?? 0.0)") ?? 0.0, Double("\(self.tracLocation?.data?.current_longitude ?? 0.0)") ?? 0.0)
                
                self.destinationCoordinate = CLLocationCoordinate2DMake(Double("\(self.tracLocation?.data?.pickup_latitude       ?? 0.0)") ?? 0.0, Double("\(self.tracLocation?.data?.pickup_longitude ?? 0.0)") ?? 0.0)
                
                //====== route draw ======
                
                self.clearCurrentRoute()
                
                self.getRouteSteps(from: self.pickupCoordinate!, to: self.destinationCoordinate!)
            } else {
                self.pickupCoordinate = CLLocationCoordinate2DMake(Double("\(self.tracLocation?.data?.pickup_latitude ?? 0.0)") ?? 0.0, Double("\(self.tracLocation?.data?.pickup_longitude ?? 0.0)") ?? 0.0)
                
                self.destinationCoordinate = CLLocationCoordinate2DMake(Double("\(self.tracLocation?.data?.drop_latitude ?? 0.0)") ?? 0.0, Double("\(self.tracLocation?.data?.drop_longitude ?? 0.0)") ?? 0.0)
                
                //====== route draw ======
                self.getRouteSteps(from: self.pickupCoordinate!, to: self.destinationCoordinate!)
            }
        }
    }

    
    
}
extension TrackLocationVC {
    func geetCurrentLocation() {
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
    
    func clearCurrentRoute() {
            currentPolyline?.map = nil
            currentPolyline = nil
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
               map = GMSMapView.map(withFrame: vieww.bounds, camera: camera)
               map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               map.delegate = self
               map.clear()
               vieww.addSubview(map)
               map.isMyLocationEnabled = true
               map.mapType = .normal
//               driverConfirmBidingDetailMethod()
               
           }
         }
