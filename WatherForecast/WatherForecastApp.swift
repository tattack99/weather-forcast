//
//  WatherForecastApp.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import SwiftUI

@main
struct WatherForecastApp: App {

    private var viewModel =  WeatherForcastVM()
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(viewModel)
                    .onAppear(){
                        viewModel.handleEntities()
                    }
            }
        }
}
