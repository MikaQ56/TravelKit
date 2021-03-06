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
    
    private let converterService = ConverterService.shared
    
    @IBOutlet weak var devisePickerView: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
}

// MARK: - Controller's life cycle
extension ChangeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        if !converterService.saveRates() {
            alert(title: "Avertissement", message: "Les taux de change n'ont pas pu être actualisés")
        }
    }
}

// MARK: - Action
extension ChangeViewController {
    
    // When 'convert' button tapped, go to 'changeResult' view 'updateConverter' method returns true
    @IBAction func convert(_ sender: Any) {
        if updateConverter() {
            performSegue(withIdentifier: "segueToResult", sender: self)
        }
    }
    
    // 'updateConverter' method updates 'amount' & 'symbol' properties after checked values. If ok, returns true
    private func updateConverter() -> Bool {
        let currencyIndex = devisePickerView.selectedRow(inComponent: 0)
        guard let amount = try? amountIsNumber() else {
            alert(title: "Erreur saisie", message: "Vous devez saisir un montant en chiffre !")
            return false
        }
        guard let symbol = try? converterService.getSymbol(index: currencyIndex) else {
            alert(title: "Erreur devise", message: "Le taux de change pour cette devise n'est pas disponible")
            return false
        }
        converterService.amount = amount
        converterService.symbol = symbol
        return true
    }
    
    // Check amount typed is a number
    private func amountIsNumber() throws -> Double {
        let amountString = amountTextField.text
        guard let amount = Double(amountString!) else {
            throw Errors.FormError.isNotNumber
        }
        return amount
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
        return converterService.currencies!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var currencies = converterService.currencies!
        return currencies[row]
    }
}


