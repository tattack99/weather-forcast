//
//  DAMMY_DATA.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-23.
//

import Foundation



func extractDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    return "NO DATE"
}
func extractTime(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    return "NO TIME"
}
func mapWeatherResponseToFavoriteLocation(weatherResponse: WeatherResponse) -> FavoritLocation {
    // HourItemData
    var hourData: [HourItemData] = []
    var hours: [String] = []
    var hourTemp : [Double] = []
    print(weatherResponse)
    
    for (_ ,time) in weatherResponse.hourly.time.enumerated() {
        hours.append(extractTime(time))
    }
    for (_ ,temp) in weatherResponse.hourly.temperature_2m.enumerated() {
        hourTemp.append(temp)
    }
    for i in 0..<min(24, hours.count, hourTemp.count) {
        hourData.append(HourItemData(time: hours[i], image: "sun-cloud", temp: hourTemp[i]))
    }
    
    
    var dayData: [DayItemData] = []
    var days: [String] = []
    var dayTemp : [Double] = []
    for (_ ,time) in weatherResponse.daily.time.enumerated() {
        days.append(time)
    }
    for (_ ,temp) in weatherResponse.daily.temperature_2m_max.enumerated() {
        dayTemp.append(temp)
    }
    for i in 0..<min(7, days.count, dayTemp.count) {
        dayData.append(DayItemData(day: days[i], image: "sun-cloud", temp: dayTemp[i]))
    }
 
    
    let sunrise = weatherResponse.daily.sunrise.first ?? "No Data"
    let sunset = weatherResponse.daily.sunset.first ?? "No Data"

    let firstDay = days.first ?? "No Data"

    return FavoritLocation(
        tempData:TemperatureViewData(
            locationName: weatherResponse.locationName ?? "No Location",
                    date: firstDay,
                    sunrise: extractTime(sunrise),
                    sunset: extractTime(sunset)),
        hourData: hourData,
        dayData: dayData
    )
}

func dayName(from dateString: String) -> String {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd"
 
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "EEE"
        let dayName = dateFormatter.string(from: date)
        return dayName
    } else {
        return "Null"
    }
}




//
//func generateTemperatureData() -> TemperatureViewData {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    let timeFormatter = DateFormatter()
//    timeFormatter.dateFormat = "HH:mm"
//    let swedishCities = ["Stockholm", "Gothenburg", "Malmo", "Uppsala", "Linkoping", "Vasteras", "Orebro", "Umea", "Lund", "Helsingborg"]
//    let date = Date()
//    let currentDate = dateFormatter.string(from: date)
//    let randomIndex = Int.random(in: 0..<swedishCities.count)
//    let locationName = swedishCities[randomIndex]
//    let sunrise = timeFormatter.string(from: Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: date)!)
//    let sunset = timeFormatter.string(from: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: date)!)
//    let dayData = TemperatureViewData(locationName: locationName, date: currentDate, sunrise: sunrise, sunset: sunset)
//    return dayData
//}
//
//func generateHourlyData() -> [HourItemData] {
//    var hourlyData: [HourItemData] = []
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "HH:mm"
//    for hour in 0..<24 {
//        let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
//        let time = dateFormatter.string(from: date)
//        let image = "cloud-sun"
//        let temp = Int.random(in: 5...15)
//
//        let data = HourItemData(time: time, image: image, temp: temp)
//        hourlyData.append(data)
//    }
//    return hourlyData
//}
//
//
//func generateDailyData() -> [DayItemData] {
//    var dailyData: [DayItemData] = []
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "EEEE"
//    let dayNames = ["Mon", "Tues", "Wed", "Thu", "Fri", "Sat", "Sun"]
//    for dayIndex in 0..<7 {
//        let day = dayNames[dayIndex]
//        let image = "cloud-sun"
//        let temp = Int.random(in: 5...15)
//
//        let data = DayItemData(day: day, image: image, temp: temp)
//        dailyData.append(data)
//    }
//    return dailyData
//}
