//
//  WeatherForcastVM.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-21.
//

import Foundation
import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear() // Empty onAppear to ensure the modifier is active
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

class WeatherForcastVM : ObservableObject {
    @Published var locations: [Location] = []
    @Published var hasInternet: Bool = false
    @Published var deviceOrientation: UIDeviceOrientation = .portrait
    @State var isLoaded: Bool = false


    private var model : WeatherForecastModel

    init() {
        self.model = WeatherForecastModel()
    }
    
    func handleEntities() {
        Task {
            let isConnected = await model.checkInternetConnection()
            if isConnected {
                print("isConnected")
                let entitiesLoaded = await loadEntities()

                if entitiesLoaded {
                    let locationNames = locations.map { $0.name }
                    print(locationNames)
                    if locationNames.count > 0 {
                        dropStorage()
                        for name in locationNames {
                            await fetchWeatherData(locationName: name)
                        }
                    }
                }
            } else {
                
                let success = await loadEntities()
                print("Not connected \(success)")
            }
        }
    }
    
    func updateDeviceOrientation(orientation: UIDeviceOrientation) {
        deviceOrientation = orientation
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
        
        
        let locationData = await model.fetchLocationData(locationName: locationName) ?? LocationDataJson.empty
        let data = await model.fetchWeatherData(lat: locationData.lat, lon: locationData.lon, locationName: locationName)
        
        if let safe = data {
            // model.dropDatabase()
            
            let storeData = mapWeatherResponseToLocation(weatherResponse: safe, locationName: locationName)
            await model.createEntity(withData: storeData)
            let success = await loadEntities()
            print("\(success)")
        }
    }
    
    private func loadEntities() async -> Bool {
        let unsortedLocations = await model.loadEntities()
        await MainActor.run {
            self.locations = sortFavoriteLocations(unsortedLocations)
        }
        return !unsortedLocations.isEmpty
    }
    
    private func dropStorage(){
        model.dropDatabase()
    }

    
    private func sortDayData(dayData: [DayData]) -> [DayData] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dayData.sorted {
            guard let date1 = dateFormatter.date(from: $0.dayName),
                  let date2 = dateFormatter.date(from: $1.dayName) else { return false }
            return date1 < date2
        }
    }

    private func sortFavoriteLocations(_ locations: [Location]) -> [Location] {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH:mm"

        return locations.map { location in
            let sortedHourData = location.hourData.sorted {
                guard let time1 = hourFormatter.date(from: $0.time),
                      let time2 = hourFormatter.date(from: $1.time) else { return false }
                return time1 < time2
            }
            
            let sortedDayData = sortDayData(dayData: location.dayData)

            return Location(name: location.name, currentData: location.currentData, hourData: sortedHourData, dayData: sortedDayData)
        }
    }

    
   
    
}
