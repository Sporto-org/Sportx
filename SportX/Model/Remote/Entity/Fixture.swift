//
//  Fixture.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/05/2026.
//

import Foundation
struct Fixture: Decodable {

    let event_key: Int?
    let event_date: String?
    let event_time: String?

    let event_home_team: String?
    let event_away_team: String?

    let event_final_result: String?
    let event_status: String?

    let home_team_logo: String?
    let away_team_logo: String?

    let league_name: String?
    let league_key: Int?
}
