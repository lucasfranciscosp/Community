//
//  Localization.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import UIKit
import MapKit
import CoreLocation

class Localization: NSObject {

    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override init() {
            super.init() // Chame o init da superclasse NSObject
            setupLocationManager()
        }
        func setupLocationManager() {
            locManager.delegate = self
            locManager.requestWhenInUseAuthorization()
            locManager.startUpdatingLocation() // Inicia a obtenção de atualizações de localização
        }

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
                print(currentLocation.coordinate.latitude)
                print(currentLocation.coordinate.longitude)

                let city = placemark.locality ?? ""
                let state = placemark.administrativeArea ?? ""
                let country = placemark.country ?? ""
                let subLocality = placemark.subLocality ?? ""
                let endereco = Address(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude, country: country, state: state, city: city, stateDistrict: subLocality)
                completion(endereco)
            }
        } else {
            // tem que mostrar a tela com o botao pedindo loc dnv
            
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

extension Localization: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            currentLocation = newLocation
            // Você pode chamar a função de obtenção de endereço aqui se desejar
            // getAddress { address in
            //     // Processar o endereço retornado
            // }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error)")
    }
}
