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
            
            VStack{
                HourListCard()
                DayListCard()
            }
            
            
        }
    }
}


struct DetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}
