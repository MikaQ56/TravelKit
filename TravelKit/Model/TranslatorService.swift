//
//  TranslateService.swift
//  TravelKit
//
//  Created by Mickael on 05/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class TranslatorService {
    
    static let shared = TranslatorService()
    
    private var target = "en"
    
    private init(){}
    
    private let translatorUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    private let key = ""
    
    private let session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func translate(text: String, callback: @escaping (Bool, Translator?) -> Void) {
        let request = createTranslateRequest(text: text)
        task?.cancel()
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Error: No data to decode")
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Error: response")
                    callback(false, nil)
                    return
                }
                guard let translator = try? JSONDecoder().decode(Translator.self, from: data ) else {
                    print("Error: Couldn't decode data")
                    callback(false, nil)
                    return
                }
                callback(true, translator)
            }
        })
        task?.resume()
    }
    
    private func createTranslateRequest(text: String) -> URLRequest {
        var request = URLRequest(url: translatorUrl)
        request.httpMethod = "POST"
        let body = "key=\(key)&q=\(text)&source=fr&target=\(target)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    func set(target: String) {
        self.target = target
    }
    
    func getTarget() -> String {
        return target
    }
}
