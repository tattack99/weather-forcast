//
//  TemperatureView.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct TemperatureView: View {
    let temp: Int
    let tempSize: Int
    let cSize: Int
    let space : Int
    var body: some View {
        HStack{
            Text("\(temp)")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(Font.custom("Exo-Bold", size: CGFloat(tempSize)))
                
            Text("ºC")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: CGFloat(cSize)))
                .padding(.leading, CGFloat(space))
                
        }
    }
}

