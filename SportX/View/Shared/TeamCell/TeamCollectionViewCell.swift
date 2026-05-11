//
//  TeamCollectionViewCell.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets (connect in XIB)
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = Theme.cornerRadius
        containerView.clipsToBounds = true
        containerView.backgroundColor = Theme.secondaryBackground

        // Circular team logo
        teamImageView.contentMode = .scaleAspectFit
        teamImageView.layer.cornerRadius = 35
        teamImageView.clipsToBounds = true

        teamNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        teamNameLabel.textColor = Theme.primaryText
        teamNameLabel.textAlignment = .center
        teamNameLabel.numberOfLines = 2
    }

    func configure(with team: Team) {
        teamNameLabel.text = team.team_name ?? "Unknown"
        teamImageView.loadImage(from: team.team_logo)
    }
}
