//
//  FavoriteLocationCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI



struct FavoriteLocationCard: View {
    var location: FavoritLocation
  
   
    var body: some View {
        NavigationLink(destination: DetailsScreen(location:location)) {
            HStack{
                VStack(alignment: .leading){
                    Text(location.currentData.locationName)
                        .foregroundColor(.white)
//                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 1)
                        .font(Font.custom("Exo-Bold", size: 30))
                        
                    Spacer()
                    HStack{
                        Text("\(Int(location.currentData.temp))")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(Font.custom("Exo-Bold", size: 50))
                            
                        Text("ºC")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 30))    
                    }
                }
                
                Spacer()
                
                Image("sun-cloud") // TODO: Bases on data (cloud, sun, rain, snow) change image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    
            }
            .BlurCardStyle()
            

        }
        
     
    }
        
}

