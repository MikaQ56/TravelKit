//
//  LanguageViewController.swift
//  TravelKit
//
//  Created by Mickael on 08/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    private let translatorService = TranslatorService.shared

    @IBOutlet var languageButtons: [UIButton]!
    
    // Update language target when language button tapped & back to rootViewController 'TranslateView'
    @IBAction func tappedLanguageButton(_ sender: UIButton) {
        for languageButton in languageButtons {
            if sender == languageButton {
                let tagButton = languageButton.tag
                translatorService.setTarget(buttonTag: tagButton)
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
