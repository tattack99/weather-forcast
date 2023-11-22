//
//  StartPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct StartScreen: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        ZStack {
            
            Image("start-bg-light")
                .resizable() 
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            
            NavigationView {
                ScrollView {
                    VStack {
                        ForEach(items, id: \.self) { item in
                            FavoriteLocationCard(name: item)
                        }
                    }
                }
                .navigationBarTitle("Items", displayMode: .inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
