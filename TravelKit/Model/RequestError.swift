//
//  RequestError.swift
//  TravelKit
//
//  Created by Mickael on 10/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case requestFailed
    case requestStatus
    case requestData
}
