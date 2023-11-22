//
//  FavoriteLocationCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI



struct FavoriteLocationCard: View {
    let name: String
    
    var body: some View {
        NavigationLink(destination: DetailsScreen()) {
            HStack{
                VStack(alignment: .leading){
                    Text(name)
                        .foregroundColor(.white)
//                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 1)
                        .font(Font.custom("Exo-Bold", size: 30))
                        
                    Spacer()
                    HStack{
                        Text("15")
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
                
                Image("sun-cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    
            }
            .BlurCardStyle()
            

        }
        
     
    }
        
}

