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
    
    func configuraView() {
        communityImage.layer.cornerRadius = 10
        communityImage.layer.masksToBounds = true
    }
    
    
    
}
