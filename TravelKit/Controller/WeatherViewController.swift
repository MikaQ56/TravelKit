//
//  WeatherViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherService = WeatherService.shared
        let weatherHome = weatherService.getWeatherHome()
        self.weatherHomeLabel.text = weatherHome.query.results.channel.item.condition.text
        self.sunriseLabel.text = weatherHome.query.results.channel.astronomy.sunrise
        self.sunsetLabel.text = weatherHome.query.results.channel.astronomy.sunset
        self.windLabel.text = weatherHome.query.results.channel.wind.speed+" km/h"
        self.temperatureLabel.text = weatherHome.query.results.channel.item.condition.temp+"°"
                
        weatherService.getWeather(city: "new-york") { (success, weather) in
            guard success, let weather = weather else {
                return
            }
            self.weatherAbroadLabel.text = weather.query.results.channel.item.condition.text
            self.sunriseAbroadLabel.text = weather.query.results.channel.astronomy.sunrise
            self.sunsetAbroadLabel.text = weather.query.results.channel.astronomy.sunset
            self.windAbroadLabel.text = weather.query.results.channel.wind.speed+" km/h"
            self.temperatureAbroadLabel.text = weather.query.results.channel.item.condition.temp+"°"
        }
    }
    
    @IBOutlet weak var weatherAbroadLabel: UILabel!
    @IBOutlet weak var weatherAbroadImage: UIImageView!
    @IBOutlet weak var weatherHomeLabel: UILabel!
    @IBOutlet weak var weatherHomeImage: UIImageView!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var sunriseAbroadLabel: UILabel!
    @IBOutlet weak var windAbroadLabel: UILabel!
    @IBOutlet weak var temperatureAbroadLabel: UILabel!
    @IBOutlet weak var sunsetAbroadLabel: UILabel!
}
