//
//  ChangeResultViewController.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ChangeResultViewController: UIViewController {
    
    override func viewDidLoad() {
        let result = Int(Converter.getResult().rounded())
        resultLabel.text = String(result)
        var currencies = Converter.getCurrencies()
        let symbol = Converter.getCurrencySymbol()
        currencyLabel.text = currencies[symbol]
    }
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
}
