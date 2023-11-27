//
//  WeatherForecastModel.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-22.
//

import Foundation

struct WeatherForecastModel{
    
    private var network : WeatherNetwork
    private var parser : ParserJson
    private var storage : PersistenceController
    
    
    init(){
        self.network = WeatherNetwork()
        self.parser = ParserJson()
        self.storage = PersistenceController()
    }
    
    func fetchWeatherData(lat:String, lon:String, locationName:String) async -> WeatherResponse? {
        var json : String = ""
        var weatherData : WeatherResponse
        
        do{
            json = try await network.fetchWeatherData(lat: lat, lon: lon)
            weatherData = try await parser.parseWeatherDataResponse(json: json)
            return weatherData
        }
        catch {
            print("Error fetching weather data \(error.localizedDescription)")
        }
        return nil
    }
    
    func fetchLocationData(locationName:String) async -> LocationDataJson? {
        var json : String = ""
        var locationData : LocationDataJson
        print(locationName)
        do{
            json = try await network.fetchCoordinatesByLocationName(locationName: locationName)
            locationData = try await parser.parseLocationDataResponse(json: json)
            return locationData
        }
        catch {
            print("Error fetching location data: \(error.localizedDescription)")
        }
        return nil
    }
    
    func createEntity(withData: Location) async {
        await storage.createEntity(withData: withData)
        //print("count:\(fetchData.count), locationName: \(fetchData.first?.tempData.locationName) dayData.Count:\(fetchData.first?.dayData.count), hourData.Count:\(fetchData.first?.hourData.count)")
    }
    
    func loadEntities() async -> [Location] {
        let fetchData = await storage.loadEntities()
        //print("count:\(fetchData.count), locationName: \(fetchData.first?.tempData.locationName) dayData.Count:\(fetchData.first?.dayData.count), hourData.Count:\(fetchData.first?.hourData.count)")
        return fetchData
    }
    
    func dropDatabase() {
        storage.clearCoreDataStore()
    }
    
    func checkInternetConnection() async -> Bool {
        return await network.checkInternetConnection()
    }

}
    

        
    

