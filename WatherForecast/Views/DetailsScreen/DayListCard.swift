//
//  DayListCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI


    
struct DayListCard: View {
    let dailyData = generateDailyData()
    var body: some View {
        VStack(alignment: .leading){
            Text("Daily forecast").foregroundColor(.white).font(.custom("Exo-regular", size: 14)).padding(.bottom, 5)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(dailyData, id: \.self) { day in
                        DayItem(data: day)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxHeight: 300)
        .BlurCardStyle()
        .padding()
    }
}


struct DayItemData: Hashable  {
    var day: String
    var image: String
    var temp: Int
}
struct DayItem : View{
    let data : DayItemData
    var body: some View {
        HStack{
            HStack{
                
                Text(data.day)
                    .foregroundColor(.white)
                    .font(.custom("Exo-regular", size: 16))
                
                Spacer()
                Image(data.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .padding(.trailing, 5)
                    .padding(.bottom, 10)
                
               
            }
            .frame(width: 80)
            
            Spacer()
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
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.5)),
            alignment: .bottom
        )

    }
}


func generateDailyData() -> [DayItemData] {
    var dailyData: [DayItemData] = []
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    
  
    let dayNames = ["Mon", "Tues", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    for dayIndex in 0..<7 {
        let day = dayNames[dayIndex]
        let image = "cloud-sun"
        let temp = Int.random(in: 5...15)
        
        let data = DayItemData(day: day, image: image, temp: temp)
        dailyData.append(data)
    }
    
    return dailyData
}
