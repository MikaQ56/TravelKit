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
    
    init(session: URLSession) {
        self.session = session
    }
    
    private let translatorUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    private let key = "AIzaSyBgwqShF3Thl_B-0-P93uTE1RIMMjPsIwQ"
    
    private var session = URLSession(configuration: .default)
    
    private var task: URLSessionDataTask?
    
    func translate(text: String, callback: @escaping (Bool, Translator?, Request) -> Void) {
        let request = createTranslateRequest(text: text)
        task?.cancel()
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil, Request.errorRequest)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil, Request.errorServer)
                    return
                }
                guard let translator = try? JSONDecoder().decode(Translator.self, from: data ) else {
                    callback(false, nil, Request.errorData)
                    return
                }
                callback(true, translator, Request.succeed)
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
