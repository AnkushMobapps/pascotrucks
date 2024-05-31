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
    @IBOutlet weak var vieww: UIView!
   
    @IBOutlet weak var searchLocationView: UIView!
    @IBOutlet weak var searchLocationTF: UITextField!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var confirmLocationBtn: UIButton!
    @IBOutlet weak var addressTF: UITextView!
  
    
    var pickupCoordinate: CLLocationCoordinate2D?
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
 
    var editHostCreate:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchLocationView.isHidden = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        setUpMap(lattitude: 28.6061, longitude: 77.3694)
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
       
       searchLocationTF.addTarget(self, action: #selector(configurePlaces(_:)), for: .editingDidBegin)
       
//        g/*eetCurrentLocation()*/
        
    }
    
    @IBAction func saveAndCloseBtnAction(_ sender: UIButton) {
      
        
    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    @IBAction func confirmLocationBtnAction(_ sender: UIButton) {
        delegate?.addressWithLatLong(address: addressTF.text ?? "blank Address" , latLong: coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        self.navigationController?.popViewController(animated: true)
        
       
     
    }
    
    @IBAction func addressBtnTapped(_ sender: UIButton) {
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

    func setUpMap(lattitude: Double, longitude: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: 15)
        map = GMSMapView.map(withFrame: vieww.bounds, camera: camera)
        map.delegate = self
        map.clear()
        vieww.addSubview(map)
        map.isMyLocationEnabled = true
        // Creates a marker in the center of the map.
        self.pin = UIImageView(frame: CGRect(x: self.map.frame.origin.x + self.map.frame.size.width/2 - 25, y:  self.map.frame.size.height/2 - 50, width: 50, height: 50))
        self.pin.image = UIImage(named: "location 1")
        self.pin.tintColor = .black
        self.vieww.addSubview(self.pin)
        map.mapType = .normal
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        let name = place.addressComponents
        //        print(name?.name)
        print(place.formattedAddress)
        searchLocationTF.text = place.formattedAddress ?? ""
        setUpMap(lattitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        //                DispatchQueue.main.async
        //                {
        let position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
        self.marker = GMSMarker(position: position)
        //                    self.marker.title = place.name
        //                    self.marker.snippet = place.formattedAddress
        //                    self.marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))
        //                    self.marker.map = self.map
        //                }
        coordinate = place.coordinate
        dismiss(animated: true, completion: nil)
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
//            self.addressTF.text = lines.joined(separator: "\n") //--------Location Search TextField-----//
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
//            self.addressTF.text = lines.joined(separator: "\n")
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
//            self.addressTF.text = lines.joined(separator: "\n")
            //                self.pickupAddress = lines.joined(separator: "\n")
            print(lines.joined(separator: "\n"))
            self.pickupCoordinate = marker.position
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
extension PinaddressVC {
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
//                    self.addressTF.text = lines.joined(separator: "\n")
                    print(lines.joined(separator: "\n"))
                    self.coordinate = currentLoc.coordinate
                    print( self.coordinate!)
                    self.setUpMap(lattitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
                }
                
            }
            else {
                setUpMap(lattitude: 28.6061, longitude: 77.3694)
            }
        }
    }
    
   
    
    
}
