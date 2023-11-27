//
//  DayListCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI


    
struct DayListCard: View {
    let dailyData: [DayData]
    var body: some View {
        VStack(alignment: .leading){
            Text("Daily forecast").foregroundColor(.white).font(.custom("Exo-regular", size: 14)).padding(.bottom, 5)
            
            VStack(spacing: 20) {
                ForEach(dailyData, id: \.self) { day in
                    DayItem(data: day)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .frame(maxHeight: 400)
        .BlurCardStyle()
        .padding()
    }
}



struct DayItem : View{
    let data : DayData
    var body: some View {
        HStack{
            HStack{
                
                Text(dayName(from:data.dayName))
                    .foregroundColor(.white)
                    .font(.custom("Exo-regular", size: 16))
                
                Spacer()
                Image("sun-cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .padding(.trailing, 5)
                    .padding(.bottom, 10)
                
               
            }
            .frame(width: 80)
            
            Spacer()
            HStack{
                Text("\(Int(data.temp))")
                    .foregroundColor(.white)
                    .font(.custom("Exo-regular", size: 18))
                    
                Text("º")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
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

