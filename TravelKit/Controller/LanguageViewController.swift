//
//  LanguageViewController.swift
//  TravelKit
//
//  Created by Mickael on 08/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    private var language: Languages?

    @IBOutlet var languageButtons: [UIButton]!
    
    @IBAction func tappedLanguageButton(_ sender: UIButton) {
        for languageButton in languageButtons {
            if sender == languageButton {
                let tagButton = languageButton.tag
                language = Languages(rawValue: tagButton)
                guard let language = language else {
                    return
                }
                let target = Language.getTarget(language: language)
                TranslatorService.shared.set(target: target)
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
