//
//  SplashViewModel.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/20.
//

import Foundation

class SplashViewModel: ObservableObject {
    
    @Published var uiEvent: String?
    
    func onLoad() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.uiEvent = "main"
        }
    }
    
}
