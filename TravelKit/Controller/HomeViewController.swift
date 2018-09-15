//
//  HomeViewController.swift
//  TravelKit
//
//  Created by Mickael on 06/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let weatherService = WeatherService.shared
    private let converterService = ConverterService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        if !converterService.saveCurrencies() {alert(title: "Avertissement", message: "Les devises n'ont pas pu être chargées. Seule la devise 'Dollar US' est disponible")}
        weatherService.saveWeatherHome(city: "lorient")
    }
    
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
