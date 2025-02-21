//
//  MainViewModel.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/21.
//

import Foundation

class MainViewModel: ObservableObject {
    
    private let networkService = NetworkService()
    @Published var showTable: Bool = true
    @Published var data: [WeatherItem] = []
    @Published var loading: Bool = true
    
    func fetchWeather() {
        loading = true
        networkService.fetchWeather(latitude: 52.52, longitude: 13.41) { result in
            switch result {
            case .success(let json):
//                let tempUnit = json.hourly_units.temperature_2m
                if json.hourly.time.count == json.hourly.temperature_2m.count {
                    self.data = json.hourly.time.enumerated().map({ (index, item) in
                        return WeatherItem(hour: item, temp: json.hourly.temperature_2m[index])
                    })
                }
                NSLog("==============  success")
                NSLog(String(describing: self.data))
                self.loading = false
            case .failure(let error):
                NSLog("==============  error")
                NSLog(error.localizedDescription)
                self.loading = false
            }
        }
    }
    
    func toggleViewMode() {
        showTable = !showTable
    }
    
}
