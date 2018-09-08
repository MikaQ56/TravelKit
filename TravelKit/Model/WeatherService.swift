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
    
    private var weatherHome: Weather?
    
    private var weatherUrl = URL(string: "http://query.yahooapis.com/v1/public/yql")
    
    private let session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func set(weather: Weather) {
        self.weatherHome = weather
    }
    
    func getWeatherHome() -> Weather {
        return weatherHome!
    }
    
    func getWeather(city: String, callback: @escaping (Bool, Weather?) -> Void) {
        let query = "?q=select%20location,%20wind.speed,%20astronomy,%20item.condition%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text='\(city)')%20and%20u='c'%20&format=json"
        weatherUrl = URL(string: query, relativeTo: weatherUrl)
        task?.cancel()
        task = session.dataTask(with: weatherUrl!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print(error!)
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print(error!)
                    callback(false, nil)
                    return
                }
                guard let weather = try? JSONDecoder().decode(Weather.self, from: data ) else {
                    print("Error: Couldn't decode data")
                    callback(false, nil)
                    return
                }
                callback(true, weather)
            }
        })
        task?.resume()
    }
}
