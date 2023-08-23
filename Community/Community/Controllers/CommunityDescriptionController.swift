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
    @IBOutlet weak var navBar: UINavigationBar!
    
    var comunidade: Comunidade?
    
    override func viewDidLoad() {
        configuraView()
        communityImage.layer.cornerRadius = 10
        communityImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func configuraView() {
        
        
        guard let comunidade = comunidade else { return }
        
//        communityImage.image = UIImage(named: comunidade.image)
        tituloLabel.text = comunidade.name
//        localLabel.text = comunidade.location
        descritivoLabel.text = comunidade.tags
        
     
        
    }
    
    
    
}
