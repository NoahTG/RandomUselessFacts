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

class UselessFactsClient: UselessFactsClientProtocol {
 
    
    // MARK: Properties
    let apiClient: APIClientProtocol
            
    var dataController: DataController
    
    var notebookPersist: NotebookPersistence
        
    // Create baseURL for Flickr requests & lazy means code only runs when called
       private lazy var baseURL: URL = {
           var components = URLComponents()
           components.scheme = UselessFactsAPI.APIScheme
           components.host = UselessFactsAPI.APIHost
           components.path = UselessFactsAPI.APIPath
           return components.url!
       }()
    
    
    // MARK: Initializers

    required init(apiClient: APIClientProtocol, notebookPersist: NotebookPersistence, dataController: DataController) {
         self.apiClient = apiClient
         self.notebookPersist = notebookPersist
         self.dataController = dataController
     }
    
    // MARK: Imperatives
    
    
    func getFactOfTheDay(completionHandler: @escaping (UselessFactResponse?, Error?) -> Void) {
        let queryParameters = [
                   UselessFactsKeys.Format: UselessFactsDefaultValues.ResponseFormat,
                   UselessFactsKeys.NoJsonCallback: UselessFactsDefaultValues.NoJsonCallback,
                   
                   UselessFactsKeys.Method: UselessFactsMethods.FactOfTheDay
               ]

               let dataTask = apiClient.createGETDataTask(
                    withURL: baseURL,
                    parameters: queryParameters,
                    headers: nil) { (data, error) in
                        
                   guard let data = data, error == nil else {
                       completionHandler (nil, error!)
                       return
                   }
                   
                   let decoder = JSONDecoder()
                  
                   do {
                       let uselessGETResponse = try decoder.decode(UselessFactResponse.self, from: data)
                       completionHandler(uselessGETResponse, nil)
                   } catch {
                       completionHandler(nil, URLSessionTask.TaskHasError.malformedJsonResponse)
                       }
                   }
                   dataTask.resume()
        }
    
           
    


    func getRandomFact(completionHandler: @escaping (UselessFactResponse?, Error?) -> Void) {
        let queryParameters = [
                       UselessFactsKeys.Format: UselessFactsDefaultValues.ResponseFormat,
                       UselessFactsKeys.NoJsonCallback: UselessFactsDefaultValues.NoJsonCallback,
                       
                       UselessFactsKeys.Method: UselessFactsMethods.RandomUselessFact
                   ]

                   let dataTask = apiClient.createGETDataTask(
                        withURL: baseURL,
                        parameters: queryParameters,
                        headers: nil) { (data, error) in
                            
                       guard let data = data, error == nil else {
                           completionHandler (nil, error!)
                           return
                       }
                       
                       let decoder = JSONDecoder()
                      
                       do {
                           let uselessGETResponse = try decoder.decode(UselessFactResponse.self, from: data)
                           completionHandler(uselessGETResponse, nil)
                       } catch {
                           completionHandler(nil, URLSessionTask.TaskHasError.malformedJsonResponse)
                           }
                       }
                       dataTask.resume()
        }
    
    
}
    
            
//     func saveFact(fromUrl url: URL, completionHandler: @escaping (String?, URLSessionTask.TaskHasError?) -> Void ) {
//
//
//        let dataTask = self.apiClient.createGETDataTask(
//            withURL: url,
//            parameters: [:],
//            headers: [:]) { (data, error) in
//
//                guard let data = data, error == nil else {
//                    completionHandler(nil, error)
//                    return
//
//                }
//
//                guard let image = UIImage(data: data) else {
//                    completionHandler(nil, .unexpectedResource)
//                    return
//                }
//                completionHandler(image, nil)
//            }
//        dataTask.resume()
//
//        let factObjectId = fact.objectID
//
//
//       let factContext = self.dataController.viewContext.object(with: factObjectId) as! Fact
//
//       DispatchQueue.main.async {
//           do {
//               try self.notebookPersist.saveFact(
//                   fact:  ,
//                   fact: UselessFactResponse, toNotebook: factContext.toNotebook!)
//               completionHandler(fact, data.searchResults.pages, nil)
//           } catch {
//               completionHandler(nil, error)
//           }
//       }
//   }
//
//
//}


// Protocol for retrieving and persisting data from Useless Facts API
protocol UselessFactsClientProtocol {
    
    /// Retrieves Useless Fact of the Day
    /// - Parameters:
    ///     - completionHandler: function that will be called following the compeltion of this method.
    func getFactOfTheDay(completionHandler: @escaping (UselessFactResponse?, Error?) -> Void)
    
    /// Retrieves random fact
      /// - Parameters
      ///     - completionHandler: function that will be called following the compeltion of this method.
    func getRandomFact(completionHandler: @escaping (UselessFactResponse?, Error?) -> Void)
//
//    /// Download the fact from URL
//    /// - Parameters:
//    ///        - url: Fact Url.
//    ///        - completionHandler: function that will be called following the completion of this method.
//    func saveFact(fromUrl url: URL, completionHandler: @escaping (String?, URLSessionTask.TaskHasError?) -> Void )
    
}
