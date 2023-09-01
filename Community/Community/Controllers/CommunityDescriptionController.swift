//
//  CommunityDescriptionController.swift
//  Community
//
//  Created by Pamella Alvarenga on 16/08/23.
//

import UIKit

class CommunityDescriptionController: UIViewController {
    @IBOutlet weak var communityImage: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descritivoLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    var isEditableByUser: Bool = true
    var comunidade: Comunidade?
    
    override func viewDidLoad() {
        configureView()
        configureLayout()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        if isEditableByUser {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(editCommunity))
        }
    }

    private func configureLayout() {
        communityImage.layer.cornerRadius = 10
        communityImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureView() {
        guard let comunidade = comunidade else { return }
        communityImage.image = comunidade.image
        tituloLabel.text = comunidade.name
        descritivoLabel.text = comunidade.tags
        localLabel.text = comunidade.city_district
        descricaoLabel.text = comunidade.description
    }
    
    @objc private func editCommunity() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Edit-Community", bundle: nil)
        let storyScreen = storyBoard.instantiateViewController(withIdentifier: "EditCommunityViewController") as! EditCommunityViewController
        storyScreen.comunnity = comunidade
        let navController = UINavigationController(rootViewController: storyScreen)
        self.present(navController, animated: true, completion: nil)
    }
}
