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
    
    private let changeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=69389a470e7df4f67b5e02e082b4e4bf")
    
    private let session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func getChangeRate(callback: @escaping (Bool, ChangeRate?) -> Void) {
        task?.cancel()
        task = session.dataTask(with: changeUrl!) { (data, response, error) in
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
                    let changeRate = try? JSONDecoder().decode(ChangeRate.self, from: data)
                    else {
                        callback(false, nil)
                        return
                    }
                
                callback(true, changeRate)
            }
            
        }
        task?.resume()
    }
    
}
