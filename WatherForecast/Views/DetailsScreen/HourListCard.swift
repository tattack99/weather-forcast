//
//  HourListCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct HourListCard: View {
    let hourlyData : [HourItemData]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Hourly forecast").foregroundColor(.white).font(.custom("Exo-regular", size: 14)).padding(.bottom, 5)
            ScrollView(.horizontal, showsIndicators: false) { // Set to horizontal
                HStack(spacing: 30) {
                     ForEach(hourlyData, id: \.self) { hour in
                         HourItem(data: hour)
                     }
                }
            }
        }
        .BlurCardStyle()
        .padding()
    }
}



struct HourItem : View{
    let data : HourItemData
    var body: some View {
        VStack{
            Text(data.time)
                .foregroundColor(.white)
                .font(.custom("Exo-regular", size: 16))
            
            Image(data.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
             
            
            HStack{
                Text("\(data.temp)")
                    .foregroundColor(.white)
                    .font(.custom("Exo-regular", size: 18))
                    
                Text("º")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .padding(.leading, -8)
                    
            }
        }
        
    }
}


