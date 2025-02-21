//
//  NetworkManager.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/20.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private var session: Session
    
    init() {
        session = Session()
    }
    
    func get<T: Decodable>(url: String, parameters: [String: Any]? = nil, completion: @escaping(Result<T, Error>) -> Void) {
        session.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func post<T: Decodable>(url: String, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        session.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
