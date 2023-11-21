//
//  WatherForecastApp.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import SwiftUI

@main
struct WatherForecastApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
