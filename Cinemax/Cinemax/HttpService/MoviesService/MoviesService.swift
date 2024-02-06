//
//  MoviesService.swift
//  Cinemax
//
//  Created by IPS-161 on 05/02/24.
//

import Foundation


enum ServerError: Error {
    case serverError(Error)
    case dataDecodingError(String)
}

class MoviesService{
    static let shared = MoviesService()
    func fetchData<T:Decodable>(router:MoviesRouter,model:T.Type,completion:@escaping(Result<T?,ServerError>)->()) {
        let request = router.request
        print(request)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(ServerError.serverError(error)))
                return
            } else {
                if let httpResponse = response as? HTTPURLResponse , (200...400).contains(httpResponse.statusCode) {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        let decodedData = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                    }catch let error{
                        completion(.failure(ServerError.dataDecodingError("Data decoding Error.")))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
