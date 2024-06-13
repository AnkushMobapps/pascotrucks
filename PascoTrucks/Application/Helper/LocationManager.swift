//
//  LocationManager.swift
//  StoryBoardDemo
//
//  Created by Nitin Chauhan on 28/05/24.
//

import Foundation
import CoreLocation
import PhoneNumberKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let phoneNumberKit = PhoneNumberKit()
    private var fullAddress: String?
    var dialingPhoneCode:String?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        requestCurrentLocation()
    }
    
    private func requestCurrentLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        print("Latitude: \(lat), Longitude: \(long)")
        
        UserDefaults.standard.setValue(lat, forKey: "lat")
        UserDefaults.standard.setValue(long, forKey: "long")
        
        // Reverse geocode to get the full address, city, country name, and country code
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error in reverse geocoding: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? "Unknown city"
                let country = placemark.country ?? "Unknown country"
                let isoCountryCode = placemark.isoCountryCode ?? "Unknown country code"
                

                
                if let dialingCode = self.phoneNumberKit.countryCode(for: isoCountryCode) {
                    print("City: \(city), Country: \(country), Country Code: \(isoCountryCode), Dialing Code: +\(dialingCode)")
                    self.dialingPhoneCode = "+\(dialingCode)"
                } 
                else {
                    print("City: \(city), Country: \(country), Country Code: \(isoCountryCode), Dialing Code: Unknown dialing code")
                }
                UserDefaults.standard.setValue(city, forKey: "cityName")
                UserDefaults.standard.setValue(country, forKey: "countryName")
                UserDefaults.standard.set(dialingPhoneCode, forKey: "countryCode")
            }
        }
        
        // Stop updating location after getting the current location
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
