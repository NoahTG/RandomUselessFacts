//
//  UselessFactsClient.swift
//  RandomUselessFacts
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UselessFactsClient {
 

    // MARK: Imperatives
    
     enum Endpoints {
         static let base = "https://uselessfacts.jsph.pl"
         
         case factOfTheDay
         case randomFact
        
         var stringValue: String {
             switch self {
             case .factOfTheDay: return Endpoints.base + "/today.json?language=en"
             case .randomFact: return Endpoints.base + "/random.json?language=en"
            }
         }
         
         var url: URL {
             return URL(string: stringValue)!
            }
        }
    
        class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
         
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data else {
                 DispatchQueue.main.async {
                     completion(nil, error)
                 }
                 return
             }
             
             let decoder = JSONDecoder()
             
             do {
                 let responseObject = try decoder.decode(ResponseType.self, from: data)
                 DispatchQueue.main.async {
                     completion(responseObject, nil)
                 }
             } catch {
                 completion(nil, error)
             }
         }
         task.resume()
         return task
     }
    
     
        class func getFactOfTheDay(completion: @escaping (UselessFactResponse?, Error?) -> Void) {
            taskForGETRequest(url: Endpoints.factOfTheDay.url, responseType: UselessFactResponse.self){ response, error in
             if let response = response {
                 completion(response, nil)
             } else {
                 completion(nil, error)
             }
         }
     }
     
        class func getRandomFact(completion: @escaping (UselessFactResponse?, Error?) -> Void) {
            taskForGETRequest(url: Endpoints.randomFact.url, responseType: UselessFactResponse.self){ response, error in
             if let response = response {
                 completion(response, nil)
             } else {
                 completion(nil, error)
             }
         }
     }
    
    
}


