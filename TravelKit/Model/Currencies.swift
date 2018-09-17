//
//  CurrenciesList.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Data struct for currencies from fixer.io api. Protocol Codable used
struct Currencies: Codable {
    let currencies: [String : String]
    
    enum CodingKeys: String, CodingKey {
        case currencies = "symbols"
    }
}

