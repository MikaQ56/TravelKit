//
//  ChangeResultViewController.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ChangeResultViewController: UIViewController {
    
    // ConverterService service initialized
    private let converterService = ConverterService.shared
    
    // 'date, currency & result labels linked with controller
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    // Labels updated on 'viewWillAppear' event
    override func viewWillAppear(_ animated: Bool) {
        let result = converterService.convertFromEuro()
        resultLabel.text = result
        currencyLabel.text = converterService.currencyPicked()
        dateLabel.text = converterService.getDate()
    } 
}
