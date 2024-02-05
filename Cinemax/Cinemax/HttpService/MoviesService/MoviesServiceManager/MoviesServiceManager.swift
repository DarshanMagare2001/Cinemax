//
//  MoviesServiceManager.swift
//  Cinemax
//
//  Created by IPS-161 on 05/02/24.
//

import Foundation

class MoviesServiceManager {
    static let shared = MoviesServiceManager()
    private init() {}
    
    func fetchData() {
        
        let headers = ["accept": "application/json"]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                if let data = data {
                    print(data)
                }
            }
        })
        
        dataTask.resume()
    }
}
