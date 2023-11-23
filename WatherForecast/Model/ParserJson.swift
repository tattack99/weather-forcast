//
//  ParserJson.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-22.
//

import Foundation

struct LocationData: Codable {
    let lat: String
    let lon: String
}
extension LocationData {
    static var empty: LocationData {
        return LocationData(lat: "0", lon: "0")
    }
}


// Define the structure that matches the JSON response
struct WeatherResponse: Codable {
    var locationName:String?
    let hourly: HourlyData
    let daily: DailyData
}

struct HourlyData: Codable {
    let time: [String]
    let temperature_2m: [Double]
    let precipitation: [Double]
    let rain: [Double]
    let snowfall: [Double]
    let cloud_cover: [Int]
}

struct DailyData: Codable {
    let time: [String]
    let temperature_2m_max: [Double]
    let sunrise: [String]
    let sunset: [String]
    let rain_sum: [Double]
    let snowfall_sum: [Double]
}
extension WeatherResponse {
    static var empty: WeatherResponse {
        return WeatherResponse(
            locationName:"",
            hourly: HourlyData(
                time: [],
                temperature_2m: [],
                precipitation: [],
                rain: [],
                snowfall: [],
                cloud_cover: []
            ),
            daily: DailyData(
                time: [],
                temperature_2m_max: [],
                sunrise: [],
                sunset: [],
                rain_sum: [],
                snowfall_sum: []
            )
        )
    }
}


struct ParserJson {
    
    func parseWeatherDataResponse(json: String) async throws -> WeatherResponse {
        guard let jsonData = json.data(using: .utf8) else {
            throw ParserError.invalidStringEncoding
        }

        var weatherData : WeatherResponse
        
        let decoder = JSONDecoder()
        do {
            weatherData = try decoder.decode(WeatherResponse.self, from: jsonData)
            
        } catch {
            print("ParserJson")
            throw ParserError.couldNotParse
        }
        return weatherData
    }
    
    
    func parseLocationDataResponse(json: String) async throws -> LocationData {
        guard let jsonData = json.data(using: .utf8) else {
            throw ParserError.invalidStringEncoding
        }
        
        var locationData : [LocationData]
        
        let decoder = JSONDecoder()
        do {
            locationData = try decoder.decode([LocationData].self, from: jsonData)
            
        } catch {
            throw ParserError.couldNotParse
        }
        return locationData[0]
    }
}
