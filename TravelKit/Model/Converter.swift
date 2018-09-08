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
    
    static func getCurrencySymbol() -> String {
        return currencySymbol
    }
    
    static func set(rates: Rates) {
        self.rates = rates
    }
    
    static func getRates() -> Rates? {
        return rates
    }
    
    static private func update(currencies: Currencies) {
        self.currencies = currencies.currencies
    }
    
    static func setCurrencies() {
        changeService.getCurrencies { (success, currencies) in
            guard success, let currencies = currencies else {
                return
            }
            self.update(currencies: currencies)
        }
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
