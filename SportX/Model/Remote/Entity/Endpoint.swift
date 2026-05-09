//
//  Endpoint.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/05/2026.
//

import Foundation
import Alamofire

enum Endpoint {

    case sports
    case leagues(sport: String)
    case teams(sport: String, leagueId: Int)
    case fixtures(sport: String, leagueId: Int)

    var path: String {

        switch self {

        case .sports:
            return "/sports/"

        case .leagues(let sport):
            return "/\(sport.lowercased())/"

        case .teams(let sport, _):
            return "/\(sport.lowercased())/"

        case .fixtures(let sport, _):
            return "/\(sport.lowercased())/"
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

        case .teams(_, let leagueId):

            return [
                "met": "Teams",
                "leagueId": leagueId,
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
        }
    }
}
