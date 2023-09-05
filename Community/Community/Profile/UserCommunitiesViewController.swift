//
//  UserCommunities.swift
//  Community
//
//  Created by Pamella Alvarenga on 01/09/23.
//

import Foundation
import UIKit

class UserCommunitiesViewController: UICollectionViewController {
    // Seu código da tela UserCommunitiesViewController aqui
    
    var addressBegin: Address?
    var arrayCommunity : [Comunidade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 234.0/255, green: 216.0/255, blue: 212.0/255, alpha: 1.0)
        title = "Minhas Comunidades"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = false
       
        collectionViewConfig()
        
        Task {
            do {
                try arrayCommunity = await Comunidade.fetchNearCommunities()
                collectionView.reloadData()
            } catch {
                // Lide com erros de forma apropriada
                print("Erro ao buscar comunidades: \(error)")
            }
        }
        
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

extension UserCommunitiesViewController {
    private func style() {
    
    }
    
    private func layout() {
        
    }
    
}

// MARK: - UICollection implementations

extension UserCommunitiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionViewConfig() {
        // indica o tipo de celula - neste caso e aplicado o padrao UIColletionViewCell
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView?.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Comunity-Details", bundle: nil)
        
        let storyScreen = storyBoard.instantiateViewController(withIdentifier: "CommunityDescriptionController") as! CommunityDescriptionController
        storyScreen.comunidade = arrayCommunity[indexPath.row]

        // Personalize a barra de navegação do controlador de destino (modal)
           let navigationController = UINavigationController(rootViewController: storyScreen)
           navigationController.modalPresentationStyle = .automatic  // Define o estilo de apresentação modal (tela cheia)
           
        // Crie uma view para simular a linha no bottom da barra de navegação
        let bottomLineView = UIView(frame: CGRect(x: 0, y: navigationController.navigationBar.frame.height, width: navigationController.navigationBar.frame.width, height: 0.2))
        bottomLineView.backgroundColor = .lightGray  // Cor da linha
            
            //navigationController.navigationBar.addSubview(bottomLineView)
        
        
           // Crie um botão "back" com título
           //let backButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(backButtonTapped))
           
           // Defina o botão "back" como o botão esquerdo da barra de navegação
           //storyScreen.navigationItem.leftBarButtonItem = backButton
           
        
        //backButton.target = self
        //backButton.action = #selector(backButtonTapped)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
//    @objc func backButtonTapped() {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCommunity.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }

        cell.setCell(data: HomeCollectionViewCellData(image: arrayCommunity[indexPath.row].image, tags: arrayCommunity[indexPath.row].tags, name: arrayCommunity[indexPath.row].name, location: "\(arrayCommunity[indexPath.row].city), \(arrayCommunity[indexPath.row].city_district)"))
        
        return cell
      }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 550)
    }
}
