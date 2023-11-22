//
//  FavoriteLocationCard.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI
import UIKit

struct VisualEffectBlur: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

struct FavoriteLocationCard: View {
    let name: String
    
    var body: some View {
        NavigationLink(destination: DetailsScreen()) {
            HStack{
                VStack(alignment: .leading){
                    Spacer()
                    Text(name)
                    Spacer()
                    Text("15C")
                    Spacer()
                }
                
                Spacer()
                
                Image("sun-cloud")
                    .frame(width: 100)
            }
            .padding(15)
            .cornerRadius(20)
            .background(Color.white.opacity(0.1))
            .background(VisualEffectBlur(effect: UIBlurEffect(style: .systemMaterial)))

            
            
        }
        .navigationTitle(name)
    }
}

