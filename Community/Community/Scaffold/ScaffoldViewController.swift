//
//  ScaffoldViewController.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 16/08/23.
//

import UIKit

class ScaffoldViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
        UITabBar.appearance().barTintColor = PaleteColor.color2
    }

    private func setupViews() {
        let homeVC = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let leafVC = LeafViewController()
        let profile = ProfileViewController()

        homeVC.setTabBarImage(unSelectedImage: "person.3", selectedImage: "person.3.fill", title: "Comunidades")
        leafVC.setTabBarImage(unSelectedImage: "party.popper", selectedImage: "party.popper.fill", title: "Eventos")
        profile.setTabBarImage(unSelectedImage: "person.circle", selectedImage: "person.circle.fill", title: "Perfil")
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let leafNC = UINavigationController(rootViewController: leafVC)
        let profileNC = UINavigationController(rootViewController: profile)

        let tabBarList = [homeNC, leafNC, profileNC]

        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
    }
}


class LeafViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
