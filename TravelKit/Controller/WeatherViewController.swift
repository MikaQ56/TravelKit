//
//  WeatherViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var weatherService: WeatherService? = nil
    
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
   
    @IBOutlet weak var cityTextField: UITextField!
    
}

// MARK: - Keyboard
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(){
        cityTextField.resignFirstResponder()
        guard let text = cityTextField.text else {
            return
        }
        if text.isEmpty {
            cityTextField.text = "New York"
        } else {
            weatherService!.getWeather(city: text) { (success, weather, state) in
                guard success, let weather = weather else {
                    self.alert(title: "Météo", message: state!.rawValue)
                    return
                }
                self.updateWeatherAbroad(weather: weather)
            }
        }
    }
}

extension WeatherViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService = WeatherService.shared
        let weatherHome = weatherService!.getWeatherHome()
        
        updateWeatherHome(weatherHome: weatherHome)
                
        weatherService!.getWeather(city: "new-york") { (success, weather, state) in
            guard success, let weather = weather else {
                return
            }
            self.updateWeatherAbroad(weather: weather)
        }
    }
    
    func updateWeatherAbroad(weather: Weather) {
        weatherAbroadLabel.text = weather.query.results.channel.item.condition.text
        weatherHomeImage.image = UIImage(named: weather.query.results.channel.item.condition.code)
        sunriseAbroadLabel.text = weather.query.results.channel.astronomy.sunrise
        sunsetAbroadLabel.text = weather.query.results.channel.astronomy.sunset
        windAbroadLabel.text = weather.query.results.channel.wind.speed+" km/h"
        temperatureAbroadLabel.text = weather.query.results.channel.item.condition.temp+"°"
    }
    
    func updateWeatherHome(weatherHome: Weather) {
        weatherHomeLabel.text = weatherHome.query.results.channel.item.condition.text
        weatherHomeImage.image = UIImage(named: weatherHome.query.results.channel.item.condition.code)
        sunriseLabel.text = weatherHome.query.results.channel.astronomy.sunrise
        sunsetLabel.text = weatherHome.query.results.channel.astronomy.sunset
        windLabel.text = weatherHome.query.results.channel.wind.speed+" km/h"
        temperatureLabel.text = weatherHome.query.results.channel.item.condition.temp+"°"
    }
    
    private func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

