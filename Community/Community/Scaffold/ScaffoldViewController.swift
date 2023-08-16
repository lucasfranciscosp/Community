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
    }

    private func setupViews() {
        let homeVC = HomeViewController()
        let leafVC = LeafViewController()
        let profile = ProfileViewController()

        homeVC.setTabBarImage(imageName: "house", title: "Home")
        leafVC.setTabBarImage(imageName: "leaf.fill", title: "Label")
        profile.setTabBarImage(imageName: "person.crop.circle.fill", title: "Profile")

        let homeNC = UINavigationController(rootViewController: homeVC)
        let leafNC = UINavigationController(rootViewController: leafVC)
        let profileNC = UINavigationController(rootViewController: profile)

//        homeNC.navigationBar.barTintColor = .systemTeal
//        hideNavigationBarLine(homeNC.navigationBar)
        
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
        //tabBar.tintColor = appColor
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
