//
//  SportsPresenter.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import Foundation

// MARK: - Protocols

protocol SportsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfSports() -> Int
    func sport(at index: Int) -> Sport
    func didSelectSport(at index: Int)
}

protocol SportsViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func navigateToLeagues(sport: Sport)
}

// MARK: - Presenter

class SportsPresenter: SportsPresenterProtocol {

    weak var view: SportsViewProtocol?
    private var sports: [Sport] = []

    // The allsportsapi.com API does NOT have a /sports/ endpoint.
    // Each sport is a separate API path: /football/, /basketball/, etc.
    // We use a hardcoded list matching the API's available sports.
    private static let availableSports: [Sport] = [
        Sport(sport_key: 1, sport_name: "Football",          sport_icon: nil),
        Sport(sport_key: 2, sport_name: "Basketball",        sport_icon: nil),
        Sport(sport_key: 3, sport_name: "Cricket",           sport_icon: nil),
        Sport(sport_key: 4, sport_name: "Tennis",            sport_icon: nil),
        Sport(sport_key: 5, sport_name: "Handball",          sport_icon: nil),
    ]

    init(view: SportsViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        loadSports()
    }

    func numberOfSports() -> Int {
        return sports.count
    }

    func sport(at index: Int) -> Sport {
        return sports[index]
    }

    func didSelectSport(at index: Int) {
        let sport = sports[index]
        view?.navigateToLeagues(sport: sport)
    }

    // MARK: - Private

    private func loadSports() {
        view?.showLoading()
        sports = SportsPresenter.availableSports
        view?.reloadData()
        view?.hideLoading()
    }
}

	
