//
//  WeatherServiceTestCase.swift
//  TravelKitTests
//
//  Created by Mickael on 11/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import XCTest

@testable import TravelKit

class WeatherServiceTestCase: XCTestCase {
    
    func testGetWeatherShouldPostFailedCallbackIfErrorRequest() {
        // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Lorient") { (success, weather, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(weather)
            XCTAssertEqual(state, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfErrorServer() {
        // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.translatorCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Lorient") { (success, weather, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(weather)
            XCTAssertEqual(state, Alert.Request.errorServer)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Lorient") { (success, weather, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(weather)
            XCTAssertEqual(state, Alert.Request.errorData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Lorient") { (success, weather, state) in
            // Then
            XCTAssert(!success)
            XCTAssertNil(weather)
            XCTAssertEqual(state, Alert.Request.errorRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSucceedCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Lorient") { (success, weather, state) in
            // Then
            XCTAssert(success)
            XCTAssertNotNil(weather)
            XCTAssertEqual(state, Alert.Request.succeed)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}

