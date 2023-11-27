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

func extractHourDataFromWeatherResponse(weatherResponse: WeatherResponse) -> [HourData] {
    var hourData: [HourData] = []
    var hours: [String] = []
    var hourTemp : [Int] = []
    var hourRainProp: [Int] = []
    var hourCloudCover: [Int] = []
    
    for (_ ,time) in weatherResponse.hourly.time.enumerated() {
        hours.append(extractTime(time))
    }
    for (_ ,temp) in weatherResponse.hourly.temperature_2m.enumerated() {
        hourTemp.append(Int(temp))
    }
    for (_ ,cloud) in weatherResponse.hourly.cloud_cover.enumerated() {
        hourCloudCover.append(Int(cloud))
    }
    for (_ ,rain) in weatherResponse.hourly.precipitation.enumerated() {
        hourRainProp.append(Int(rain))
    }
    
    for i in 0..<min(24, hours.count, hourTemp.count) {
        hourData.append(
            HourData(
                time: hours[i],
                cloudCover: hourCloudCover[i],
                rainProp: hourRainProp[i],
                temp: hourTemp[i])
        )
    }
    return hourData
}
func extractDayDataFromWeatherResponse(weatherResponse: WeatherResponse) -> [DayData] {
    var dayData: [DayData] = []
    for i in 0..<min(7, weatherResponse.daily.time.count) {
        let dayName = weatherResponse.daily.time[i]
        let temp = Int(weatherResponse.daily.temperature_2m_max[i])
        let cloudCover = Int(weatherResponse.hourly.cloud_cover[i*24])
        let rainProp = Int(weatherResponse.daily.precipitation_sum[i])
        dayData.append(DayData(dayName: dayName, cloudCover: cloudCover, rainProp: rainProp, temp: temp))
    }
    return dayData
}

func extractCurrentDataFromWeatherResponse(weatherResponse: WeatherResponse) -> CurrentData {
    let currentData = CurrentData(
        date: extractDate(weatherResponse.current.time),
        time: extractTime(weatherResponse.current.time),
        cloudCover: Int16(weatherResponse.current.cloud_cover),
        sunrise: extractTime(weatherResponse.daily.sunrise.first ?? "") ,
        sunset: extractTime(weatherResponse.daily.sunset.first ?? "") ,
        isDay: weatherResponse.current.is_day == 1,
        temp: Int16(weatherResponse.current.temperature_2m)
    )
    return currentData;
}
func mapWeatherResponseToLocation(weatherResponse: WeatherResponse, locationName:String) -> Location {

    let hourData: [HourData] = extractHourDataFromWeatherResponse(weatherResponse: weatherResponse)
    let dayData: [DayData] = extractDayDataFromWeatherResponse(weatherResponse: weatherResponse)
    let currentData = extractCurrentDataFromWeatherResponse(weatherResponse: weatherResponse)
    
    return Location(
        name: locationName,
        currentData: currentData,
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

func isDaytime() -> Bool {
    let currentHour = Calendar.current.component(.hour, from: Date())
    return currentHour >= 7 && currentHour < 16
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
