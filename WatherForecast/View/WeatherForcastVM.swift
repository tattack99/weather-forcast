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
    @Published var locations: [FavoritLocation] = []
    @Published var hasInternet: Bool = false


    private var model : WeatherForecastModel

    init(){
        self.model = WeatherForecastModel()
        loadEntities()
    }
    
    func checkInternetConnection() {
        Task{
            let isConnected = await model.checkInternetConnection()
            await MainActor.run {
                self.hasInternet = isConnected
            }

        }
    }
    
    


    func fetchLocationData(locationName:String) async -> LocationData {
        await model.fetchLocationData(locationName: locationName) ?? LocationData.empty
    }
    
    func fetchWeatherData(lat: String, lon: String, loactionName:String) async {
        var data = await model.fetchWeatherData(lat: lat, lon: lon)
        data?.locationName = loactionName
        
        if let safe = data {
            // model.dropDatabase()
            
            let storeData = mapWeatherResponseToFavoriteLocation(weatherResponse: safe)
            await model.createEntity(withData: storeData)
            loadEntities()
        }
    }
    
    private func loadEntities(){
        // Run loadEntities in the background
        Task {
            let loadedLocations = await model.loadEntities()

            // Switch back to the main thread to update the UI
            await MainActor.run {
                self.locations = loadedLocations
            }
        }
    }
    
    
    
    
    

}
