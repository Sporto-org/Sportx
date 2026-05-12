//
//  TeamDetailsViewController.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    // MARK: - Outlets (connect in XIB)
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var team: Team!
    private var presenter: TeamDetailsPresenterProtocol!

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "TeamDetailsViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = team.team_name ?? "Team Details"
        view.backgroundColor = Theme.backgroundColor

        presenter = TeamDetailsPresenter(view: self, team: team)
        setupTableView()
        setupHeaderStyling()
        presenter.viewDidLoad()
    }

    // MARK: - Setup

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlayerCell")
    }

    private func setupHeaderStyling() {
        teamImageView.contentMode = .scaleAspectFit
        teamImageView.layer.cornerRadius = 50
        teamImageView.clipsToBounds = true

        teamNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        teamNameLabel.textColor = Theme.primaryText
        teamNameLabel.textAlignment = .center

        coachLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        coachLabel.textColor = Theme.secondaryText
        coachLabel.textAlignment = .center
    }
}

// MARK: - UITableView DataSource & Delegate

extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.sectionTitle(for: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPlayers(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)

        let player = presenter.player(at: indexPath)

        var config = cell.defaultContentConfiguration()
        config.text = player.player_name ?? "Unknown"

        // Subtitle with number and rating
        var details: [String] = []
        if let number = player.player_number, !number.isEmpty {
            details.append("#\(number)")
        }
        if let rating = player.player_rating, !rating.isEmpty {
            details.append("Rating: \(rating)")
        }
        if let goals = player.player_goals, !goals.isEmpty, goals != "0" {
            details.append("Goals: \(goals)")
        }
        config.secondaryText = details.joined(separator: " • ")

        config.textProperties.color = Theme.primaryText
        config.secondaryTextProperties.color = Theme.secondaryText

        // Player image
        config.image = UIImage(systemName: "person.circle")
        config.imageProperties.tintColor = Theme.accentColor
        config.imageProperties.maximumSize = CGSize(width: 40, height: 40)

        cell.contentConfiguration = config
        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        header.textLabel?.textColor = Theme.accentColor
    }
}

// MARK: - TeamDetailsViewProtocol

extension TeamDetailsViewController: TeamDetailsViewProtocol {

    func reloadData() {
        tableView.reloadData()
    }

    func displayTeamInfo(name: String, logoURL: String?, coach: String) {
        teamNameLabel.text = name
        coachLabel.text = "Coach: \(coach)"
        teamImageView.loadImage(from: logoURL)
    }
}
