//
//  NetworkService.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/21.
//

import Foundation
import Moya

class NetworkService {
    
    private let provider = MoyaProvider<WeatherApi>()
    
    func fetchWeather(latitude: Double, longitude: Double, hourly: String = "temperature_2m", completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        provider.request(.fetchWeather(latitude: latitude, longitude: longitude, hourly: hourly)) { result in
            switch result {
            case .success(let response):
                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: response.data)
                    completion(.success(weatherResponse))
//                    let json = try JSONSerialization.jsonObject(with: response.data, options: [])
//                    if let jsonDict = json as? [String: Any] {
//                        completion(.success(jsonDict))  // 返回解析后的 JSON 字典
//                    } else {
//                        completion(.failure(NSError(domain: "Invalid JSON format", code: 0, userInfo: nil)))
//                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
