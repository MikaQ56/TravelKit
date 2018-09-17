//
//  WeatherService.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class WeatherService {
    
    // Implement singleton pattern
    static let shared = WeatherService()
    private init(){}
    
    // init method for tests
    init(session: URLSession) {
        self.session = session
    }
    
    // Properties for request
    var weatherHome: Weather?
    private var weatherUrl = URL(string: "http://query.yahooapis.com/v1/public/yql")
    private var session = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    // Get weather data for city
    func getWeather(city: String, callback: @escaping (Bool, Weather?, Request?) -> Void) {
        let originalString = "?q=select location, wind.speed, astronomy, item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text='\(city)') and u='c' &format=json"
        let query = originalString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        weatherUrl = URL(string: query!, relativeTo: weatherUrl)
        task?.cancel()
        task = session.dataTask(with: weatherUrl!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil, Request.errorRequest)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil, Request.errorServer)
                    return
                }
                guard let weather = try? JSONDecoder().decode(Weather.self, from: data ) else {
                    callback(false, nil, Request.errorData)
                    return
                }
                callback(true, weather, Request.succeed)
            }
        })
        task?.resume()
    }
    
    // Save home weather in the weather service
    func saveWeatherHome(city: String) -> Bool {
        getWeather(city: city) { (success, weather, state) in
            guard success, let weatherHome = weather else {
                print(state!.rawValue)
                return
            }
            self.weatherHome = weatherHome
        }
        return true
    }
}
