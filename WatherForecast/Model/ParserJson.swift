//
//  ParserJson.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-22.
//

import Foundation

struct LocationDataJson: Codable {
    let lat: String
    let lon: String
}

struct WeatherResponse: Codable {
    let current: CurrentDataJson
    let hourly: HourlyDataJson
    let daily: DailyDataJson
}

struct CurrentDataJson: Codable {
    let time: String
    let cloud_cover: Int
    let precipitation: Double
    let temperature_2m: Double
    let is_day:Int
}

struct HourlyDataJson: Codable {
    let time: [String]
    let temperature_2m: [Double]
    let precipitation: [Double]
    let cloud_cover: [Int]
}

struct DailyDataJson: Codable {
    let time: [String]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let sunrise: [String]
    let sunset: [String]
    let precipitation_sum: [Double]

}
extension WeatherResponse {
    static var empty: WeatherResponse {
        return WeatherResponse(
            current: CurrentDataJson(
                time: "",
                cloud_cover: 0,
                precipitation: 0.0,
                temperature_2m:0,
                is_day: 1
            ),
            hourly: HourlyDataJson(
                time: [],
                temperature_2m: [],
                precipitation: [],
                cloud_cover: []
            ),
            daily: DailyDataJson(
                time: [],
                temperature_2m_max: [],
                temperature_2m_min: [],
                sunrise: [],
                sunset: [],
                precipitation_sum: []
            )
        )
    }
}
extension LocationDataJson {
    static var empty: LocationDataJson {
        return LocationDataJson(lat: "0", lon: "0")
    }
}

extension DateFormatter {
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Use the format that matches your `time` string
        return formatter
    }()

    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM" // Use the format that matches your `day` string
        return formatter
    }()
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
    
    
    func parseLocationDataResponse(json: String) async throws -> LocationDataJson {
        guard let jsonData = json.data(using: .utf8) else {
            throw ParserError.invalidStringEncoding
        }
        
        var locationData : [LocationDataJson]
        
        let decoder = JSONDecoder()
        do {
            locationData = try decoder.decode([LocationDataJson].self, from: jsonData)
            
        } catch {
            throw ParserError.couldNotParse
        }
        return locationData[0]
    }
}
