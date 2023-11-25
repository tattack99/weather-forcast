//
//  StartPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

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
