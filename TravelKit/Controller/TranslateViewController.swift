//
//  TranslateViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    private let translatorService = TranslatorService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageButton.setImage(UIImage(named: "en"), for: UIControlState.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let target = translatorService.getTarget()
        languageButton.setImage(UIImage(named: target), for: UIControlState.normal)
    }

    @IBOutlet weak var textTranslated: UILabel!
    @IBOutlet weak var textToTranslate: UITextView!
    @IBOutlet weak var languageButton: UIButton!
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textToTranslate.resignFirstResponder()
    }
    
    @IBAction func translate(_ sender: Any) {
        let text = textToTranslate.text!
        translatorService.translate(text: text) { (success, translator) in
            guard success, let translator = translator else {
                return
            }
            print(translator.data.translations[0].translatedText)
            self.textTranslated.text = translator.data.translations[0].translatedText
        }
    }
}

