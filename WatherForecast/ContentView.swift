//
//  ContentView.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: weather_forcastVM
    var body: some View {
       //StartScreen()
        TestScreen()
    }

   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(weather_forcastVM())
    }
}
