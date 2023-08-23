//
//  Comunidade.swift
//  Community
//
//  Created by Pamella Alvarenga on 17/08/23.
//

import CloudKit

class Comunidade: CloudKitSchema {
    let description: String
    let name: String
    let tags: String
    let image: String
    let country: String
    let city: String
    let state: String
    let city_district: String
    
    func updateRecordValues() {
        super.setRecordValues([
            "description": description,
            "name": name,
            "tags": tags,
            "image": image,
            "country": country,
            "city": city,
            "state": state,
            "city_district": city_district
        ])
    }
    
    func saveInDatabase() async {
        updateRecordValues()
        do {
            let savedCommunity = try await CloudKit.defaultContainer.publicCloudDatabase.save(record)
        } catch {
           // falta tratar os erros aqui
            print("**DEU ERRO!!!!!!!!**")
        }
    }
    
    init(description: String, name: String, tags: String, image: String, country: String, city: String, state: String, city_district: String) {
        self.description = description
        self.name = name
        self.tags = tags
        self.image = image
        self.country = country
        self.city = city
        self.state = state
        self.city_district = city_district
        super.init(recordName: "comunidade")
    }
}

var mockComunidades = [
    Comunidade(description: "Os reis do gado juntos reunidos", name: "Rei do Gado", tags: "Gadisse", image: "Image", country: "Brazil", city: "Campinas", state: "São Paulo", city_district: "Barão Geraldo"),
    Comunidade(description: "Os reis do gado juntos reunidos", name: "Rei do Gado", tags: "Gadisse", image: "images", country: "Brazil", city: "Campinas", state: "São Paulo", city_district: "Barão Geraldo"),
    Comunidade(description: "hasuhsauhsauhusahusa", name: "Os COnfeiteiros", tags: "Culinária", image: "images", country: "Brazil", city: "Campinas", state: "São Paulo", city_district: "Jardim Santa Genebra")
]

