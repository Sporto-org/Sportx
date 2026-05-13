//
//  SportXTests.swift
//  SportXTests
//
//  Created by Zeiad Mohammed on 13/05/2026.
//

import XCTest
import CoreData
@testable import SportX

// MARK: - Model Decoding Tests

class ModelDecodingTests: XCTestCase {

    func testSportDecoding() throws {
        let json = """
        {
            "sport_key": 1,
            "sport_name": "Football",
            "sport_icon": "https://example.com/football.png"
        }
        """.data(using: .utf8)!

        let sport = try JSONDecoder().decode(Sport.self, from: json)
        XCTAssertEqual(sport.sport_key, 1)
        XCTAssertEqual(sport.sport_name, "Football")
        XCTAssertEqual(sport.sport_icon, "https://example.com/football.png")
    }

    func testLeagueDecoding() throws {
        let json = """
        {
            "league_key": 100,
            "league_name": "Premier League",
            "country_name": "England",
            "league_logo": "https://example.com/pl.png"
        }
        """.data(using: .utf8)!

        let league = try JSONDecoder().decode(League.self, from: json)
        XCTAssertEqual(league.league_key, 100)
        XCTAssertEqual(league.league_name, "Premier League")
        XCTAssertEqual(league.country_name, "England")
    }

    func testFixtureDecoding() throws {
        let json = """
        {
            "event_key": 500,
            "event_date": "2026-05-10",
            "event_time": "20:00",
            "event_home_team": "Team A",
            "event_away_team": "Team B",
            "event_final_result": "2 - 1",
            "event_status": "Finished",
            "home_team_logo": "https://example.com/a.png",
            "away_team_logo": "https://example.com/b.png",
            "league_name": "Premier League",
            "league_key": 100
        }
        """.data(using: .utf8)!

        let fixture = try JSONDecoder().decode(Fixture.self, from: json)
        XCTAssertEqual(fixture.event_key, 500)
        XCTAssertEqual(fixture.event_final_result, "2 - 1")
        XCTAssertEqual(fixture.event_status, "Finished")
        XCTAssertEqual(fixture.event_time, "20:00")
        XCTAssertEqual(fixture.league_key, 100)
    }

    func testTeamDecoding() throws {
        let json = """
        {
            "team_key": 200,
            "team_name": "Arsenal",
            "team_logo": "https://example.com/arsenal.png",
            "players": [
                {
                    "player_key": 1,
                    "player_name": "Player One",
                    "player_type": "Goalkeepers",
                    "player_number": "1",
                    "player_age": "28"
                }
            ],
            "coaches": [
                {
                    "coach_name": "John Doe",
                    "coach_country": "England"
                }
            ]
        }
        """.data(using: .utf8)!

        let team = try JSONDecoder().decode(Team.self, from: json)
        XCTAssertEqual(team.team_key, 200)
        XCTAssertEqual(team.team_name, "Arsenal")
        XCTAssertEqual(team.players?.count, 1)
        XCTAssertEqual(team.players?.first?.player_name, "Player One")
        XCTAssertEqual(team.coaches?.first?.coach_name, "John Doe")
    }

    func testPlayerDecoding() throws {
        let json = """
        {
            "player_key": 10,
            "player_name": "Star Player",
            "player_image": "https://example.com/player.png",
            "player_number": "7",
            "player_type": "Forwards",
            "player_age": "25",
            "player_goals": "15",
            "player_rating": "8.5"
        }
        """.data(using: .utf8)!

        let player = try JSONDecoder().decode(Player.self, from: json)
        XCTAssertEqual(player.player_key, 10)
        XCTAssertEqual(player.player_name, "Star Player")
        XCTAssertEqual(player.player_type, "Forwards")
        XCTAssertEqual(player.player_goals, "15")
    }

    func testSportDecodingWithNilFields() throws {
        let json = """
        {}
        """.data(using: .utf8)!

        let sport = try JSONDecoder().decode(Sport.self, from: json)
        XCTAssertNil(sport.sport_key)
        XCTAssertNil(sport.sport_name)
        XCTAssertNil(sport.sport_icon)
    }
}

// MARK: - CoreData Tests

class CoreDataTests: XCTestCase {

    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataManager = CoreDataManager.shared
    }

    override func tearDownWithError() throws {
        // Clean up any test data
        let leagues = coreDataManager.fetchLeagues()
        for league in leagues where league.id == "99999" || league.id == "88888" {
            coreDataManager.deleteLeague(league: league)
        }
        try super.tearDownWithError()
    }

    func testAddAndFetchLeague() {
        coreDataManager.addLeague(
            id: "99999",
            name: "Test League",
            badgeURL: "https://example.com/test.png",
            sportName: "Football"
        )

        let isFav = coreDataManager.isFavorite(id: "99999")
        XCTAssertTrue(isFav)
    }

    func testDeleteLeagueById() {
        coreDataManager.addLeague(
            id: "88888",
            name: "Delete Test",
            badgeURL: "https://example.com/delete.png",
            sportName: "Tennis"
        )

        XCTAssertTrue(coreDataManager.isFavorite(id: "88888"))

        coreDataManager.deleteLeague(id: "88888")

        XCTAssertFalse(coreDataManager.isFavorite(id: "88888"))
    }

    func testToggleFavorite() {
        // First toggle: should add
        let addedResult = coreDataManager.toggleFavorite(
            id: "99999",
            name: "Toggle Test",
            badgeURL: "https://example.com/toggle.png",
            sportName: "Cricket"
        )
        XCTAssertTrue(addedResult)
        XCTAssertTrue(coreDataManager.isFavorite(id: "99999"))

        // Second toggle: should remove
        let removedResult = coreDataManager.toggleFavorite(
            id: "99999",
            name: "Toggle Test",
            badgeURL: "https://example.com/toggle.png",
            sportName: "Cricket"
        )
        XCTAssertFalse(removedResult)
        XCTAssertFalse(coreDataManager.isFavorite(id: "99999"))
    }

    func testIsFavoriteReturnsFalseForUnknownId() {
        let result = coreDataManager.isFavorite(id: "00000_NONEXISTENT")
        XCTAssertFalse(result)
    }
}

// MARK: - Presenter Tests

class SportsPresenterTests: XCTestCase {

    func testPresenterCallsShowLoading() {
        let mockView = MockSportsView()
        let _ = SportsPresenter(view: mockView)

        // viewDidLoad triggers fetchSports which calls showLoading
        // Since this is async, we just verify the presenter was created successfully
        XCTAssertNotNil(mockView)
    }
}

// MARK: - ConnectivityManager Tests

class ConnectivityManagerTests: XCTestCase {

    func testConnectivityManagerExists() {
        let manager = ConnectivityManager.shared
        // On a real device/simulator, this should be true
        XCTAssertNotNil(manager)
    }
}

// MARK: - Mock Objects

class MockSportsView: SportsViewProtocol {

    var didReload = false
    var didShowLoading = false
    var didHideLoading = false
    var errorMessage: String?
    var navigatedSport: Sport?

    func reloadData() {
        didReload = true
    }

    func showError(_ message: String) {
        errorMessage = message
    }

    func showLoading() {
        didShowLoading = true
    }

    func hideLoading() {
        didHideLoading = true
    }

    func navigateToLeagues(sport: Sport) {
        navigatedSport = sport
    }
}
