//
//  Converter.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class Converter {
    
    private var amount:Double?
    private var rates: RatesList?
    private var currencies = [String]()
    
    
    func set(rates: RatesList) {
        self.rates = rates
    }
    
    func set(currencies: CurrenciesList) {
        self.currencies = Array(currencies.currencies.values)
    }
    
    func getCurrencies() -> [String] {
        return currencies
    }
    
    func set(amount: String?) {
        if let amount = amount {
            if let amount = Double(amount) {
                self.amount = amount
            }
        }
    }
    
    func euro(to currency: String) -> Double {
        if let rate = rates!.rates[currency] {
            return rate * amount!
        }
        return 0
    }
    
}
