//
//  LatestEventCell.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import UIKit

class LatestEventCell: UICollectionViewCell {

    // MARK: - Outlets (connect in XIB)
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = Theme.cornerRadius
        containerView.clipsToBounds = true
        containerView.backgroundColor = Theme.secondaryBackground

        Theme.applyShadow(to: self)
        self.layer.cornerRadius = Theme.cornerRadius

        homeTeamImageView.contentMode = .scaleAspectFit
        awayTeamImageView.contentMode = .scaleAspectFit

        homeTeamLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        homeTeamLabel.textColor = Theme.primaryText
        homeTeamLabel.textAlignment = .center
        homeTeamLabel.numberOfLines = 2

        awayTeamLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        awayTeamLabel.textColor = Theme.primaryText
        awayTeamLabel.textAlignment = .center
        awayTeamLabel.numberOfLines = 2

        scoreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        scoreLabel.textColor = Theme.accentColor
        scoreLabel.textAlignment = .center

        dateLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        dateLabel.textColor = Theme.secondaryText
        dateLabel.textAlignment = .center
    }

    func configure(with fixture: Fixture) {
        homeTeamLabel.text = fixture.event_home_team ?? "TBD"
        awayTeamLabel.text = fixture.event_away_team ?? "TBD"
        scoreLabel.text = fixture.event_final_result ?? "-"
        dateLabel.text = fixture.event_date ?? ""

        homeTeamImageView.loadImage(from: fixture.home_team_logo)
        awayTeamImageView.loadImage(from: fixture.away_team_logo)
    }
}
