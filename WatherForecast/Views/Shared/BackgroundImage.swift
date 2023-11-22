//
//  BackgroundImage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct BackgroundImage: View {
    let imageName: String
    let overlayOpacity: Double
   
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Rectangle()
                    .opacity(overlayOpacity)
                    .foregroundColor(.black)
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

