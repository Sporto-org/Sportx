//
//  SportModel.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 08/05/2026.
//

import Foundation
struct Sport: Decodable {
    let sport_key: Int?
    let sport_name: String?
    let sport_icon: String?
}

typealias SportsResponse = APIResponse<[Sport]>
