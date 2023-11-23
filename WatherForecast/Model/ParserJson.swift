//
//  ParserJson.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-22.
//

import Foundation

// Define the structure that matches the JSON response
struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let hourly: HourlyData
}

struct HourlyData: Codable {
    let time: [String]
    let temperature2m: [Double]

    private enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
    }
}

extension WeatherResponse {
    static var empty: WeatherResponse {
        return WeatherResponse(latitude: 0.0, longitude: 0.0, hourly: HourlyData.empty)
    }
}

extension HourlyData {
    static var empty: HourlyData {
        return HourlyData(time: [], temperature2m: [])
    }
}

struct ParserJson {
    
    func parseJson(json: String) async throws -> WeatherResponse {
        guard let jsonData = json.data(using: .utf8) else {
            throw ParserError.invalidStringEncoding
        }
        
        var weatherData : WeatherResponse
        
        let decoder = JSONDecoder()
        do {
            weatherData = try decoder.decode(WeatherResponse.self, from: jsonData)
            
            // Print WeatherResponse details
            print("WeatherResponse:")
            print("Latitude: \(weatherData.latitude)")
            print("Longitude: \(weatherData.longitude)")

            // Print HourlyData details
            print("\nHourlyData:")
            for (index, time) in weatherData.hourly.time.enumerated() {
                let temperature = weatherData.hourly.temperature2m[index]
                print("Time: \(time), Temperature: \(temperature)°C")
            }
            
        } catch {
            throw ParserError.couldNotParse
        }
        return weatherData
    }
}
