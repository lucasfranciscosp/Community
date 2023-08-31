//
//  API.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import Foundation

struct Address: Codable {
    let lat: Double
    let lon: Double
    let country: String  // Extracted from "display_name"
    let state: String
    let city: String
    let stateDistrict: String// Nested "address" dictionary
    
}

// Aqui definiremos a clase Service

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
