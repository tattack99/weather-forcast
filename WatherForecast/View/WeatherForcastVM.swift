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
    @Published var entities : [Persistance]

//    @Published var locations = [ // DAMMY DATA
//        FavoritLocation(tempData: generateTemperatureData(), hourData: generateHourlyData(), dayData: generateDailyData()),
//        FavoritLocation(tempData: generateTemperatureData(), hourData: generateHourlyData(), dayData: generateDailyData()),
//        FavoritLocation(tempData: generateTemperatureData(), hourData: generateHourlyData(), dayData: generateDailyData()),
//    ]
    @Published var locations: [FavoritLocation] = []


    private var storage : PersistenceController
    private var model : WeatherForecastModel

    init(){
        self.entities = []
        self.storage = PersistenceController()
        self.model = WeatherForecastModel()
        loadEntities()

    }

    private func loadEntities() {
        let fetchedEntities = storage.fetchEntities().map { Persistance(text: $0.text ?? "") }
        DispatchQueue.main.async {
            self.entities = fetchedEntities
        }
    }

    func fetchLocationData(locationName:String) async -> LocationData {
        await model.fetchLocationData(locationName: locationName) ?? LocationData.empty
    }
    
    // get data from REST api
    func fetchWeatherData(lat: String, lon: String, loactionName:String) async {
        var data = await model.fetchWeatherData(lat: lat, lon: lon)
        data?.locationName = loactionName
        
        if let safe = data {
            
            DispatchQueue.main.async {
                self.locations.append(mapWeatherResponseToFavoriteLocation(weatherResponse: safe))
            }
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
