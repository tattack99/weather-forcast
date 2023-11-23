//
//  DAMMY_DATA.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-23.
//

import Foundation

func generateTemperatureData() -> TemperatureViewData {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    let swedishCities = ["Stockholm", "Gothenburg", "Malmo", "Uppsala", "Linkoping", "Vasteras", "Orebro", "Umea", "Lund", "Helsingborg"]
    let date = Date()
    let currentDate = dateFormatter.string(from: date)
    let randomIndex = Int.random(in: 0..<swedishCities.count)
    let locationName = swedishCities[randomIndex]
    let sunrise = timeFormatter.string(from: Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: date)!)
    let sunset = timeFormatter.string(from: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: date)!)
    let dayData = TemperatureViewData(locationName: locationName, currentDate: currentDate, sunrise: sunrise, sunset: sunset)
    return dayData
}

func generateHourlyData() -> [HourItemData] {
    var hourlyData: [HourItemData] = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    for hour in 0..<24 {
        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
        let time = dateFormatter.string(from: date)
        let image = "cloud-sun"
        let temp = Int.random(in: 5...15)
        
        let data = HourItemData(time: time, image: image, temp: temp)
        hourlyData.append(data)
    }
    return hourlyData
}


func generateDailyData() -> [DayItemData] {
    var dailyData: [DayItemData] = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayNames = ["Mon", "Tues", "Wed", "Thu", "Fri", "Sat", "Sun"]
    for dayIndex in 0..<7 {
        let day = dayNames[dayIndex]
        let image = "cloud-sun"
        let temp = Int.random(in: 5...15)
        
        let data = DayItemData(day: day, image: image, temp: temp)
        dailyData.append(data)
    }
    return dailyData
}
