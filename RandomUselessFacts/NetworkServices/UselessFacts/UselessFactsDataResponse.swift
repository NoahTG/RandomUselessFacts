//
//  UselessFactsDataResponse.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

//// Response from Useless Facts API
//struct RandomFactResponse: Codable {
//    let fact: String
//}
//
//struct FactOfTheDayResponse: Codable {
//    let fact: String
//}

//  Data from UselessFacts API
   struct UselessFactResponse: Codable {
       let fact: String

       enum CodingKeys: String, CodingKey {
           case fact
       }
}
