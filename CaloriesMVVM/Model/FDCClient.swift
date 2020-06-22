//
//  FDCClient.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 27/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation
import Combine

protocol FDCActions {
    static func getFoodDetail(id: Int) -> AnyPublisher<FDCFoodDetail, APIError>
    static func searchFoods(query: String) -> AnyPublisher<FDCSearchFoodResponce, APIError>
}

struct FDCClient: FDCActions {
    
    
    public static func getFoodDetail(id: Int) -> AnyPublisher<FDCFoodDetail, APIError> {
        
        let baseURL = URL(string: "https://api.nal.usda.gov/fdc/v1/food/\(id)")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components!.queryItems = [
            URLQueryItem(name: "api_key", value: "GiTBTksk9zIY55qv0bTmUcypPYtMPvEQuTlX9ADi"),
            //URLQueryItem(name: "nutrients", value: "203")
        ]
        
        let sessionConfig = URLSessionConfiguration.default
        return URLSession(configuration: sessionConfig).dataTaskPublisher(for: components!.url!)
            .map { data, _ in data }
            .decode(type: FDCFoodDetail.self, decoder: decoder)
            .mapError{ APIError.parseError(reason: "\($0)") }
            .eraseToAnyPublisher()
    
    }
    
    
    public static func searchFoods(query: String) -> AnyPublisher<FDCSearchFoodResponce, APIError> {
        
        let baseURL = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components!.queryItems = [
            URLQueryItem(name: "api_key", value: "GiTBTksk9zIY55qv0bTmUcypPYtMPvEQuTlX9ADi"),
            URLQueryItem(name: "dataType", value: "SR Legacy"), //"Survey (FNDDS)"
            URLQueryItem(name: "query", value: query),
            
        ]
    
        return URLSession.shared.dataTaskPublisher(for: components!.url!)
        .map { $0.data }
        .decode(type: FDCSearchFoodResponce.self, decoder: decoder)
        .mapError{ APIError.parseError(reason: "\($0)") }
        .eraseToAnyPublisher()
    }
    
    
    
    private static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
}


public enum APIError: Error, Equatable {

    case unknown
    case message(reason: String)
    case parseError(reason: String)
    
    static func processResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        if (httpResponse.statusCode == 404) {
            throw APIError.message(reason: "Resource not found");
        }
        return data
    }
}
