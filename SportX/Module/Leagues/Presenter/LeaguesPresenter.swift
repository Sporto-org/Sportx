//
//  LeaguesPresenter.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import Foundation

// MARK: - Protocols

protocol LeaguesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfLeagues() -> Int
    func league(at index: Int) -> League
    func didSelectLeague(at index: Int)
}

protocol LeaguesViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func navigateToLeagueDetails(league: League, sportName: String)
}

// MARK: - Presenter

class LeaguesPresenter: LeaguesPresenterProtocol {

    weak var view: LeaguesViewProtocol?
    private var leagues: [League] = []
    private let sport: Sport

    init(view: LeaguesViewProtocol, sport: Sport) {
        self.view = view
        self.sport = sport
    }

    func viewDidLoad() {
        fetchLeagues()
    }

    func numberOfLeagues() -> Int {
        return leagues.count
    }

    func league(at index: Int) -> League {
        return leagues[index]
    }

    func didSelectLeague(at index: Int) {
        let league = leagues[index]
        let sportName = sport.sport_name ?? ""
        view?.navigateToLeagueDetails(league: league, sportName: sportName)
    }

    // MARK: - Private

    private func fetchLeagues() {
        guard let sportName = sport.sport_name else { return }

        view?.showLoading()

        Task { @MainActor in
            do {
                let result = try await NetworkManager.shared.fetchLeagues(sport: sportName)
                self.leagues = result
                self.view?.reloadData()
            } catch {
                self.view?.showError(error.localizedDescription)
            }
            self.view?.hideLoading()
        }
    }
}
