//
//  ChangeRate.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

struct ChangeRate : Decodable {
    let timestamp: Int
    let rates: [String : Double]
}
