//
//  FetchFixtures.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/05/2026.
//

import Foundation
import Alamofire
extension NetworkManager {

    func fetchFixtures(
        sport: String,
        leagueId: Int
    ) async throws -> [Fixture] {

        let response = try await request(
            endpoint: .fixtures(
                sport: sport,
                leagueId: leagueId
            ),
            model: APIResponse<[Fixture]>.self
        )

        return response.result ?? []
    }
}
