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
    
    static func save(rates: Rates) {
        self.rates = rates
    }
    
    static func save(amount: String?) -> Bool {
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
    
    static func getCurrency() -> String {
        let currency = currencies[currencySymbol]
        if let currency = currency {
            return currency
        }
        return ""
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
    
    static func getDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(rates!.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        return dateFormatter.string(from: date)
    }
    
    static func convertFromEuro() -> String {
        rate = rates!.rates[currencySymbol]
        guard let rate = rate else {
            return "La devise n'existe pas !"
        }
        let result = amount! * rate
        return String(Int(result.rounded()))
    }
}
