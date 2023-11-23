//
//  TestScreen.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-23.
//

import SwiftUI

struct TestScreen: View {
    @EnvironmentObject var viewModel: weather_forcastVM // Replace with your actual ViewModel class
    @State private var fetchedData: WeatherResponse?
    @State private var isDataFetched = false

    var body: some View {
        VStack {
            Button(action: {
                Task {
                    fetchedData = await viewModel.fetchData()
                    isDataFetched = true
                }
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white) // Text color
                    .padding() // Padding around the plus symbol
                    .background(Circle().fill(Color.blue)) // Circular background
            }

            if isDataFetched, let data = fetchedData {
                Text("Latitude: \(data.latitude), Longitude: \(data.longitude)")
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
