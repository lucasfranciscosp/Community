//
//  Evento.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 01/09/23.
//

import UIKit
import CloudKit

class Evento: CloudKitSchema {
    var description: String
    var name: String
    var image: UIImage
    var country: String
    var city: String
    var state: String
    var city_district: String
    var nomeComunidade: String
    var dataHorario: String
    
    
    private func getLocalImageUrl() throws -> URL {
        let imagePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("communityCover.jpg")
        let data = image.jpegData(compressionQuality: 1.0)
        
        try data?.write(to: imagePath!)
        return imagePath!
    }
    
    func updateData() async {
        updateRecordValues()
        do {
            let savedEvent = try await CloudKit.defaultContainer.publicCloudDatabase.save(record)
        } catch {
            print("*******ERRO NO UPDATE DA COMUNIDADE******")
            print(error)
        }
        
    }

    func updateRecordValues() {
        do {
            let asset = CKAsset(fileURL: try getLocalImageUrl())
            super.setRecordValues([
                "description": description,
                "name": name,
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
            let savedEvent = try await CloudKit.defaultContainer.publicCloudDatabase.save(record)
        } catch {
            // falta tratar os erros aqui
            print("**DEU ERRO!!!!!!!!**")
            print(error)
        }
    }
    
    static func fetchNearEvents() async throws -> [Evento]{
        var city: String = ""
        var district: String = ""
        var country: String = ""
        var state: String = ""
        var localization: Address?
        
        localization = await Localization().getAddress()
        
        while localization == nil {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            localization = await Localization().getAddress()
        }

        let address = localization!

    
        city = address.city
        district = address.stateDistrict
        country = address.country
        state = address.state
        
        let predicate = NSPredicate(format: "city == %@ AND city_district == %@ AND country == %@ AND state == %@", argumentArray: [city, district, country, state])
        let query = CKQuery(recordType: "evento", predicate: predicate)
        let fetchResult = try await CloudKit.defaultContainer.publicCloudDatabase.records(matching: query)
       var eventos = [Evento]()
        // [(CKRecord.ID, Result<CKRecord, Error>)]
        fetchResult.matchResults.forEach {tupleResult in
            let recordId = tupleResult.0
            let result: Result<CKRecord, Error> = tupleResult.1
            switch result {
            case .success(let success):
                eventos.append(Evento(fromCloudKit: success))
            case .failure(let failure):
                print("**** ERRO AO PUXAR COMUNIDADES PROXIMAS => func fetchNearCommunities")
                print(failure)
            }
        }

        return eventos
        
    }
    
    init(description: String, name: String, tags: String, image: UIImage, country: String, city: String, state: String, city_district: String, nomeComunidade: String, dataHorario: String) {
        self.description = description
        self.name = name
        self.image = image
        self.country = country
        self.city = city
        self.state = state
        self.city_district = city_district
        self.nomeComunidade = nomeComunidade
        self.dataHorario = dataHorario
        super.init(recordName: "comunidade")
    }
    
    override init(fromCloudKit record: CKRecord) {
        self.description = record.value(forKey: "description") as! String
        self.name = record.value(forKey: "name") as! String
        self.country = record.value(forKey: "country") as! String
        self.city = record.value(forKey: "city") as! String
        self.state = record.value(forKey: "state") as! String
        self.city_district = record.value(forKey: "city_district") as! String
        self.nomeComunidade = record.value(forKey: "nomeComunidade") as! String
        self.dataHorario = record.value(forKey: "dataHorario") as! String
        
        
        let imageUrl: URL = (record.value(forKey: "image") as! CKAsset).fileURL!
        if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = UIImage(named: "images")!
        }

        super.init(fromCloudKit: record)
    }
    
}

//Eventos mockados para o usuario usar

var mockEventos = [
    Evento(description: "Um bom lugar para curtir", name: "Good Vibes", tags: "#Paz", image: UIImage(named: "images")!, country: "Brasil", city: "Campinas", state: "SP", city_district: "Cidade Universitaria", nomeComunidade: "Green Peace", dataHorario: "17/04/2023 - 14:00"),
    Evento(description: "Um bom lugar para curtir", name: "Good Vibes", tags: "#Paz", image: UIImage(named: "images")!, country: "Brasil", city: "Campinas", state: "SP", city_district: "Cidade Universitaria", nomeComunidade: "Green Peace", dataHorario: "17/04/2023 - 14:00"),
    Evento(description: "Um bom lugar para curtir", name: "Good Vibes", tags: "#Paz", image: UIImage(named: "images")!, country: "Brasil", city: "Campinas", state: "SP", city_district: "Cidade Universitaria", nomeComunidade: "Green Peace", dataHorario: "17/04/2023 - 14:00"),

]
