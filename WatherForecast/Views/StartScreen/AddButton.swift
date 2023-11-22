//
//  AddButton.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI

struct AddButton: View {
    
    @State private var showEditSheet = false
    
    var body: some View {
        Button(action: {showEditSheet = true}){
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.title2)
                .padding(15)
                .background(VisualEffectBlur(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                .cornerRadius(20)
                .padding(.bottom, 10)
        }
        .sheet(isPresented: $showEditSheet) {
            AddFavoriteLocationView(showEditSheet: $showEditSheet)
        }
        
            
    }
    
}

// Create seperate file when grown
struct AddFavoriteLocationView: View {
    @Binding var showEditSheet : Bool
    var body: some View {
        Button("Close"){
            showEditSheet = false
        }
        Text("Search location input here")
        Text("TODO: ADD UI HERE")
        
    }
}
