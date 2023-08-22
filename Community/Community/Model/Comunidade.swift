//
//  Comunidade.swift
//  Community
//
//  Created by Pamella Alvarenga on 17/08/23.
//

import Foundation

struct Comunidade {
    let image: String
    let tags: String
    let name: String
    let location: String
    let description: String
}

var mockComunidades = [
    Comunidade(image: "Image", tags: "#xadrez", name: "Reis do Gado", location: "Barão Geraldo", description: ""),
    Comunidade(image: "images", tags: "#pintura", name: "Arte Viva", location: "Centro da Cidade", description: ""),
    Comunidade(image: "images", tags: "#corrida", name: "Runners Unidos", location: "Parque da Cidade", description: ""),
    Comunidade(image: "images", tags: "#culinaria", name: "Sabores do Mundo", location: "Bairro Alegre", description: ""),
    Comunidade(image: "images", tags: "#teatro", name: "Palco Criativo", location: "Teatro Municipal", description: ""),
    Comunidade(image: "images", tags: "#fotografia", name: "Olhares Capturados", location: "Galeria de Arte", description: ""),
    Comunidade(image: "images", tags: "#yoga", name: "Equilíbrio Interior", location: "Estúdio Zen", description: ""),
    Comunidade(image: "images", tags: "#leitura", name: "Amantes dos Livros", location: "Biblioteca Central", description: ""),
    Comunidade(image: "images", tags: "#esporte", name: "Esportistas da Ação", location: "Quadra Esportiva", description: ""),
    Comunidade(image: "images", tags: "#musica", name: "Harmonia Sonora", location: "Casa de Shows", description: ""),
    Comunidade(image: "images", tags: "#jardinagem", name: "Jardineiros Urbanos", location: "Praça Verde", description: ""),
    Comunidade(image: "images", tags: "#danca", name: "Passos Rítmicos", location: "Estúdio de Dança", description: ""),
    Comunidade(image: "images", tags: "#caridade", name: "Mãos Solidárias", location: "Centro Comunitário", description: "")
]

