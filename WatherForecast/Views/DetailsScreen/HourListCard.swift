//
//  HourListCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct HourListCard: View {
    let location : Location
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Hourly forecast").foregroundColor(.white).font(.custom("Exo-regular", size: 14)).padding(.bottom, 5)
            ScrollView(.horizontal, showsIndicators: false) { // Set to horizontal
                HStack(spacing: 30) {
                    ForEach(location.hourData, id: \.self) { hour in
                        HourItem(data: hour, isDay: location.currentData.isDay)
                     }
                }
            }
        }
        .BlurCardStyle(isDay: location.currentData.isDay)
        .padding(.horizontal, 10)
    }
}



struct HourItem : View{
    let data : HourData
    let isDay: Bool
    
    var image: String {
        get{
            if(isDay){
                if(data.cloudCover < 20){
                    return "sun"
                }
                else if (data.cloudCover  >= 20 && data.cloudCover  < 50){
                    return "sun-cloud"
                }
                else if (data.cloudCover  >= 50 && data.cloudCover < 80){
                    return "cloud-sun"
                }
                else{
                    return "cloud"
                }
            } else {
                if(data.cloudCover < 20){
                    return "moon"
                }
                else if (data.cloudCover  >= 20 && data.cloudCover  < 50){
                    return "moon-cloud"
                }
                else if (data.cloudCover  >= 50 && data.cloudCover < 80){
                    return "cloud-moon"
                }
                else{
                    return "cloud"
                }
            }
            
                
        }
    }
    var body: some View {
        VStack{
            Text(data.time)
                .foregroundColor(.white)
                .font(.custom("Exo-regular", size: 12))
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 26)
             
            
            HStack{
                Text("\(Int(data.temp))")
                    .foregroundColor(.white)
                    .font(.custom("Exo-regular", size: 12))
                    
                Text("º")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .padding(.leading, -8)
                    
            }
        }
        
    }
}


