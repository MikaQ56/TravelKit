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
        let changeService = ChangeService.shared
        changeService.getCurrencies { (success, currencies) in
            guard success, let currencies = currencies else {
                return
            }
            Converter.update(currencies: currencies)
        }
        let weatherService = WeatherService.shared
        weatherService.getWeather(city: "lorient") { (success, weather) in
            guard success, let weatherHome = weather else {
                self.weathertAlert()
                return
            }
            weatherService.set(weather: weatherHome)
        }
    }
    
    private func weathertAlert() {
        let alertVC = UIAlertController(title: "Attention", message: "La météo de votre lieu de résidence n'a pas été actualisée", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

    private func currenciesAlert() {
        let alertVC = UIAlertController(title: "Erreur", message: "La liste des monnaies n'a pas été actualisée", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
