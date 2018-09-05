//
//  Converter.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class Converter {
    
    static private var amount:Double?
    static private var rates: RatesList?
    static private var currencies = [String]()
    static private var changeService = ChangeService.shared
    static private var devise = "USD"
    
    static func set(amount: String?) {
        if let amount = amount {
            if let amount = Double(amount) {
                self.amount = amount
            } else {
                self.amount = 0
            }
        }
    }
    
    static func getAmount() -> Double? {
        return amount
    }
    
    static func getDevise() -> String {
        return devise
    }
    
    static func set(rates: RatesList) {
        self.rates = rates
    }
    
    static func getRates() -> RatesList? {
        return rates
    }
    
    static private func update(currencies: CurrenciesList) {
        self.currencies = Array(currencies.currencies.values)
    }
    
    static func setCurrencies() {
        changeService.getCurrencies { (success, currencies) in
            guard success, let currencies = currencies else {
                return
            }
            self.update(currencies: currencies)
        }
    }
    
    static func getCurrencies() -> [String] {
        return currencies
    }
    
    static func euro(to devise: String) -> Double {
        let rate = rates!.rates[devise]
        let result = amount! * rate!
        return result
    }
    
}
