//
//  TemperatureView.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-23.
//

import SwiftUI



struct TemperatureView: View {
    let location : Location

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
        VStack{
            Text(location.name).font(.custom("Exo-Bold", size: 40)).foregroundColor(.white).padding(.bottom, -8)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120).padding(.top,5)
            Text("Today \(location.currentData.date)").font(.custom("Exo-Medium", size: 18)).foregroundColor(.white).padding(.bottom, -10)
            
            HStack{
                Spacer()
                SunView(image:"sun-up",time:location.currentData.sunrise)
                Spacer()
                HStack{
                    Text("\(Int(location.currentData.temp))")
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
                SunView(image:"sun-down",time:location.currentData.sunset)
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
