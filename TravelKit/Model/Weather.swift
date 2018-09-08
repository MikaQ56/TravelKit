//
//  Weather.swift
//  TravelKit
//
//  Created by Mickael on 08/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    let query: Query
    
    struct Query: Codable {
        
        let results: Results
        
        struct Results: Codable {
            
            let channel: Channel
            
            struct Channel: Codable {
                
                let location: Location
                let wind: Wind
                let astronomy: Astronomy
                let item: Item
                
                struct Location: Codable {
                    let city: String
                    let country: String
                    let region: String
                }
                
                struct Wind: Codable {
                    let speed: String
                }
                
                struct Astronomy: Codable {
                    let sunrise: String
                    let sunset: String
                }
                
                struct Item: Codable {
                    
                    let condition: Condition
                    
                    struct Condition: Codable {
                        let code: String
                        let date: String
                        let temp: String
                        let text: String
                    }
                }
            }
        }
    }
}




