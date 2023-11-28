//
//  StartPage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject var viewModel: WeatherForcastVM
    @State private var selectedLocation: Location?
    
    var img: String {
        get{
            return isDaytime() ? "bg-light" : "bg-dark"
        }
    }

    var body: some View {
        Group{
            if viewModel.deviceOrientation.isLandscape {
                NavigationView {
                    
                    VStack{
                        
                        ScrollView {
                            ForEach(viewModel.locations, id: \.self) { location in
                                NavigationLink(destination: DetailsScreen(location: location)) {
                                    FavoriteLocationCard(location: location)
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                        .navigationBarItems(leading: AddButton())
                        .navigationBarItems(trailing: connected)
                        .background(BackgroundImage(imageName: img, overlayOpacity: 0.1).edgesIgnoringSafeArea(.all))
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
            else {
                NavigationView {
                    ZStack {
                        BackgroundImage(imageName:  img, overlayOpacity: 0.1)
                        VStack (alignment:.leading) {
                            HStack{
                                Spacer()
                                Text(viewModel.hasInternet ? "" : "Not Connected")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                
                                Spacer()
                            }
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
        .onRotate { newOrientation in viewModel.deviceOrientation = newOrientation}
    }
    
    var connected : some View {
        HStack{
            Spacer()
            Text(viewModel.hasInternet ? "" : "Not Connected")
                .font(.headline)
                .foregroundColor(.red)
            Spacer()
        }
    }
}


struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
            .environmentObject(WeatherForcastVM())
    }
}
