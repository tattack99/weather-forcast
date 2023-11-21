//
//  WatherForecastApp.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import SwiftUI

@main
struct WatherForecastApp: App {

    private var viewModel = weather_forcastVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
