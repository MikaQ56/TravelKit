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
        let result = Converter.convertFromEuro()
        resultLabel.text = result
        currencyLabel.text = Converter.getCurrency()
        dateLabel.text = Converter.getDate()
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
}
