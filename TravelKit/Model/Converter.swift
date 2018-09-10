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
    static private var rates: Rates?
    static private var rate: Double?
    static private var currencies = [String : String]()
    static private var changeService = ChangeService.shared
    static private var currencySymbol = "USD"
    static private var result: Double?
    
    static func set(amount: String?) -> Bool {
        if let amount = amount {
            if let amount = Double(amount) {
                self.amount = amount
                return true
            } else {
                self.amount = 0
                return false
            }
        }
        return false
    }
    
    static func getAmount() -> Double? {
        return amount
    }
    
    static func getCurrencySymbol() -> String {
        return currencySymbol
    }
    
    static func set(rates: Rates) {
        self.rates = rates
    }
    
    static func getRates() -> Rates? {
        return rates
    }
    
    static func update(currencies: Currencies) {
        self.currencies = currencies.currencies
    }
    
    static func getCurrencies() -> [String : String] {
        return currencies
    }
    
    static func setCurrencySymbol(index: Int){
        for (i, symbol) in currencies.keys.enumerated() {
            if i == index {
                currencySymbol = symbol
            }
        }
    }
    
    static func convertFromEuro(){
        rate = rates!.rates[currencySymbol]
        result = amount! * rate!
    }
    
    static func getResult() -> Double {
        return result!
    }
    
}
