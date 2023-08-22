//
//  Localization.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import UIKit
import MapKit

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
            
            let service = Service()
            service.getByLatAndLon(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .failure(error):
                        print(error)
                        completion(nil)
                    case let .success(data):
                        if let endereco = data as? Address {
                            completion(endereco)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
        } else {
            completion(nil)
        }
    }

    
}
