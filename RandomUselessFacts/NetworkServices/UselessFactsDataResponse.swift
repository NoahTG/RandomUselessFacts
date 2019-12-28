//
//  UselessFactsDataResponse.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

//// Response from Useless Facts API

//  Data from UselessFacts API
   struct UselessFactResponse: Codable {
       let text: String

       enum CodingKeys: String, CodingKey {
           case text
       }
}
