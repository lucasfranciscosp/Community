//
//  UserCommunities.swift
//  Community
//
//  Created by Pamella Alvarenga on 01/09/23.
//

import Foundation
import UIKit

class UserCommunitiesViewController: UIViewController {
    // Seu código da tela UserCommunitiesViewController aqui
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 234.0/255, green: 216.0/255, blue: 212.0/255, alpha: 1.0)

        title = "Minhas Comunidades"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.hidesBackButton = false
    }
    

}
