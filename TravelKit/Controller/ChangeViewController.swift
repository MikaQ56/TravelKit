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
        if !Converter.save(amount: amountTextField.text) { alert(title: "Convertisseur", message: "Vous devez saisir un montant en chiffre !")}
        let currencyIndex = devisePickerView.selectedRow(inComponent: 0)
        Converter.setCurrencySymbol(index: currencyIndex)
    }
}

// MARK: - Alert
extension ChangeViewController {
    
    private func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}

// MARK: - Keyboard
extension ChangeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        changeService.getRates { (success, rates, state) in
            guard success, let rates = rates else {
                self.alert(title: "Mise à jour des taux", message: state!.rawValue)
                return
            }
            print(state!.rawValue)
            Converter.save(rates: rates)
        }
    }
}
