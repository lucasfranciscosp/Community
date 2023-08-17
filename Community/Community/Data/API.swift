//
//  API.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import Foundation

//struct Address: Codable {
//    let lat: String
//    let lon: String
//}

struct Location: Codable {
    let placeID: Int
    let licence: String
    let poweredBy: String
    let osmType: String
    let osmID: Int
    let boundingBox: [String]
    let lat: String
    let lon: String
    let displayName: String
    let locationClass: String
    let locationType: String
    let importance: Double
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case poweredBy = "powered_by"
        case osmType = "osm_type"
        case osmID = "osm_id"
        case boundingBox = "boundingbox"
        case lat
        case lon
        case displayName = "display_name"
        case locationClass = "class"
        case locationType = "type"
        case importance
    }
}


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
        // Em path pegamos o cep e definimos colocamos na url
        let latitudeString : String = String(format: "%f", latitude)
        let longitudeString : String = String(format: "%f", longitude)
        
        let path = "reverse?lat=\(latitudeString)&lon=\(longitudeString)"
        print(baseURL+path)
        
        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {
                callback(.failure(.network(error)))
                print("ta vindo aquiii")
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
    
    func getByAddress(address : String, callback: @escaping (Result<Any, ServiceError>) -> Void){
        
        let address1 = address.folding(options: .diacriticInsensitive, locale: .current)
        let modifiedAddress = address1.replacingOccurrences(of: " ", with: "%20")
        
        let path = "search?q=\(modifiedAddress)"
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
                let json = try? JSONDecoder().decode(Location.self , from: data)
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
 
 .task {
             do{
                 let service = Service()
                 service.get(cep: "01001000"){ result in
                     DispatchQueue.main.async {
                         switch result {
                         case let .failure(error):
                             print(error)
                             print("Coloque denovo")
                         case let .success(data):
                             print(data)
                             var teste : Address
                             teste = data as! Address
                             print(teste.bairro)
                         }
                     }
                 }
             }
 
 pelo menos tava printando no outro arquivo, agora é fazer a lógica de como usar isso pra criar comunidade e afins
 */
