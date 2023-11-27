//
//  WeatherREST.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-22.
//

import Foundation
import Network



struct WeatherNetwork {
    
    func fetchCoordinatesByLocationName(locationName:String) async throws -> String {
        guard let apiUrl = URL(string: "https://geocode.maps.co/search?q=\(locationName.lowercased())") else {
            throw NetworkError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: apiUrl)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        if let dataString = String(data: data, encoding: .utf8) {
            return dataString
        }
        else {
            throw ParserError.invalidStringEncoding
        }
    }
    
    func fetchWeatherData(lat:String,lon:String) async throws -> String {
        
        guard let apiUrl = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current=temperature_2m,is_day,cloud_cover&hourly=temperature_2m,precipitation,rain,snowfall,cloud_cover&daily=temperature_2m_max,sunrise,sunset,rain_sum,snowfall_sum") else {
            throw NetworkError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: apiUrl)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        if let dataString = String(data: data, encoding: .utf8) {
            return dataString
        }
        else {
            throw ParserError.invalidStringEncoding
        }
    }
    

    func checkInternetConnection() async -> Bool {
        await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                continuation.resume(returning: path.status == .satisfied)
                monitor.cancel()
            }
            let queue = DispatchQueue(label: "InternetConnectionMonitor")
            monitor.start(queue: queue)
        }
    }
}
    

