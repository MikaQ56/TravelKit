//
//  HomeViewController.swift
//  TravelKit
//
//  Created by Mickael on 06/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Converter.setCurrencies()
        let weatherService = WeatherService.shared
        weatherService.getWeather(city: "lorient") { (success, weather) in
            guard success, let weatherHome = weather else {
                return
            }
            weatherService.set(weather: weatherHome)
        }
    }

}
