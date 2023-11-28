//
//  DayListCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI


    
struct DayListCard: View {
    let location : Location
    var body: some View {
        VStack(alignment: .leading){
            Text("Daily forecast").foregroundColor(.white).font(.custom("Exo-regular", size: 14)).padding(.bottom, 3)
            
            VStack(spacing: 20) {
                ForEach(location.dayData, id: \.self) { day in
                    DayItem(data: day, isDay: location.currentData.isDay)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .frame(maxHeight: 300)
        .BlurCardStyle(isDay: location.currentData.isDay)
        .padding(.horizontal, 10)
    }
}



struct DayItem : View{
    let data : DayData
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
        HStack{
            HStack{
                
                Text(dayName(from:data.dayName))
                    .foregroundColor(.white)
                    .font(.custom("Exo-regular", size: 16))
                
                Spacer()
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .padding(.trailing, 5)
                    .padding(.bottom, 5)
                
               
            }
            .frame(width: 80)
            HStack{
                if(data.rainProp >= 10){
                    Image(data.temp > 0 ? "rain" : "snow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text("\(data.rainProp)%")
                        .foregroundColor(.white)
                        .font(.custom("Exo-regular", size: 14))
                }
               
            }
            .padding(.leading, 10)
          
            
            Spacer()
          
            Spacer()
            HStack{
                Text("\(Int(data.temp))")
                    .foregroundColor(.white)
                    .font(.custom("Exo-regular", size: 14))
                    
                Text("º")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .padding(.leading, -8)
                    
            }
            
           
           
            
        }
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.5)),
            alignment: .bottom
        )

    }
}

