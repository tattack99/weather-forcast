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
    
    func fetchData() async -> WeatherResponse? {
        var json : String = ""
        var weatherData : WeatherResponse
        
        do{
            json = try await network.fetchData()
            weatherData = try await parser.parseJson(json: json)
            return weatherData
        }
        catch {
            print("Error fetching data")
        }
        return nil
    }
    
}
        
    

