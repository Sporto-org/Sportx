//
//  LeagueDetailsPresenter.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import Foundation

// MARK: - Protocols

protocol LeagueDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()

    // Upcoming Events
    func numberOfUpcomingEvents() -> Int
    func upcomingEvent(at index: Int) -> Fixture

    // Latest Events
    func numberOfLatestEvents() -> Int
    func latestEvent(at index: Int) -> Fixture

    // Teams
    func numberOfTeams() -> Int
    func team(at index: Int) -> Team
    func didSelectTeam(at index: Int)

    // Favourites
    func isFavorite() -> Bool
    func toggleFavorite() -> Bool
}

protocol LeagueDetailsViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func updateFavoriteButton(isFavorite: Bool)
    func navigateToTeamDetails(team: Team)
}

// MARK: - Presenter

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    weak var view: LeagueDetailsViewProtocol?

    private let league: League
    private let sportName: String

    private var upcomingEvents: [Fixture] = []
    private var latestEvents: [Fixture] = []
    private var teams: [Team] = []

    init(view: LeagueDetailsViewProtocol, league: League, sportName: String) {
        self.view = view
        self.league = league
        self.sportName = sportName
    }

    func viewDidLoad() {
        let isFav = isFavorite()
        view?.updateFavoriteButton(isFavorite: isFav)
        fetchData()
    }

    // MARK: - Upcoming Events

    func numberOfUpcomingEvents() -> Int {
        return upcomingEvents.count
    }

    func upcomingEvent(at index: Int) -> Fixture {
        return upcomingEvents[index]
    }

    // MARK: - Latest Events

    func numberOfLatestEvents() -> Int {
        return latestEvents.count
    }

    func latestEvent(at index: Int) -> Fixture {
        return latestEvents[index]
    }

    // MARK: - Teams

    func numberOfTeams() -> Int {
        return teams.count
    }

    func team(at index: Int) -> Team {
        return teams[index]
    }

    func didSelectTeam(at index: Int) {
        let team = teams[index]
        view?.navigateToTeamDetails(team: team)
    }

    // MARK: - Favourites

    func isFavorite() -> Bool {
        guard let leagueKey = league.league_key else { return false }
        return CoreDataManager.shared.isFavorite(id: String(leagueKey))
    }

    func toggleFavorite() -> Bool {
        guard let leagueKey = league.league_key else { return false }

        let result = CoreDataManager.shared.toggleFavorite(
            id: String(leagueKey),
            name: league.league_name ?? "",
            badgeURL: league.league_logo ?? "",
            sportName: sportName
        )
        return result
    }

    // MARK: - Private

    private func fetchData() {
        guard let leagueId = league.league_key else { return }

        view?.showLoading()

        Task { @MainActor in
            do {
                // Fetch fixtures and teams in parallel
                async let fixturesTask = NetworkManager.shared.fetchFixtures(
                    sport: sportName,
                    leagueId: leagueId
                )
                async let teamsTask = NetworkManager.shared.fetchTeams(
                    sport: sportName,
                    leagueId: leagueId
                )

                let allFixtures = try await fixturesTask
                self.teams = try await teamsTask

                // Split fixtures into upcoming and latest
                self.splitFixtures(allFixtures)

                self.view?.reloadData()
            } catch {
                self.view?.showError(error.localizedDescription)
            }
            self.view?.hideLoading()
        }
    }

    private func splitFixtures(_ fixtures: [Fixture]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())

        upcomingEvents = []
        latestEvents = []

        for fixture in fixtures {
            guard let eventDate = fixture.event_date else { continue }

            if eventDate >= today {
                // Upcoming or today
                if fixture.event_final_result == nil || fixture.event_final_result == "" || fixture.event_final_result == "-" {
                    upcomingEvents.append(fixture)
                } else {
                    latestEvents.append(fixture)
                }
            } else {
                latestEvents.append(fixture)
            }
        }

        // Sort: upcoming by date ascending, latest by date descending
        upcomingEvents.sort { ($0.event_date ?? "") < ($1.event_date ?? "") }
        latestEvents.sort { ($0.event_date ?? "") > ($1.event_date ?? "") }
    }
}
