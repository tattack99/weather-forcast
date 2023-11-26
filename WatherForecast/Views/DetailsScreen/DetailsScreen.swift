//
//  DetailsPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct DetailsScreen: View {
    @EnvironmentObject var viewModel: weather_forcastVM
    let location: FavoritLocation
    
    @ViewBuilder
    var body: some View {
        Group {
            if viewModel.deviceOrientation.isPortrait {
                portraitView
            } else {
                landscapeView
            }
        }
    }
    private var portraitView: some View {
            ZStack {
                BackgroundImage(imageName: "details-bg-light", overlayOpacity: 0.1)
                ScrollView(showsIndicators: false) {
                    VStack {
                        TemperatureView(tempData: location.tempData, temp: Int(location.dayData[0].temp))
                        HourListCard(hourlyData: location.hourData).padding(.vertical, -20)
                        DayListCard(dailyData: location.dayData).padding(.bottom, 30)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        
        private var landscapeView: some View {
            // Your implementation for landscape orientation
            ZStack {
                BackgroundImage(imageName: "details-bg-light", overlayOpacity: 0.1)
                    .position(backgroundPosition)
                ScrollView(showsIndicators: false) {
                    VStack {
                        TemperatureView(tempData: location.tempData, temp: Int(location.dayData[0].temp))
                        HourListCard(hourlyData: location.hourData).padding(.vertical, -20)
                        DayListCard(dailyData: location.dayData).padding(.bottom, 30)
                    }
                    .padding(.all, 25) // This adds padding to accommodate for the notch
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    
    // Calculate the position based on the orientation
    private var backgroundPosition: CGPoint {
        viewModel.deviceOrientation.isPortrait ? CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2) :
        CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.width / 2) // Example for landscape
    }
    
    
}


