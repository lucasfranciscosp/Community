//
//  SceneDelegate.swift
//  Community
//
//  Created by Pamella Alvarenga on 16/08/23.
//

import UIKit
import CloudKit

func save()  {
    let record = CKRecord(recordType: "test")
    record.setValuesForKeys(["mockValue": "mockKey"])

    
    CKContainer(identifier: "iCloud.br.com.Community").publicCloudDatabase.save(record) { newRecord, error in
        if let error = error {
            print(error)
        } else {
            if let _ = newRecord {
                print("SAVED")
            }
        }
    
        
    }
   
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = PaleteColor.color4
        window?.rootViewController = ScaffoldViewController()
        window?.makeKeyAndVisible()
        save()
    }

}
