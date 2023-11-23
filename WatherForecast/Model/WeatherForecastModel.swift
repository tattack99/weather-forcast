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
    
    
    init(){
        self.network = WeatherNetwork()
        self.parser = ParserJson()
    }
    
    func fetchWeatherData(lat:String, lon:String) async -> WeatherResponse? {
        var json : String = ""
        var weatherData : WeatherResponse
        
        do{
            json = try await network.fetchWeatherData(lat: lat, lon: lon)
            weatherData = try await parser.parseWeatherDataResponse(json: json)
            return weatherData
        }
        catch {
            print("Error fetching weather dataaaaa \(error.localizedDescription)")
        }
        return nil
    }
    
    func fetchLocationData(locationName:String) async -> LocationData? {
        var json : String = ""
        var locationData : LocationData
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
    
}
        
    

