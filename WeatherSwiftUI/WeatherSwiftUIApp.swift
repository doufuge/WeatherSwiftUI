//
//  WeatherSwiftUIApp.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/19.
//

import SwiftUI

@main
struct WeatherSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

extension Int {
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}
