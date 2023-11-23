//
//  StartPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct FavoritLocation {
    var locationName: String
    var temperature: Int
    var rain: Double
    var snow: Double
    var cloud: Int
}

struct StartScreen: View {
    let items = ["Stockholm", "Göteborg", "Malmö"]
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundImage(imageName: "start-bg-light", overlayOpacity: 0.1)
                
                
                VStack (alignment:.leading){
                        AddButton()
                    ScrollView {
                        ForEach(items, id: \.self) { item in
                            FavoriteLocationCard(name: item)
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
    }
}
