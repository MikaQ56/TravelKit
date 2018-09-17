//
//  ChangeRate.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Data struct for rates from fixer.io api. Protocol Codable used
struct Rates: Codable {
    let timestamp: Int
    let date: String
    let rates: [String : Double]
}


