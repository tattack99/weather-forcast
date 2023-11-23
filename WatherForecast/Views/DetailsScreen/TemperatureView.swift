//
//  TemperatureView.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-23.
//

import SwiftUI



struct TemperatureView: View {
    let tempData:TemperatureViewData
    let temp:Int
    var body: some View {
        VStack{
            Text(tempData.locationName).font(.custom("Exo-Bold", size: 40)).foregroundColor(.white).padding(.bottom, -8)
            
            Image("sun-cloud")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120).padding(.top,5)
            Text("Today \(tempData.date)").font(.custom("Exo-Medium", size: 18)).foregroundColor(.white).padding(.bottom, -10)
            
            HStack{
                Spacer()
                SunView(image:"sun-up",time:tempData.sunrise)
                Spacer()
                HStack{
                    Text("\(Int(temp))")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(Font.custom("Exo-Bold", size: 100))
                        
                    Text("º")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                        .padding(.leading, -5)
                }
                Spacer()
                SunView(image:"sun-down",time:tempData.sunset)
                Spacer()
            }.padding(.top, -15)
        }
        .padding()
        .padding(.top,30)
        
    }
}

struct SunView: View {
    let image :String
    let time : String
    
   
    var body: some View{
        VStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
            Text(time).font(.custom("Exo-Medium", size: 18)).foregroundColor(.white)
        }
    }
}
