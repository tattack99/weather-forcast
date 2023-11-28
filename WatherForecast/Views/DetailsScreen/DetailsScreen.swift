//
//  DetailsPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct DetailsScreen: View {
    @EnvironmentObject var viewModel: WeatherForcastVM
    let location: Location
    
    var img: String {
        get{
            return location.currentData.isDay ? "bg-light-new" : "bg-dark-new"
        }
    }
    
    @ViewBuilder
    var body: some View {
        Group {
            if viewModel.deviceOrientation.isLandscape {
                landscapeView
                
            } else {
                portraitView
            }
        }
    }
    private var portraitView: some View {
            ZStack {
                BackgroundImage(imageName: img, overlayOpacity: 0.1)
                
                VStack {
                    TemperatureView(location:location).padding(.top, 30)
                    HourListCard(location:location)
                    DayListCard(location:location).padding(.bottom, 20)
                }
                
            }
            .edgesIgnoringSafeArea(.all)
        }
        
        private var landscapeView: some View {
            // Your implementation for landscape orientation
            ZStack {
                BackgroundImage(imageName: img, overlayOpacity: 0.1)
                    .position(backgroundPosition)
                ScrollView(showsIndicators: false) {
                    VStack {
                        TemperatureView(location: location)
                        HourListCard(location: location).padding(.vertical, -20)
                        DayListCard(location: location).padding(.bottom, 30)
                    }
                    .padding(.all, 25) // This adds padding to accommodate for the notch
                }
            }
            .padding()
            .edgesIgnoringSafeArea(.all)
        }
    
    // Calculate the position based on the orientation
    private var backgroundPosition: CGPoint {
        viewModel.deviceOrientation.isPortrait ? CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2) :
        CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.width / 2) // Example for landscape
    }
    
    
}


