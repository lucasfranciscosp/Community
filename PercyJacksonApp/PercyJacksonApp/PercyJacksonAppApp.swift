//
//  PercyJacksonAppApp.swift
//  PercyJacksonApp
//
//  Created by Lucas Francisco on 10/08/23.
//

import SwiftUI

@main
struct PercyJacksonAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
