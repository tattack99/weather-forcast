//
//  BlueCardStyle.swift
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

struct BlurCardModifier: ViewModifier {
    let isDay:Bool
    func body(content: Content) -> some View {
        content
            .padding(20)
            
            .background(VisualEffectBlur(effect: UIBlurEffect(style: isDay ? .regular: .systemUltraThinMaterialDark)))

            .cornerRadius(30)
    }
}

extension View {

    func BlurCardStyle(isDay:Bool) -> some View {
        self.modifier(BlurCardModifier(isDay:isDay))
    }
}
