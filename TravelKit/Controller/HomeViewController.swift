//
//  HomeViewController.swift
//  TravelKit
//
//  Created by Mickael on 06/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // WeatherService & ConverterService initialized with singleton pattern
    private let weatherService = WeatherService.shared
    private let converterService = ConverterService.shared
    
    // Currencies list & home's weather saved in ConverterService & WeatherService. On 'viewDidLoad' event
    override func viewDidLoad() {
        super.viewDidLoad()
        if !converterService.saveCurrencies() {
            alert(title: "Avertissement", message: "Les devises n'ont pas pu être chargées. Seule la devise 'Dollar US' est disponible")
        }
        if !weatherService.saveWeatherHome(city: "lorient") {
            alert(title: "Avertissement", message: "La météo pour la ville de Lorient n'a pas été actualisée")
        }
    }
}

// We create UIViewController's extension in order to reuse the 'alert' method
extension UIViewController {
    
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
