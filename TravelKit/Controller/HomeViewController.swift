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
        changeService.getCurrencies { (success, currencies, state) in
            guard success, let currencies = currencies else {
                self.alert(title: "Mise à jour des monnaies", message: state!.rawValue)
                return
            }
            Converter.update(currencies: currencies)
        }
        let weatherService = WeatherService.shared
        weatherService.getWeather(city: "lorient") { (success, weather, state) in
            guard success, let weatherHome = weather else {
                self.alert(title: "Météo", message: state!.rawValue)
                return
            }
            weatherService.set(weather: weatherHome)
        }
    }
    
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
