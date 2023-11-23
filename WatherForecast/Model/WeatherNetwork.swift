//
//  WeatherREST.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-22.
//

import Foundation
import Network

struct WeatherNetwork {
    
    func fetchData() async throws -> String {
        
        let latitude = 52.52
        let longitude = 13.41

        guard let apiUrl = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m") else {
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
    
    func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetCheck")

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                completion(true)
            } else {
                print("No connection.")
                completion(false)
            }

            // Stop monitoring after getting the initial status
            monitor.cancel()
        }

        monitor.start(queue: queue)
    }

}
    

