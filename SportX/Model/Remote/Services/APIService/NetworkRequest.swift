//
//  NetworkRequest.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/05/2026.
//

import Foundation
import Alamofire

extension NetworkManager {

    func request<T: Decodable>(
        endpoint: Endpoint,
        model: T.Type
    ) async throws -> T {

        let url = API.baseURL + endpoint.path

        return try await withCheckedThrowingContinuation { continuation in
            
            AF.request(
                url,
                parameters: endpoint.parameters
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
