//
//  FetchSport.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/05/2026.
//

import Foundation
import Alamofire

extension NetworkManager {

    func fetchSports() async throws -> [Sport] {

        let response = try await request(
            endpoint: .sports,
            model: APIResponse<[Sport]>.self
        )
        return response.result ?? []
    }
}
