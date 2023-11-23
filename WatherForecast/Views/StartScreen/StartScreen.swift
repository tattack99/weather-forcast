//
//  StartPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI
struct TemperatureViewData:Equatable, Hashable {
    var locationName: String
    var currentDate: String
    var sunrise: String
    var sunset: String
}
struct DayItemData: Equatable,Hashable  {
    var day: String
    var image: String
    var temp: Int
}
struct HourItemData: Equatable ,Hashable {
    var time: String
    var image: String
    var temp: Int
}

struct FavoritLocation : Hashable{
    var tempData: TemperatureViewData
    var hourData: [HourItemData]
    var dayData: [DayItemData]
}


struct StartScreen: View {
    @EnvironmentObject var viewModel: weather_forcastVM


    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage(imageName: "start-bg-light", overlayOpacity: 0.1)


                VStack (alignment:.leading){
                    AddButton()
                    ScrollView {
                        ForEach(viewModel.locations, id: \.self) { location in
                            FavoriteLocationCard(location: location)
                                .padding(.bottom, 10)
                        }
                    }
                }
                .padding()
                .padding(.top, 30)

            }
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
            .environmentObject(weather_forcastVM())
    }
}
