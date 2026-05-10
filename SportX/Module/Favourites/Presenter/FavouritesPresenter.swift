//
//  FavouritesPresenter.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import Foundation

// MARK: - Protocols

protocol FavouritesPresenterProtocol: AnyObject {
    func viewWillAppear()
    func numberOfLeagues() -> Int
    func league(at index: Int) -> LeagueDBEntity
    func didSelectLeague(at index: Int)
    func deleteLeague(at index: Int)
}

protocol FavouritesViewProtocol: AnyObject {
    func reloadData()
    func showOfflineAlert()
    func navigateToLeagueDetails(leagueId: Int, leagueName: String, leagueLogo: String, sportName: String)
    func showEmptyState(_ show: Bool)
}

// MARK: - Presenter

class FavouritesPresenter: FavouritesPresenterProtocol {

    weak var view: FavouritesViewProtocol?
    private var leagues: [LeagueDBEntity] = []

    init(view: FavouritesViewProtocol) {
        self.view = view
    }

    func viewWillAppear() {
        fetchFavourites()
    }

    func numberOfLeagues() -> Int {
        return leagues.count
    }

    func league(at index: Int) -> LeagueDBEntity {
        return leagues[index]
    }

    func didSelectLeague(at index: Int) {
        // Check connectivity before navigating
        guard ConnectivityManager.shared.isConnected else {
            view?.showOfflineAlert()
            return
        }

        let league = leagues[index]
        view?.navigateToLeagueDetails(
            leagueId: Int(league.id ?? "0") ?? 0,
            leagueName: league.name ?? "",
            leagueLogo: league.badge ?? "",
            sportName: league.sportName ?? ""
        )
    }

    func deleteLeague(at index: Int) {
        let league = leagues[index]
        CoreDataManager.shared.deleteLeague(league: league)
        leagues.remove(at: index)
        view?.reloadData()
        view?.showEmptyState(leagues.isEmpty)
    }

    // MARK: - Private

    private func fetchFavourites() {
        leagues = CoreDataManager.shared.fetchLeagues()
        view?.reloadData()
        view?.showEmptyState(leagues.isEmpty)
    }
}
