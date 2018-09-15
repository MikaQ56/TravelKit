//
//  WeatherViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

// MARK: Properties & Outlets
class WeatherViewController: UIViewController {
    
    private var weatherService = WeatherService.shared
    private var weatherHome: Weather?
    private var weatherAbroad: Weather?
    
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

// MARK: - Life cycle's controller
extension WeatherViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherHome = weatherService.weatherHome
        updateWeatherHome(weatherHome: weatherHome!)
        weatherService.getWeather(city: "new-york") { (success, weather, state) in
            guard success, let weather = weather else {
                print(state!.rawValue)
                return
            }
            self.weatherAbroad = weather
            self.updateWeatherAbroad(weather: weather)
        }
    }
}

// MARK: - Keyboard
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        checkTextField()
        return true
    }
    
    @IBAction func dismissKeyboard(){
        cityTextField.resignFirstResponder()
        checkTextField()
    }
}

// MARK: - Utilities
extension WeatherViewController {
    
    private func checkTextField() {
        guard let city = cityTextField.text else {
            return
        }
        if city.isEmpty {
            alert(title: "Erreur saisie", message: "Vous devez saisir le nom d'une ville")
            cityTextField.text = "New York"
        }
        weatherService.getWeather(city: city) { (success, weather, state) in
            guard success, let weather = weather else {
                print(state!.rawValue)
                self.cityTextField.text = "New York"
                self.updateWeatherAbroad(weather: self.weatherAbroad!)
                self.alert(title: "Erreur", message: "Nous ne trouvons pas de résultat pour la ville \(city)")
                return
            }
            self.updateWeatherAbroad(weather: weather)
        }
    }
    
    
    private func updateWeatherAbroad(weather: Weather) {
        weatherAbroadLabel.text = weather.query.results.channel.item.condition.text
        weatherAbroadImage.image = UIImage(named: weather.query.results.channel.item.condition.code)
        sunriseAbroadLabel.text = weather.query.results.channel.astronomy.sunrise
        sunsetAbroadLabel.text = weather.query.results.channel.astronomy.sunset
        windAbroadLabel.text = weather.query.results.channel.wind.speed+" km/h"
        temperatureAbroadLabel.text = weather.query.results.channel.item.condition.temp+"°"
    }
    
    private func updateWeatherHome(weatherHome: Weather) {
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

