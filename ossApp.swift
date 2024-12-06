//
//  ossApp.swift
//  oss
//
//  Created by Tirawat Nantamas on 6/12/2567 BE.
//

import SwiftUI

@main
struct ossApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
