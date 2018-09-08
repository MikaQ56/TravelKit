//
//  CurrenciesList.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

struct Currencies: Codable {
    let currencies: [String : String]
    
    enum CodingKeys: String, CodingKey {
        case currencies = "symbols"
    }
}

