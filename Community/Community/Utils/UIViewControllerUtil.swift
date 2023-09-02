//
//  UIViewController.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 16/08/23.
//

import Foundation

import UIKit

extension UIViewController {
    
    func setTabBarImage(unSelectedImage: String, selectedImage: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: unSelectedImage, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        tabBarItem.selectedImage = UIImage(systemName: selectedImage, withConfiguration: configuration)
        
    }
}
