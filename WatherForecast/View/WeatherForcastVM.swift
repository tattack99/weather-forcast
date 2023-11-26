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

    func fetchWeatherData(locationName:String) async {
        checkInternetConnection()
        
        if !self.hasInternet {
            loadEntities()
            return
        }
        
        let locationData = await model.fetchLocationData(locationName: locationName) ?? LocationData.empty
        var data = await model.fetchWeatherData(lat: locationData.lat, lon: locationData.lon)
        data?.locationName = locationName
        
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
            
            let unsortedLocations = await model.loadEntities()
                    
            // Sort the locations using the new function
            let sortedLocations = sortFavoritLocations(unsortedLocations)
            
            

            // Switch back to the main thread to update the UI
            await MainActor.run {
                self.locations = sortedLocations
            }
        }
    }
    

    
    func sortDayData(dayData: [DayItemData]) -> [DayItemData] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dayData.sorted {
            guard let date1 = dateFormatter.date(from: $0.day),
                  let date2 = dateFormatter.date(from: $1.day) else { return false }
            return date1 < date2
        }
    }
    
    private func sortFavoritLocations(_ locations: [FavoritLocation]) -> [FavoritLocation] {
        return locations.map { location in
            let sortedHourData = location.hourData.sorted {
                guard let time1 = DateFormatter.hourFormatter.date(from: $0.time),
                      let time2 = DateFormatter.hourFormatter.date(from: $1.time) else { return false }
                return time1 < time2
            }
            
            // inspectDayData(dayData: location.dayData)
            let sortedDayData = sortDayData(dayData: location.dayData)

            return FavoritLocation(tempData: location.tempData, hourData: sortedHourData, dayData: sortedDayData)
        }
    }
    
    private func inspectDayData(dayData: [DayItemData]) {
        for dayItem in dayData {
            print("Day: \(dayItem.day), Temp: \(dayItem.temp), Image: \(dayItem.image)")
        }
    }
    
}
