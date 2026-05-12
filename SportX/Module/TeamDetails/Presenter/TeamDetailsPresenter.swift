//
//  TeamDetailsPresenter.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import Foundation

// MARK: - Protocols

protocol TeamDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()

    func teamName() -> String
    func teamLogo() -> String?
    func coachName() -> String

    func numberOfSections() -> Int
    func sectionTitle(for section: Int) -> String
    func numberOfPlayers(in section: Int) -> Int
    func player(at indexPath: IndexPath) -> Player
}

protocol TeamDetailsViewProtocol: AnyObject {
    func reloadData()
    func displayTeamInfo(name: String, logoURL: String?, coach: String)
}

// MARK: - Presenter

class TeamDetailsPresenter: TeamDetailsPresenterProtocol {

    weak var view: TeamDetailsViewProtocol?
    private let team: Team

    /// Players grouped by position type
    private var sections: [(title: String, players: [Player])] = []

    init(view: TeamDetailsViewProtocol, team: Team) {
        self.view = view
        self.team = team
    }

    func viewDidLoad() {
        groupPlayers()
        view?.displayTeamInfo(
            name: team.team_name ?? "Unknown",
            logoURL: team.team_logo,
            coach: coachName()
        )
        view?.reloadData()
    }

    func teamName() -> String {
        return team.team_name ?? "Unknown"
    }

    func teamLogo() -> String? {
        return team.team_logo
    }

    func coachName() -> String {
        return team.coaches?.first?.coach_name ?? "N/A"
    }

    func numberOfSections() -> Int {
        return sections.count
    }

    func sectionTitle(for section: Int) -> String {
        return sections[section].title
    }

    func numberOfPlayers(in section: Int) -> Int {
        return sections[section].players.count
    }

    func player(at indexPath: IndexPath) -> Player {
        return sections[indexPath.section].players[indexPath.row]
    }

    // MARK: - Private

    private func groupPlayers() {
        guard let players = team.players else {
            sections = []
            return
        }

        let positionOrder = ["Goalkeepers", "Defenders", "Midfielders", "Forwards"]

        // Group players by their type
        var grouped: [String: [Player]] = [:]
        for player in players {
            let type = player.player_type ?? "Other"
            grouped[type, default: []].append(player)
        }

        // Build sections in the preferred order
        sections = []
        for position in positionOrder {
            if let playersInPosition = grouped[position], !playersInPosition.isEmpty {
                sections.append((title: position, players: playersInPosition))
                grouped.removeValue(forKey: position)
            }
        }

        // Add any remaining groups that don't match the standard positions
        for (title, players) in grouped.sorted(by: { $0.key < $1.key }) {
            if !players.isEmpty {
                sections.append((title: title, players: players))
            }
        }
    }
}
