//
//  ChangeViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

// MARK: - Controller's life cycle
extension ChangeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRates()
    }
}

// MARK: - Outlets & properties
class ChangeViewController: UIViewController {

    private let converter = Converter()
    
    private let changeService = ChangeService.shared
    
    @IBOutlet weak var devisePickerView: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
   
    @IBAction func convert(_ sender: Any) {
        if !Converter.set(amount: amountTextField.text) { amountAlert()}
        let currencyIndex = devisePickerView.selectedRow(inComponent: 0)
        Converter.setCurrencySymbol(index: currencyIndex)
        Converter.convertFromEuro()
    }
}

// MARK: - Alerts
extension ChangeViewController {
    
    private func amountAlert() {
        let alert = UIAlertController(title: "Erreur", message: "Vous n'avez pas saisi un montant valide", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func requestAlert() {
        let alertVC = UIAlertController(title: "Erreur", message: "Les taux de change ne sont pas actualisés", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}



// MARK: - Keyboard
extension ChangeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let amount = textField.text
        let result = Converter.set(amount: amount)
        print(result)
        return true
    }
    
    @IBAction func dismissKeyboard() {
        amountTextField.resignFirstResponder()
    }
}

// MARK: - Picker view
extension ChangeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Converter.getCurrencies().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var currenciesValues = Array(Converter.getCurrencies().values)
        return currenciesValues[row]
    }
}

// MARK: - Utilities
extension ChangeViewController {
    
    private func updateRates() {
        changeService.getRates { (success, rates) in
            guard success, let rates = rates else {
                self.requestAlert()
                return
            }
            Converter.set(rates: rates)
        }
    }
}
