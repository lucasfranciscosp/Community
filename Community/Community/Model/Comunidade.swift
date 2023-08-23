//
//  Comunidade.swift
//  Community
//
//  Created by Pamella Alvarenga on 17/08/23.
//

import CloudKit
import UIKit

class Comunidade: CloudKitSchema {
    let description: String
    let name: String
    let tags: String
    private let image: UIImage
    let country: String
    let city: String
    let state: String
    let city_district: String
    
    var imageUrl: String {
        "Image"
    }
    
    private func getLocalImageUrl() throws -> URL {
        let imagePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("communityCover.jpg")
        let data = image.jpegData(compressionQuality: 1.0)
        
        try data?.write(to: imagePath!)
        return imagePath!
    }
    
    func updateRecordValues() {
        do {
            let asset = CKAsset(fileURL: try getLocalImageUrl())
            super.setRecordValues([
                "description": description,
                "name": name,
                "tags": tags,
                "image": asset,
                "country": country,
                "city": city,
                "state": state,
                "city_district": city_district
            ])
        } catch {
            print("***ERRO ao dar update no record***")
            print(error)
        }
        
    }
    
    func saveInDatabase() async {
        updateRecordValues()
        do {
            let savedCommunity = try await CloudKit.defaultContainer.publicCloudDatabase.save(record)
        } catch {
            // falta tratar os erros aqui
            print("**DEU ERRO!!!!!!!!**")
            print(error)
        }
    }
    
    static func fetchNearCommunities() async throws -> [Comunidade]{
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return mockComunidades
        
    }
    
    init(description: String, name: String, tags: String, image: UIImage, country: String, city: String, state: String, city_district: String) {
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
    Comunidade(description: "Imagens teste", name: "Rei do Gado", tags: "Gadisse", image: UIImage(named: "Image")!, country: "Brazil", city: "Campinas", state: "São Paulo", city_district: "Barão Geraldo"),
    Comunidade(description: "Os reis do gado juntos reunidos", name: "Rei do Gado", tags: "Gadisse", image: UIImage(named: "Image")!, country: "Brazil", city: "Campinas", state: "São Paulo", city_district: "Barão Geraldo")
]

