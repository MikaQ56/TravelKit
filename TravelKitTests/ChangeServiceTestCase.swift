//
//  ChangeServiceTestCase.swift
//  TravelKitTests
//
//  Created by Mickael on 11/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import XCTest
@testable import TravelKit

class ChangeServiceTestCase: XCTestCase {
    
    func testGetRatesShouldPostFailedCallbackIfErrorRequest() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getRates { (success, rates, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(rates)
            XCTAssertEqual(state, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfErrorServer() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getRates { (success, rates, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(rates)
            XCTAssertEqual(state!, Alert.Request.errorServer)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getRates { (success, rates, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(rates)
            XCTAssertEqual(state!, Alert.Request.errorData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfNoData() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getRates { (success, rates, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(rates)
            XCTAssertEqual(state!, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostSucceedCallbackIfNoErrorAndCorrectData() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getRates { (success, rates, state) in
            // Then
            XCTAssert(success)
            XCTAssertNotNil(rates)
            XCTAssertEqual(state!, Alert.Request.succeed)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrenciesShouldPostFailedCallbackIfErrorRequest() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getCurrencies { (success, currencies, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(currencies)
            XCTAssertEqual(state, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrenciesShouldPostFailedCallbackIfErrorServer() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: FakeResponseData.currenciesCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getCurrencies { (success, currencies, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(currencies)
            XCTAssertEqual(state!, Alert.Request.errorServer)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrenciesShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getCurrencies { (success, currencies, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(currencies)
            XCTAssertEqual(state!, Alert.Request.errorData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrenciesShouldPostFailedCallbackIfNoData() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getCurrencies { (success, currencies, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(currencies)
            XCTAssertEqual(state!, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrenciesShouldPostSucceedCallbackIfNoErrorAndCorrectData() {
        // Given
        let changeService = ChangeService(session: URLSessionFake(data: FakeResponseData.currenciesCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getCurrencies { (success, currencies, state) in
            // Then
            XCTAssert(success)
            XCTAssertNotNil(currencies)
            XCTAssertEqual(state!, Alert.Request.succeed)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
