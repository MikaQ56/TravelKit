//
//  FormError.swift
//  TravelKit
//
//  Created by Mickael on 15/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Manage errors
class Errors{
    
    enum FormError : Error {
        case isNotNumber
    }
    
    enum CurrencyError: Error {
        case currencyIsNotAvailable
    }
}

