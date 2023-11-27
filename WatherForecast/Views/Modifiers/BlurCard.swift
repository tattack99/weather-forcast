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
    let light: Bool
    func body(content: Content) -> some View {
        content
            .padding(25)
            
            .background(VisualEffectBlur(effect: UIBlurEffect(style: light ? .systemUltraThinMaterialDark : .regular)))
//            .overlay(
//                RoundedRectangle(cornerRadius: 40)
//                    .stroke(
//                        LinearGradient(gradient: Gradient(colors: [.white.opacity(0.8), .white.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing),
//                        lineWidth: 2
//                )
//            )
            .cornerRadius(40)
    }
}

extension View {

    func BlurCardStyle(light:Bool) -> some View {
        self.modifier(BlurCardModifier(light:light))
    }
}
