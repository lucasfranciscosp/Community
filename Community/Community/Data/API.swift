//
//  API.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import Foundation

struct Address: Codable {
    let lat: String
    let lon: String
    let displayName: String  // Extracted from "display_name"
    let address: InnerAddress  // Nested "address" dictionary
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
        case displayName = "display_name"
        case address
    }
}

struct InnerAddress: Codable {
    let road: String
    let cityDistrict: String
    let city: String
    let municipality: String
    let county: String
    let stateDistrict: String
    let state: String
    let region: String
    let postcode: String
    let country: String
    let countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case road
        case cityDistrict = "city_district"
        case city, municipality, county
        case stateDistrict = "state_district"
        case state, region, postcode, country
        case countryCode = "country_code"
    }
}

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
}

// Aqui definiremos a clase Service

class Service {
    
    private let baseURL = "https://geocode.maps.co/"
    
    func getByLatAndLon(latitude : Double, longitude : Double, callback: @escaping (Result<Any, ServiceError>) -> Void){
        // Transforma o valor de double em string
        let latitudeString : String = String(format: "%f", latitude)
        let longitudeString : String = String(format: "%f", longitude)
        
        // Em path pegamos a latitude e longitude e colocamos na url
        let path = "reverse?lat=\(latitudeString)&lon=\(longitudeString)"
        print(baseURL+path)
        
        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {
                callback(.failure(.network(error)))
                return
            }
            
            guard
                let json = try? JSONDecoder().decode(Address.self , from: data)
            else{
                callback(.failure(.network(error)))
                return
            }
            callback(.success(json))
        }
        task.resume()
    }
    
}


/*
 Para usar a API:
 
 dentro da view usar isso:
 
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
                 print(teste.address.state)
                 print(teste.address.country)
                 print(teste.address.city)
                 print(teste.address.municipality)
             }
         }
     }
 }
 
 pelo menos tava printando no outro arquivo, agora é fazer a lógica de como usar isso pra criar comunidade e afins
 */
