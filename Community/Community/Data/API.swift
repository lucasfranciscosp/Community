//
//  API.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import Foundation

struct Address: Codable {
    let cep: String
    let logradouro: String
    let bairro: String
    let localidade: String
    let uf: String
}

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
}

// Aqui definiremos a clase Service

class Service {
    
    private let baseURL = "https://viacep.com.br/ws"
    
    func get(cep : String, callback: @escaping (Result<Any, ServiceError>) -> Void){
        // Em path pegamos o cep e definimos colocamos na url
        
        let path = "/\(cep)/json"
        
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
