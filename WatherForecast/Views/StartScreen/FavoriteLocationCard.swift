//
//  FavoriteLocationCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI



struct FavoriteLocationCard: View {
    var location: Location
  
    var image: String {
        get{
            if(location.currentData.isDay){
                if(location.currentData.cloudCover < 20){
                    return "sun"
                }
                else if (location.currentData.cloudCover >= 20 && location.currentData.cloudCover < 50){
                    return "sun-cloud"
                }
                else if (location.currentData.cloudCover >= 50 && location.currentData.cloudCover < 80){
                    return "cloud-sun"
                }
                else{
                    return "cloud"
                }
            }else {
                if(location.currentData.cloudCover < 20){
                    return "moon"
                }
                else if (location.currentData.cloudCover >= 20 && location.currentData.cloudCover < 50){
                    return "moon-cloud"
                }
                else if (location.currentData.cloudCover >= 50 && location.currentData.cloudCover < 80){
                    return "cloud-moon"
                }
                else{
                    return "cloud"
                }
            }
        }
    }
    
   
    var body: some View {
        NavigationLink(destination: DetailsScreen(location:location)) {
            HStack{
                VStack(alignment: .leading){
                    Text(location.name)
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
                
                Image(image) 
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    
            }
            .BlurCardStyle(light: location.currentData.isDay)
            

        }
        
     
    }
        
}

