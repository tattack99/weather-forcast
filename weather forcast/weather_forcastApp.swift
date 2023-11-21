//
//  weather_forcastApp.swift
//  weather forcast
//
//  Created by Tim Johansson on 2023-11-21.
//

import SwiftUI

@main
struct weather_forcastApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
