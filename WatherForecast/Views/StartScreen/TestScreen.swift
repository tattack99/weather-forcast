//
//  TestScreen.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-23.
//

import SwiftUI

struct TestScreen: View {
    @EnvironmentObject var viewModel: weather_forcastVM

    var body: some View {
        VStack {
            
            Text(viewModel.hasInternet ? "Connected" : "Not Connected")
                .onAppear{
                    viewModel.checkInternetConnection()
                }
        }
    }
}


struct TestScreen_Previews: PreviewProvider {
    static var previews: some View {
        TestScreen()
            .environmentObject(weather_forcastVM())
    }
}
