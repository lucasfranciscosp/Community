//
//  SceneDelegate.swift
//  Community
//
//  Created by Pamella Alvarenga on 16/08/23.
//

import UIKit
import CloudKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = PaleteColor.color4
        window?.rootViewController = ScaffoldViewController()
        window?.makeKeyAndVisible()

    }

}
