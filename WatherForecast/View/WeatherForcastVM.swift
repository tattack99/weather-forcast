//
//  WeatherForcastVM.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-21.
//

import Foundation

struct Persistance {
    var text : String
}

class weather_forcastVM : ObservableObject {
    @Published var entities : [Persistance] = []
    var storage = PersistenceController()
    
    init(){
        loadEntities()
    }
    
    private func loadEntities() {
        let fetchedEntities = storage.fetchEntities().map { Persistance(text: $0.text ?? "") }
        DispatchQueue.main.async {
            self.entities = fetchedEntities
        }
    }
    
    func createEntity(text: String) {
        let newPersistance = Persistance(text: text)
        storage.createEntity(withData: newPersistance)
        loadEntities()
    }
    
    func updateEntity(at index: Int, withText text: String) {
        let entityToUpdate = storage.fetchEntities()[index]
        let updatedPersistance = Persistance(text: text)
        storage.updateEntity(entity: entityToUpdate, withData: updatedPersistance)
        loadEntities()
    }
    
    func deleteEntity(at index: Int) {
        let entityToDelete = storage.fetchEntities()[index]
        storage.deleteEntity(entity: entityToDelete)
        loadEntities()
    }
}
