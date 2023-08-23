//
//  ControllerView.swift
//  Community
//
//  Created by Pamella Alvarenga on 16/08/23.
//

import UIKit

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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Create-Community", bundle: nil)
        let storyScreen = storyBoard.instantiateViewController(withIdentifier: "CreateCommunityViewController") as! CreateCommunityViewController
        let navController = UINavigationController(rootViewController: storyScreen)
        self.present(navController, animated: true, completion: nil)
        print("clicou em adicionar")
        Localization().testLocal()
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
