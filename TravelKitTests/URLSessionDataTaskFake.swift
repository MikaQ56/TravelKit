//
//  URLSessionDataTaskFake.swift
//  TravelKitTests
//
//  Created by Mickael on 11/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class URLSessionDataTaskFake: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
}
