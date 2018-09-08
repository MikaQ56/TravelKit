//
//  ChangeService.swift
//  TravelKit
//
//  Created by Mickael on 04/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class ChangeService {
    
    static let shared = ChangeService()
    
    private init(){}
    
    private let ratesUrl = URL(string: "http://data.fixer.io/api/latest?access_key=69389a470e7df4f67b5e02e082b4e4bf")
    
    private let currenciesUrl = URL(string: "http://data.fixer.io/api/symbols?access_key=69389a470e7df4f67b5e02e082b4e4bf")
    
    private let session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func getRates(callback: @escaping (Bool, Rates?) -> Void) {
        task?.cancel()
        task = session.dataTask(with: ratesUrl!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print(error!)
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("response")
                    callback(false, nil)
                    return
                }
                guard
                    let rates = try? JSONDecoder().decode(Rates.self, from: data)
                    else {
                        print("rates")
                        callback(false, nil)
                        return
                    }
                print("OK")
                callback(true, rates)
            }
            
        }
        task?.resume()
    }
    
    func getCurrencies(callback: @escaping (Bool, Currencies?) -> Void) {
        task?.cancel()
        task = session.dataTask(with: currenciesUrl!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard
                    let currencies = try? JSONDecoder().decode(Currencies.self, from: data)
                    else {
                        callback(false, nil)
                        return
                }
                
                callback(true, currencies)
            }
            
        }
        task?.resume()
    }
    
}
