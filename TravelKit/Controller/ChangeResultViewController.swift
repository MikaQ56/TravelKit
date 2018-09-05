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
        resultLabel.text = String()
        let result = Converter.euro(to: "USD")
        resultLabel.text = String(result)
    }
    
    @IBOutlet weak var resultLabel: UILabel!
}
