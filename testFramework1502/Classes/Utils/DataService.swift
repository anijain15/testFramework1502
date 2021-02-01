//
//  DataService.swift
//  WynkMusicUITests
//
//  Created by B0218201 on 16/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation

class DataService{
    
    static let shared = DataService()
    fileprivate var postBody:Data?
    
    func postTestResultsInKibana(_ body : PerfModel)
    {
        let perfData:Data = try! JSONEncoder().encode(body)
        let stringPerfData = String(data: perfData, encoding: .utf8)
        print(stringPerfData!)
        postBody.self = perfData
        DataService.shared.fetchData{ (result) in
            switch result
            {
            case .success(let json):
                print(json)
                
            case .failure(let error):
                print(error)
            }}
    }
    
    func fetchData(completion: @escaping (Result<Any, Error>) -> Void)
    {
        let postComp = createURLComponent("/api/v1/results/testResults")
        
        guard let composedUrl = postComp.url else {
            print("URL creation failed")
            return
        }
        
        var postRequest = URLRequest(url :composedUrl)
        postRequest.httpMethod =  "POST"
        postRequest.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.httpBody = postBody
        
        
        _ = URLSession.shared.dataTask(with: postRequest)
        { data, response, error in
            
            if let httpResponse = response {
                print(httpResponse)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                print("Status Code: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else
            {
                completion(.failure(error!))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                completion(.success(json))
            }catch let serializationError
            {
                completion(.failure(serializationError))
            }
        }.resume()
        //sleep(3000)
    }
    
    func createURLComponent(_ path: String) -> URLComponents
    {
        var componentURL = URLComponents()
        componentURL.scheme = "http"
        componentURL.host = "10.90.31.13"
        componentURL.port = 8082
        componentURL.path = path
        
        print(componentURL.url!)
        
        return componentURL
    }
}
