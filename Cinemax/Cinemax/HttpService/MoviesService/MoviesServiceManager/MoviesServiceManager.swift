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
        let router = MoviesRouter.upComing(pageCount: 1)
        let request = router.request
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                if let data = data {
                    print(data)
                }
            }
        }
        
        dataTask.resume()
    }
}
