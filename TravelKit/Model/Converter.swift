//
//  Converter.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class Converter {
    
    static let shared = Converter()
    private init(){}
    private var rate: Double?
    private var changeService = ChangeService.shared
    var currencies: [String : String]?
    var currencySymbol: String?
    var amount:Double?
    private var rates: Rates?
    
    func saveCurrencies() -> Bool {
        changeService.getCurrencies { (success, currencies, state) in
            guard success, let currencies = currencies else {
                print(state!.rawValue)
                self.currencies = ["USD": "United States Dollar"]
                return
            }
            self.currencies = currencies.currencies
        }
        return true
    }
    
    func saveRates() -> Bool {
        changeService.getRates { (success, rates, state) in
            guard success, let rates = rates else {
                print(state!.rawValue)
                return
            }
            self.rates = rates
        }
        return true
    }
    
    func setCurrencySymbol(index: Int) throws -> String {
        let currencies = self.currencies!
        for (i, symbol) in currencies.keys.enumerated() {
            if i == index {
                return symbol
            }
        }
        throw Errors.CurrencyError.currencyIsNotAvailable
    }
    
    func currencyPicked() -> String {
        if let currencies = self.currencies {
            let currency = currencies[currencySymbol!]!
            return currency
        }
        return String()
    }
    
    func getDate() -> String {
        let timestamp = rates!.timestamp
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        return dateFormatter.string(from: date)
    }
    
    func convertFromEuro() -> String {
        let rates = self.rates!.rates
        rate = rates[currencySymbol!]
        let result = amount! * rate!
        return String(Int(result.rounded()))
    }
}
