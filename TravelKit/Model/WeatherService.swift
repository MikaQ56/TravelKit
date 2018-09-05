//
//  WeatherService.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    
    private init(){}
    
    private let weatherUrl = URL(string: "https://weather-ydn-yql.media.yahoo.com/forecastrss")
    
    private let session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
}
