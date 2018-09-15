//
//  ChangeResultViewController.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ChangeResultViewController: UIViewController {
    
    private let converter = Converter.shared
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let result = converter.convertFromEuro()
        resultLabel.text = result
        currencyLabel.text = converter.currencyPicked()
        dateLabel.text = converter.getDate()
    } 
}
