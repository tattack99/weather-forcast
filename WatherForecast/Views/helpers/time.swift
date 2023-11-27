//
//  time.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-27.
//

import CoreLocation
import Solar

func isDaytime() -> Bool? {
    let locationManager = CLLocationManager()
    locationManager.requestWhenInUseAuthorization()

    guard let currentLocation = locationManager.location else {
        return nil  // Location data not available
    }

    let solar = Solar(for: Date(), coordinate: currentLocation.coordinate)
    return solar?.isDaytime
}

