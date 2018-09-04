//
//  ChangeViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    private let converter = Converter()
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var amount: UITextField!
}

// MARK: - Keyboard
extension ChangeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        ChangeService.shared.getChangeRate { (success, changeRate) in
            guard success, let changeRate = changeRate else {
                return
            }
            let result = self.converter.convert(changeRate: changeRate, amount: self.amount.text)
            self.result.text = String(result)
        }
        return true
    }

}
