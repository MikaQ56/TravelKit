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
    
    // Default language for 'languageButton' is english
    override func viewDidLoad() {
        super.viewDidLoad()
        languageButton.setImage(UIImage(named: "en"), for: UIControlState.normal)
    }
    
    // Language is updated & image's button too
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
    
    // When 'translate' button is tapped then we use 'translate' method from Translator Service to get text translated
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


