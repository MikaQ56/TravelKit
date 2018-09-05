//
//  ChangeViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

// MARK: - Outlets & properties
class ChangeViewController: UIViewController {

    private let converter = Converter()
    
    private let changeService = ChangeService.shared
    
    @IBAction func convert(_ sender: Any) {
    }
    
}

// MARK: - Controller's life cycle
extension ChangeViewController {
    
    override func viewDidLoad() {
        changeService.getCurrencies { (success, currencies) in
            guard success, let currencies = currencies else {
                return
            }
            self.converter.set(currencies: currencies)
            print(self.converter.getCurrencies())
        }
    }
    
}

// MARK: - Keyboard
extension ChangeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateRates()
        let amount = textField.text
        converter.set(amount: amount)
        return true
    }
}

// MARK: - Picker view

extension ChangeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return converter.getCurrencies().count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return converter.getCurrencies()[row]
    }
}

// MARK: - Utilities
extension ChangeViewController {
    
    private func updateRates() {
        changeService.getRates { (success, rates) in
            guard success, let rates = rates else {
                return
            }
            self.converter.set(rates: rates)
        }
    }
}
