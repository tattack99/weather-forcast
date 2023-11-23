//
//  HourListCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct HourListCard: View {
    let hourlyData = generateHourlyData()
    
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


struct HourItemData: Hashable  {
    var time: String
    var image: String
    var temp: Int
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

// DAMMAY DATA, DELETE THEN
func generateHourlyData() -> [HourItemData] {
    var hourlyData: [HourItemData] = []
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    for hour in 0..<24 {
        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
        let time = dateFormatter.string(from: date)
        let image = "cloud-sun"
        let temp = Int.random(in: 5...15)
        
        let data = HourItemData(time: time, image: image, temp: temp)
        hourlyData.append(data)
    }
    
    return hourlyData
}


