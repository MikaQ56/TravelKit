//
//  TranslateService.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class TranslateService {
    
    static let shared = TranslateService()
    
    private init(){}
    
    private let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    private let key = "AIzaSyBgwqShF3Thl_B-0-P93uTE1RIMMjPsIwQ"
    
    private let session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func translate(text: String, callback: @escaping (Bool, TranslatedTextsList?) -> Void) {
        let request = createTranslateRequest(text: text)
        task?.cancel()
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let translatedTextsList = try? JSONDecoder().decode(TranslatedTextsList.self, from: data ) else {
                    callback(false, nil)
                    return
                }
                callback(true, translatedTextsList)
            }
        })
        task?.resume()
    }
    
    private func createTranslateRequest(text: String) -> URLRequest {
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        let body = "key=\(key)&q=\(text)&source=fr&target=en&format=text"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
}
