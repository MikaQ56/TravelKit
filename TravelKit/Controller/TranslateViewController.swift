//
//  TranslateViewController.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    private let translateService = TranslateService.shared

    @IBOutlet weak var textTranslated: UILabel!
    @IBOutlet weak var textToTranslate: UITextView!
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textToTranslate.resignFirstResponder()
    }
    
    @IBAction func translate(_ sender: Any) {
        let text = textToTranslate.text!
        translateService.translate(text: text) { (success, translatedTextsList) in
            guard success, let translatedTextsList = translatedTextsList else {
                return
            }
            print(translatedTextsList.data.translations[0].translatedText)
        }
    }
}

