//
//  MapVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 24/05/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var mapViewContainer: UIView!
        @IBOutlet weak var searchLocationTF: UITextField!
        @IBOutlet weak var addressTF: UITextField!
    
    var locationManager = CLLocationManager()
       var gmsMapView: GMSMapView?
    

    override func viewDidLoad() {
           super.viewDidLoad()

           searchLocationTF.delegate = self

           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()

           setupMapView()
       }

       func setupMapView() {
           let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.0)
           gmsMapView = GMSMapView.map(withFrame: self.mapViewContainer.bounds, camera: camera)
           gmsMapView?.delegate = self
           gmsMapView?.isMyLocationEnabled = true
           self.mapViewContainer.addSubview(gmsMapView!)
       }

       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.last {
               let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
               gmsMapView?.animate(to: camera)

               let marker = GMSMarker()
               marker.position = location.coordinate
               marker.title = "Current Location"
               marker.icon = UIImage(named: "pin_image") // अपने पिन इमेज का नाम यहाँ डालें
               marker.map = gmsMapView

               // Fetch and display the address
               fetchAddress(for: location)
           }
           locationManager.stopUpdatingLocation()
       }

       func fetchAddress(for location: CLLocation) {
           let geocoder = CLGeocoder()
           geocoder.reverseGeocodeLocation(location) { placemarks, error in
               if let placemark = placemarks?.first {
                   self.addressTF.text = [placemark.name, placemark.locality, placemark.administrativeArea, placemark.country].compactMap { $0 }.joined(separator: ", ")
               }
           }
       }

       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           if textField == searchLocationTF {
               searchLocation()
           }
           textField.resignFirstResponder()
           return true
       }

       func searchLocation() {
           guard let address = searchLocationTF.text, !address.isEmpty else { return }

           let geocoder = CLGeocoder()
           geocoder.geocodeAddressString(address) { placemarks, error in
               if let error = error {
                   print("Geocoding error: \(error)")
                   return
               }

               guard let placemark = placemarks?.first, let location = placemark.location else {
                   print("No location found")
                   return
               }

               let coordinate = location.coordinate
               let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
               self.gmsMapView?.animate(to: camera)

               let marker = GMSMarker()
               marker.position = coordinate
               marker.title = address
               marker.icon = UIImage(named: "pin_image") // अपने पिन इमेज का नाम यहाँ डालें
               marker.map = self.gmsMapView

               // Fetch and display the address
               self.fetchAddress(for: location)
           }
       }
   }
