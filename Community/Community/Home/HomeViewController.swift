//
//  ControllerView.swift
//  Community
//
//  Created by Pamella Alvarenga on 16/08/23.
//

import UIKit
import CloudKit

class HomeViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        style()
        layout()
        collectionViewConfig()
        collectionView.backgroundColor = PaleteColor.color2
    }
}

//MARK: - Styling

extension HomeViewController {
    private func style() {
        
    }
    
    private func layout() {
        
    }
    
    private func setupAppBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        title = "Comunidades"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    @objc private func add() {
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Create-Community", bundle: nil)
        //        let storyScreen = storyBoard.instantiateViewController(withIdentifier: "CreateCommunityViewController") as! CreateCommunityViewController
        //        let navController = UINavigationController(rootViewController: storyScreen)
        //        self.present(navController, animated: true, completion: nil)
        //        print("clicou em adicionar")
        // codigo de fetch
        // print()
        
        let query = CKQuery(recordType: "comunidade", predicate: NSPredicate(value: true)) // consulta query, busca registros do tipo comunidade"
        let database = CKContainer.default().publicCloudDatabase // usa a instância padrão "CKContainer"para acessar o banco de dados público do Cloukit
        
        //Método que executa a consulta:
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Error fetching records: \(error)")
            } else if let records = records {
                let comunidades: [Comunidade] = records.compactMap { record in
                    guard
                        let description = record.value(forKey: "description") as? String,
                        let name = record.value(forKey: "name") as? String,
                        let tags = record.value(forKey: "tags") as? String,
                        let image = record.value(forKey: "image") as? CKAsset,
                        let country = record.value(forKey: "country") as? String,
                        let city = record.value(forKey: "city") as? String,
                        let state = record.value(forKey: "state") as? String,
                        let city_district = record.value(forKey: "city_district") as? String
                            
                    else {
                        print("nao deu certo") // Se algum valor estiver faltando, não é possível criar uma instância
                        return mockComunidades[0]
                        
                    }
                    print(image)
                    
                    
                    
                    return Comunidade(
                        description: description,
                        name: name,
                        tags: tags,
                        image: image.fileURL!.absoluteString,
                        country: country,
                        city: city,
                        state: state,
                        city_district: city_district
                    )
                    //                   return mockComunidades[0]
                    
                }
                print("Fetched comunidade: \(comunidades)")
            }
        }
        
        //        Localization().testLocal()
    }
}

// MARK: - UICollection implementations

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionViewConfig() {
        // indica o tipo de celula - neste caso e aplicado o padrao UIColletionViewCell
        collectionView?.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Comunity-Details", bundle: nil)
        
        let storyScreen = storyBoard.instantiateViewController(withIdentifier: "CommunityDescriptionController") as! CommunityDescriptionController
        storyScreen.comunidade = mockComunidades[indexPath.row]
        
        // Personalize a barra de navegação do controlador de destino (modal)
        let navigationController = UINavigationController(rootViewController: storyScreen)
        navigationController.modalPresentationStyle = .automatic  // Define o estilo de apresentação modal (tela cheia)
        
        // Crie uma view para simular a linha no bottom da barra de navegação
        let bottomLineView = UIView(frame: CGRect(x: 0, y: navigationController.navigationBar.frame.height, width: navigationController.navigationBar.frame.width, height: 0.2))
        bottomLineView.backgroundColor = .lightGray  // Cor da linha
        
        navigationController.navigationBar.addSubview(bottomLineView)
        
        
        // Crie um botão "back" com título
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        
        // Defina o botão "back" como o botão esquerdo da barra de navegação
        storyScreen.navigationItem.leftBarButtonItem = backButton
        
        
        backButton.target = self
        backButton.action = #selector(backButtonTapped)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockComunidades.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        let comunidade = mockComunidades[indexPath.row]
        cell.setCell(data: HomeCollectionViewCellData(image: comunidade.image, tags: comunidade.tags, name: comunidade.name, location: "place holder"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 550)
    }
}
