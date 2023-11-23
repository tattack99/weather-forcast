//
//  DetailsPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct DetailsScreen: View {
    var body: some View {
        ZStack {
            
            BackgroundImage(imageName: "details-bg-light", overlayOpacity: 0.1)
            ScrollView(showsIndicators: false){
                VStack{
                    TemperatureView()
                    HourListCard().padding(.vertical, -20)
                    DayListCard().padding(.bottom,30)
                }
            }
        }
    }
}


struct DetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}
