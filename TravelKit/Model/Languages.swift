//
//  Languages.swift
//  TravelKit
//
//  Created by Mickael on 08/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Manage languages available in app
enum Languages: Int {
    case deutch = 0, danish, norvegian, greek, english, spanish, finland, irish, iceland, italian, japan, netherland
}

class Language {
    
    static var language: Languages = .english
    
    static func getTarget(language: Languages) -> String {
        switch language {
        case .deutch :
            return "de"
        case .danish :
            return "da"
        case .norvegian :
            return "no"
        case .greek :
            return "el"
        case .english :
            return "en"
        case .spanish:
            return "es"
        case .finland:
            return "fi"
        case .irish:
            return "ga"
        case .iceland:
            return "is"
        case .italian:
            return "it"
        case .japan:
            return "ja"
        case .netherland:
            return "nl"
        }
    }
    
}





