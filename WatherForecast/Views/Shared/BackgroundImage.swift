//
//  BackgroundImage.swift
//  WatherForecast
//
//  Created by Hamada Aljarrah on 2023-11-22.
//

import SwiftUI
//import CoreMotion



struct BackgroundImage: View {
    let imageName: String
    let overlayOpacity: Double
//    @StateObject var motionManager = MotionManager()
//    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            
//            .offset(x: self.motionManager.xTilt * 10, y: self.motionManager.yTilt * 10)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Rectangle()
                    .opacity(overlayOpacity)
                    .foregroundColor(.black)
                    
                    .edgesIgnoringSafeArea(.all)
            )
    }
}


//
//
//class MotionManager: ObservableObject {
//    private var motionManager = CMMotionManager()
//    @Published var xTilt: CGFloat = 0
//    @Published var yTilt: CGFloat = 0
//
//    init() {
//        startMotionUpdates()
//    }
//
//    private func startMotionUpdates() {
//        if motionManager.isDeviceMotionAvailable {
//            motionManager.deviceMotionUpdateInterval = 0.1
//            motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
//                guard error == nil else {
//                    print("Error: \(error!)")
//                    return
//                }
//
//                if let data = data {
//                    // Process the motion data for your needs
//                    self.xTilt = CGFloat(data.attitude.roll)
//                    self.yTilt = CGFloat(data.attitude.pitch)
//                }
//            }
//        }
//    }
//}
