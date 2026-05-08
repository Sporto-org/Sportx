//
//  League.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 08/05/2026.
//

import Foundation
struct League: Decodable {

    let league_key: Int?
    let league_name: String?
    let country_name: String?
    let league_logo: String?
}

typealias LeaguesResponse = APIResponse<[League]>
