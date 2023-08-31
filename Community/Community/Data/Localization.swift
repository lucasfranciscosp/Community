//
//  Localization.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import UIKit
import MapKit
import CoreLocation

class Localization {

    var locManager = CLLocationManager()
    var currentLocation: CLLocation!

    func getAddress(completion: @escaping (Address?) -> Void) {
        locManager.requestWhenInUseAuthorization()

        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() == .authorizedAlways {

            guard let currentLocation = locManager.location else {
                completion(nil)
                return
            }

            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }

                guard let placemark = placemarks?.first else {
                    print("No placemark found")
                    completion(nil)
                    return
                }

                let city = placemark.locality ?? ""
                let state = placemark.administrativeArea ?? ""
                let country = placemark.country ?? ""
                let subLocality = placemark.subLocality ?? ""
                let endereco = Address(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude, country: country, state: state, city: city, stateDistrict: subLocality)
                completion(endereco)
            }
        } else {
            completion(nil)
        }
    }

    func getAddress() async -> Address? {
        return await withCheckedContinuation { continuation in
            getAddress { endereco in
                continuation.resume(returning: endereco)
            }
        }
    }
}
