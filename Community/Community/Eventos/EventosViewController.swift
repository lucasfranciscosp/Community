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
    let eventDataManager = EventDataManager()
    let spinner = UIActivityIndicatorView(style: .large)
    var arrayCommunity: [Evento] {
        eventDataManager.eventsArray
    }
    
    let noEventFoundView = NoEventFoundView()
    
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
        eventDataManager.delegate = self
        eventDataManager.fetchEvents()
        noEventFoundView.configure(self)
        collectionView.alwaysBounceVertical = true
    }
    
}

extension EventosViewController {
    private func setupAppBar() {
        title = screenTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    func setupPageRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        removeNoEventFoundView()
        eventDataManager.refreshEvents()
    }
    
    @objc func refreshDataFromButtom() {
        removeNoEventFoundView()
        insertSpinner()
        eventDataManager.refreshEvents()
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
        let vw = noEventFoundView
        vw.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vw)
        NSLayoutConstraint.activate([
            vw.widthAnchor.constraint(equalTo: view.widthAnchor),
            vw.heightAnchor.constraint(equalToConstant: 65),
            vw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vw.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func removeNoEventFoundView() {
        noEventFoundView.removeFromSuperview()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardEventoView", for: indexPath) as? CardEventoView else { return UICollectionViewCell() }
        cell.contentView.isUserInteractionEnabled = false

        cell.configure(self, arrayCommunity[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 330)
    }
}

// MARK: - Data handling
extension EventosViewController: FetchEventDelegate {
    func didRefreshEvents(events: [Evento]) {
        collectionView.reloadData()
        refreshControl.endRefreshing()
        if events.isEmpty {
            removeSpinner()
            insertNoCommunityFoundText()
        }
    }
    
    func didInitialFetchEvents(events: [Evento]) {
        removeNoEventFoundView()
        removeSpinner()
        collectionView.reloadData()
        if events.isEmpty {
            insertNoCommunityFoundText()
        }
    }
    
    func errorFetchingEvents() {
        //handle errors
    }
    
    
}
