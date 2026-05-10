//
//  FavouritesViewController.swift
//  SportX
//
//  Created by Zeiad Mohammed on 07/05/2026.
//

import UIKit

class FavouritesViewController: UIViewController {

    // MARK: - Properties
    private var tableView: UITableView!
    private var presenter: FavouritesPresenterProtocol!

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No favourite leagues yet.\nTap the ❤️ on a league to add it!"
        label.textColor = Theme.secondaryText
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Favourites"
        view.backgroundColor = Theme.backgroundColor

        presenter = FavouritesPresenter(view: self)
        setupTableView()
        setupEmptyLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    // MARK: - Setup

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear

        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeagueCell")

        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}

// MARK: - TableView DataSource & Delegate
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfLeagues()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell

        let league = presenter.league(at: indexPath.row)
        cell.leagueTitleLabel.text = league.name ?? "Unknown"
        cell.leagueImageView.loadImage(from: league.badge)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectLeague(at: indexPath.row)
    }

    // Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteLeague(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - FavouritesViewProtocol
extension FavouritesViewController: FavouritesViewProtocol {

    func reloadData() {
        tableView.reloadData()
    }

    func showOfflineAlert() {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet connection and try again.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func navigateToLeagueDetails(leagueId: Int, leagueName: String, leagueLogo: String, sportName: String) {
        let detailsVC = LeagueDetailsViewController()

        // Create a League object from the stored data
        let league = League(
            league_key: leagueId,
            league_name: leagueName,
            country_name: nil,
            league_logo: leagueLogo
        )

        detailsVC.league = league
        detailsVC.sportName = sportName
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    func showEmptyState(_ show: Bool) {
        emptyLabel.isHidden = !show
        tableView.isHidden = show
    }
}
