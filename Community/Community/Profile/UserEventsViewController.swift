//
//  UserEventsViewController.swift
//  Community
//
//  Created by Pamella Alvarenga on 01/09/23.
//

import Foundation

import UIKit

class UserEventsViewController: UICollectionViewController {
    // Seu código da tela UserCommunitiesViewController aqui
    
    var addressBegin: Address?
    
    var mockEventos = [
        
        Evento(description: "Bora nadar", name: "Nadar na cachoeira", tags: "#Natureza", image: UIImage(named: "images")!, country: "Brazil", city: "Campinas", state: "SP", city_district: "Cidade Universitaria"),
        Evento(description: "Tornei de Xadrez", name: "Torneio dos Cria", tags: "#Xadrez", image: UIImage(named: "images")!, country: "Brazil", city: "Campinas", state: "SP", city_district: "Cidade Universitaria")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 234.0/255, green: 216.0/255, blue: 212.0/255, alpha: 1.0)

        title = "Meus Eventos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.hidesBackButton = false
        
        collectionViewConfig()
        style()
        layout()
        
        collectionView.backgroundColor = PaleteColor.color2
        Localization().getAddress() { endereco in
            if let endereco = endereco {
                // Usar os dados de endereço aqui
                self.addressBegin = endereco
                //print(endereco.address.city)
                //print(endereco.address.cityDistrict)
            } else {
                // Caso onde não achar o endereço baseado na latitude e longitude
            }
        }
    }
}

//MARK: - Styling

extension UserEventsViewController {
    private func style() {
    
    }
    
    private func layout() {
        
    }
    
}


// MARK: - UICollection implementations

extension UserEventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionViewConfig() {
        // indica o tipo de celula - neste caso e aplicado o padrao UIColletionViewCell
        collectionView?.register(CardEventoView.self, forCellWithReuseIdentifier: "CardEventoView")
        collectionView?.delegate = self
        collectionView.backgroundColor = PaleteColor.color2
    }
   
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockEventos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardEventoView", for: indexPath) as? CardEventoView else { return UICollectionViewCell() }
        cell.contentView.isUserInteractionEnabled = false

        cell.configure(self)
        cell.setDataCell(evento: mockEventos[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 330)
    }
}

