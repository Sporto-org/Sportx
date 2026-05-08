//
//  SportsEndpoint.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 08/05/2026.
//

import Foundation
enum SportsEndpoint {

    case sports
    case leagues(sport: String)
    case fixtures(sport: String, leagueId: Int)
    case teams(sport: String, leagueId: Int)

    var path: String {
        switch self {
        case .sports:
            return "/sports/"

        case .leagues(let sport):
            return "/\(sport)/"

        case .fixtures(let sport, _):
            return "/\(sport)/"

        case .teams(let sport, _):
            return "/\(sport)/"
        }
    }

    var parameters: Parameters {

        switch self {

        case .sports:
            return [
                "met": "Sports",
                "APIkey": API.apiKey
            ]

        case .leagues:
            return [
                "met": "Leagues",
                "APIkey": API.apiKey
            ]

        case .fixtures(_, let leagueId):
            return [
                "met": "Fixtures",
                "leagueId": leagueId,
                "from": "2026-01-01",
                "to": "2026-12-31",
                "APIkey": API.apiKey
            ]

        case .teams(_, let leagueId):
            return [
                "met": "Teams",
                "leagueId": leagueId,
                "APIkey": API.apiKey
            ]
        }
    }
}
