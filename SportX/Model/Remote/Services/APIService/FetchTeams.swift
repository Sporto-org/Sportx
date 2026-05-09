//
//  FetchTeams.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/05/2026.
//

import Foundation
import Alamofire

extension NetworkManager {

    func fetchTeams(
        sport: String,
        leagueId: Int
    ) async throws -> [Team] {

        let response = try await request(
            endpoint: .teams(
                sport: sport,
                leagueId: leagueId
            ),
            model: APIResponse<[Team]>.self
        )

        return response.result ?? []
    }
}
