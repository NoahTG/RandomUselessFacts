//
//  UselessFactsClient+Constants.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation

extension UselessFactsClient {
        
        enum UselessFactsAPI {
                static let APIScheme = "https"
                static let APIHost = "uselessfacts.jsph.pl"
                static let APIPath = ""
            }
    
        enum UselessFactsMethods {
            static let FactOfTheDay = "/today.json?language=en"
            static let RandomUselessFact = "/random.json?language=en"
        }

        
        enum UselessFactsKeys {
            static let Method = "method"
            static let Text = "text"
            static let Format = "format"
            static let NoJsonCallback = "nojsoncallback"
        }
        
        enum UselessFactsDefaultValues {
            static let ResponseFormat = "json"
            static let NoJsonCallback = "1" // 1 means "yes"
            static let ExtraMediumURL = "url_m"

        }
    

}
