//
//  RequestError.swift
//  TravelKit
//
//  Created by Mickael on 10/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation


enum Request: String {
    case succeed = "Opération réussie"
    case errorRequest = "Il y a une erreur dans la requête"
    case errorServer = "Le serveur ne répond pas"
    case errorData = "Il y a un problème avec les données"
}
    


