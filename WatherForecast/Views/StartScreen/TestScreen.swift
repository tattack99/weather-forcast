//
//  TestScreen.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-23.
//

import SwiftUI

struct TestScreen: View {
    @EnvironmentObject var viewModel: WeatherForcastVM

    var body: some View {
        VStack {
            
            Text(viewModel.hasInternet ? "Connected" : "Not Connected")
                .onAppear{
                    viewModel.checkInternetConnection()
                }
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}


struct TestScreen_Previews: PreviewProvider {
    static var previews: some View {
        TestScreen()
            .environmentObject(WeatherForcastVM())
    }
}
