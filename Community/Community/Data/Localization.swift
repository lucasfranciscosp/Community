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
    

    func testLocal() {
        locManager.requestWhenInUseAuthorization()

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return
            }
            
            do{
                let service = Service()
                service.getByLatAndLon(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude){ result in
                    DispatchQueue.main.async {
                        switch result {
                        case let .failure(error):
                            print(error)
                        case let .success(data):
                            // Dentro daqui printamos os dados da API mandando lat e lon
                            //print(data)
                            var teste : Address
                            teste = data as! Address
                            print(teste.address.cityDistrict)
                            
                            do{
                                
                                let service = Service()
                                service.getByAddress(address: teste.address.cityDistrict){ result in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case let .failure(error):
                                            print(error)
                                            print("Coloque denovo")
                                        case let .success(data):
                                            // Dentro daqui printamos os dados da API mandando o endereço
                                            print(data)
                                            var receber : Location
                                            receber = data as! Location
                                            print(receber)
                                            print("entrei aqui dnv")
                                            
                                        }
                                    }
                                }
                            }

                        }
                    }
                }
            }
            
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
        }
    }
}
