//
//  DetailsPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct DetailsScreen: View {
    let location: FavoritLocation
    
    
    
    var body: some View {
        ZStack {
            
            BackgroundImage(imageName: "details-bg-light", overlayOpacity: 0.1)
            ScrollView(showsIndicators: false){
                VStack{
                    TemperatureView(tempData: location.tempData, temp: location.dayData[0].temp)
                    HourListCard(hourlyData:location.hourData).padding(.vertical, -20)
                    DayListCard(dailyData:location.dayData).padding(.bottom,30)
                }
            }
        }
    }
    
    
}


