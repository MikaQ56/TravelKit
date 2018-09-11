//
//  TranslatorServiceTestCase.swift
//  TravelKitTests
//
//  Created by Mickael on 11/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import XCTest
@testable import TravelKit

class TranslatorServiceTestCase: XCTestCase {
    
    func testTranslateShouldPostFailedCallbackIfErrorRequest() {
        // Given
        let translatorService = TranslatorService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.translate(text: "Bonjour le monde") { (success, translator, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(translator)
            XCTAssertEqual(state, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIfErrorServer() {
        // Given
        let translatorService = TranslatorService(session: URLSessionFake(data: FakeResponseData.translatorCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.translate(text: "Bonjour le monde") { (success, translator, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(translator)
            XCTAssertEqual(state, Alert.Request.errorServer)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translatorService = TranslatorService(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.translate(text: "Bonjour le monde") { (success, translator, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(translator)
            XCTAssertEqual(state, Alert.Request.errorData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translatorService = TranslatorService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.translate(text: "Bonjour le monde") { (success, translator, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(translator)
            XCTAssertEqual(state, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostSucceedCallbackIfNoErrorAndCorrectData() {
        // Given
        let translatorService = TranslatorService(session: URLSessionFake(data: FakeResponseData.translatorCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.translate(text: "Bonjour le monde") { (success, translator, state) in
            // Then
            XCTAssert(success)
            XCTAssertNotNil(translator)
            XCTAssertEqual(state, Alert.Request.succeed)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
