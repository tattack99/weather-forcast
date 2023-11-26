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

struct AddFavoriteLocationView: View {
    @EnvironmentObject var viewModel: weather_forcastVM
    @Binding var showEditSheet: Bool
    @State private var locationInput: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button("Cancel") { showEditSheet = false }
            }
            .padding(.top, 5)

            TextField("Search location", text: $locationInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Add to favorite") {
                submitLocation()
            }
        }
        .padding()
        Spacer()
    }

    private func submitLocation() {
        Task {
            await viewModel.fetchWeatherData(locationName: locationInput)
            await MainActor.run {
                showEditSheet = false
            }
        }
    }
}

