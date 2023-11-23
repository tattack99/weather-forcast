//
//  TemperatureView.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-23.
//

import SwiftUI

struct TemperatureView: View {
    var body: some View {
        VStack{
            Text("Stockholm").font(.custom("Exo-Bold", size: 40)).foregroundColor(.white).padding(.bottom, -8)
            
            Image("sun-cloud")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120)
            Text("Today 2023-11-12").font(.custom("Exo-Medium", size: 18)).foregroundColor(.white).padding(.bottom, -10)
            
            HStack{
                Spacer()
                SunView(image:"sun-up",time:"04:52")
                Spacer()
                HStack{
                    Text("15")
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
                SunView(image:"sun-down",time:"19:54")
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
