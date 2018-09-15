//
//  ConverterTestCase.swift
//  TravelKitTests
//
//  Created by Mickael on 11/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import XCTest
@testable import TravelKit

class ConverterTestCase: XCTestCase {
    
    var data: Data!
    var symbols: [String]!
    var converterService: ConverterService!
    
    override func setUp() {
        super.setUp()
        data = FakeResponseData.currenciesCorrectData
        let currenciesList = try! JSONDecoder().decode(Currencies.self, from: data!)
        symbols = [String](currenciesList.currencies.keys)
        data = FakeResponseData.ratesCorrectData
        let rates = try! JSONDecoder().decode(Rates.self, from: data!)
        converterService = ConverterService(symbols: symbols, rates: rates)
    }
    
    func testGetCurrencySymbolMethod() {
        // Given
        let index = 5
        // When
        if let symbol = try? converterService.getSymbol(index: index) {
            //Then
            XCTAssertEqual(symbol, "ANG")
        } 
    }
    
    func testConvertFromEuroMethod() {
        // Given
        converterService.amount = 100
        converterService.symbol = "USD"
        let result = converterService.convertFromEuro()
        let sample = (100*1.158943).rounded()
        XCTAssertEqual(result, String(Int(sample)))
    }
}
