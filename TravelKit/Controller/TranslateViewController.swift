//
//  TranslateViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

// MARK : - Properties & Outlets
class TranslateViewController: UIViewController {
    
    private let translatorService = TranslatorService.shared
    
    @IBOutlet weak var textTranslated: UILabel!
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var languageButton: UIButton!
}

// MARK: - Controller's life cycle
extension TranslateViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageButton.setImage(UIImage(named: "en"), for: UIControlState.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let target = translatorService.target
        languageButton.setImage(UIImage(named: target), for: UIControlState.normal)
    }
}

// MARK: - Actions
extension TranslateViewController {
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textToTranslate.resignFirstResponder()
    }
    
    @IBAction func translate(_ sender: Any) {
        let text = textToTranslate.text!
        translatorService.translate(text: text) { (success, translator, state) in
            guard success, let translator = translator else {
                print(state.rawValue)
                self.alert(title: "Erreur traduction", message: "La traduction n'a pas pu être effectuée")
                return
            }
            self.textTranslated.text = translator.data.translations[0].translatedText
        }
    }
}

// MARK: - Alert
extension TranslateViewController {
    
    private func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


