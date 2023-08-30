//
//  EventosViewController.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 30/08/23.
//

import UIKit

class EventosViewController: UICollectionViewController {
    
    let screenTitle: String
    var refreshControl: UIRefreshControl!
    let communityDataManager = CommunityDataManager()
    let spinner = UIActivityIndicatorView(style: .large)
    var arrayCommunity: [Comunidade] {
        communityDataManager.communitiesArray
    }
    
    let noCommunityFoundView = NoCommunityFoundView()
    
    init(screenTitle: String) {
        self.screenTitle = screenTitle
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertSpinner()
        setupAppBar()
        collectionViewConfig()
        setupPageRefresh()
        communityDataManager.delegate = self
        communityDataManager.fetchCommunities()
        //noCommunityFoundView.configure(self)
        collectionView.alwaysBounceVertical = true
    }
    
}

extension EventosViewController {
    private func setupAppBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        title = screenTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    @objc private func add() {

    }
    
    func setupPageRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        removeNoCommunityFoundText()
        communityDataManager.refreshCommunities()
    }
    
    @objc func refreshDataFromButtom() {
        removeNoCommunityFoundText()
        insertSpinner()
        communityDataManager.refreshCommunities()
    }
    
    
    
    func insertSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func removeSpinner() {
        spinner.stopAnimating()
        self.spinner.removeFromSuperview()
        
    }
    
    func insertNoCommunityFoundText() {
        let vw = noCommunityFoundView
        vw.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vw)
        NSLayoutConstraint.activate([
            vw.widthAnchor.constraint(equalTo: view.widthAnchor),
            vw.heightAnchor.constraint(equalToConstant: 65),
            vw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vw.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func removeNoCommunityFoundText() {
        noCommunityFoundView.removeFromSuperview()
    }
    
    
}

// MARK: - UICollection implementations

extension EventosViewController: UICollectionViewDelegateFlowLayout {
    func collectionViewConfig() {
        // indica o tipo de celula - neste caso e aplicado o padrao UIColletionViewCell
        collectionView?.register(CardEventoView.self, forCellWithReuseIdentifier: "CardEventoView")
        collectionView?.delegate = self
        collectionView.backgroundColor = PaleteColor.color2
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // *********Action on tap card*********
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Comunity-Details", bundle: nil)
//
//        let storyScreen = storyBoard.instantiateViewController(withIdentifier: "CommunityDescriptionController") as! CommunityDescriptionController
//        storyScreen.comunidade = arrayCommunity[indexPath.row]
//
//        // Personalize a barra de navegação do controlador de destino (modal)
//        let navigationController = UINavigationController(rootViewController: storyScreen)
//        navigationController.modalPresentationStyle = .automatic  // Define o estilo de apresentação modal (tela cheia)
//
//        // Crie uma view para simular a linha no bottom da barra de navegação
//        let bottomLineView = UIView(frame: CGRect(x: 0, y: navigationController.navigationBar.frame.height, width: navigationController.navigationBar.frame.width, height: 0.2))
//        bottomLineView.backgroundColor = .lightGray  // Cor da linha
//
//        //navigationController.navigationBar.addSubview(bottomLineView)
//
//
//        // Crie um botão "back" com título
//        let backButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(backButtonTapped))
//
//        // Defina o botão "back" como o botão esquerdo da barra de navegação
//        storyScreen.navigationItem.leftBarButtonItem = backButton
//
//
//        backButton.target = self
//        backButton.action = #selector(backButtonTapped)
//
//        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCommunity.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardEventoView", for: indexPath) as? CardEventoView else { return UICollectionViewCell() }
        

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 330)
    }
}

// MARK: - Data handling
extension EventosViewController: FetchCommunityDelegate {
    func didRefreshCommunities(communities: [Comunidade]) {
        collectionView.reloadData()
        refreshControl.endRefreshing()
        if communities.isEmpty {
            removeSpinner()
            insertNoCommunityFoundText()
        }
    }
    
    func didInitialFetchCommunities(communities: [Comunidade]) {
        removeNoCommunityFoundText()
        removeSpinner()
        collectionView.reloadData()
        if communities.isEmpty {
            insertNoCommunityFoundText()
        }
    }
    
    func errorFetchingCommunities() {
        //handle errors
    }
    
    
}
