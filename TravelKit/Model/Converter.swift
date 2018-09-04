//
//  Converter.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class Converter {
    
    private var amount = Double()
    
    func convert(changeRate: ChangeRate, amount: String?) -> Double {
        
        if let amount = amount {
            self.amount = Double(amount)!
        }
        if let rate = changeRate.rates["USD"] {
            return self.amount * rate
        }
        return 0
    }
}
