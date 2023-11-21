//
//  ContentView.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: weather_forcastVM
    @State private var newText: String = ""
    @State private var isEditing: Bool = false
    @State private var selectedEntityIndex: Int? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entities.indices, id: \.self) { index in
                    Text(viewModel.entities[index].text)
                        .onTapGesture {
                            self.selectedEntityIndex = index
                            self.newText = viewModel.entities[index].text
                            self.isEditing = true
                        }
                }
                .onDelete(perform: deleteEntity)
            }
            .navigationBarItems(leading: addButton, trailing: EditButton())
            .navigationBarTitle("Entities")
        }
        .sheet(isPresented: $isEditing) {
            VStack {
                TextField("Enter text", text: $newText)
                Button("Save") {
                    if let index = selectedEntityIndex {
                        viewModel.updateEntity(at: index, withText: newText)
                    } else {
                        viewModel.createEntity(text: newText)
                    }
                    isEditing = false
                    selectedEntityIndex = nil
                }
                .padding()
            }
        }
    }

    private var addButton: some View {
        Button(action: {
            self.isEditing = true
            self.selectedEntityIndex = nil
            self.newText = ""
        }) {
            Image(systemName: "plus")
        }
    }

    private func deleteEntity(at offsets: IndexSet) {
        for index in offsets {
            viewModel.deleteEntity(at: index)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(weather_forcastVM())
    }
}
