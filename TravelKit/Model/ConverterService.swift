//
//  Converter.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class ConverterService {
    
    static let shared = ConverterService()
    private init(){}
    init(symbols: [String], rates: Rates) {
        self.symbols = symbols
        self.rates = rates
    }
    var rate: Double?
    private var changeService = ChangeService.shared
    var currencies: [String]?
    var symbols: [String]?
    var currenciesList: [String : String]?
    var symbol: String?
    var amount:Double?
    private var rates: Rates?
    
    func saveCurrencies() -> Bool {
        changeService.getCurrencies { (success, currencies, state) in
            guard success, let currencies = currencies else {
                print(state!.rawValue)
                self.currencies = ["United States Dollar"]
                return
            }
            self.currencies = [String](currencies.currencies.values)
            self.symbols = [String](currencies.currencies.keys)
            self.currenciesList = currencies.currencies
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
    
    func getSymbol(index: Int) throws -> String {
        for (i, symbol) in symbols!.enumerated() {
            if i == index {
                self.symbol = symbol
                return symbol
            }
        }
        throw Errors.CurrencyError.currencyIsNotAvailable
    }
    
    func currencyPicked() -> String {
        if let currenciesList = self.currenciesList {
            let currency = currenciesList[symbol!]!
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
        rate = rates[symbol!]
        let result = amount! * rate!
        return String(Int(result.rounded()))
    }
}
