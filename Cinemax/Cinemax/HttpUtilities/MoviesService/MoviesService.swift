//
//  MoviesService.swift
//  Cinemax
//
//  Created by IPS-161 on 05/03/24.
//

import Foundation
import Alamofire

class MoviesService: HttpServiceProtocol {
    var sessionManager: Session
    
    init() {
        let serverTrustManager = ServerTrustManager(evaluators: ["api.themoviedb.org": DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.sessionManager = Session(configuration: configuration, serverTrustManager: serverTrustManager)
    }
    
    func request(urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest)
    }
}
