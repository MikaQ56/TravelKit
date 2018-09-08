//
//  TextsTranslatedList.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

struct Translator: Codable {
    
    let data: Translations
    
    struct Translations: Codable {
        
        let translations: [TranslatedText]
        
        struct TranslatedText: Codable {
            let translatedText: String
        }
    }
}

/*struct TranslatedTextsList: Codable {
    let data : Translations
}

struct Translations: Codable {
    let translations : [TranslatedText]
}

struct TranslatedText: Codable {
    let translatedText: String
}*/
