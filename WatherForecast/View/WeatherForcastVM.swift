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
            //testThread()
            //fetchData()
        }

        func fetchData(){
            let apiUrl = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m")!

            // Create a URLSession configuration
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)

            // Create a URLSessionDataTask to make the GET request
            let task = session.dataTask(with: apiUrl) { (data, response, error) in
                if let error = error {
                    print("Error: (error.localizedDescription)")
                } else if let data = data {
                    // Parse and process the data (in this example, we'll print it as a string)
                    if let dataString = String(data: data, encoding: .utf8) {
                        print("Data received: (dataString)")
                    }
                }
            }

            // Start the data task
            task.resume()

            // Run the URLSession to initiate the API request
            session.finishTasksAndInvalidate()

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
