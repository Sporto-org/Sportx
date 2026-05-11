//
//  SportCollectionViewCell.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets (connect in XIB)
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Card styling
        containerView.layer.cornerRadius = Theme.cornerRadius
        containerView.clipsToBounds = true
        containerView.backgroundColor = Theme.secondaryBackground

        // Shadow on the cell itself
        Theme.applyShadow(to: self)
        self.layer.cornerRadius = Theme.cornerRadius

        // Image styling
        sportImageView.contentMode = .scaleAspectFit
        sportImageView.tintColor = Theme.accentColor

        // Label styling
        sportNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        sportNameLabel.textColor = Theme.primaryText
        sportNameLabel.textAlignment = .center
    }

    func configure(with sport: Sport) {
        sportNameLabel.text = sport.sport_name ?? "Unknown"

        // Use SF Symbol based on sport name (since API has no /sports/ endpoint)
        if let iconURL = sport.sport_icon {
            sportImageView.loadImage(from: iconURL)
        } else {
            let symbolName = Self.sfSymbol(for: sport.sport_name ?? "")
            let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
            sportImageView.image = UIImage(systemName: symbolName, withConfiguration: config)
        }
    }

    private static func sfSymbol(for sportName: String) -> String {
        switch sportName.lowercased() {
        case "football":    return "soccerball"
        case "basketball":  return "basketball"
        case "cricket":     return "figure.cricket"
        case "tennis":      return "tennisball"
        case "handball":    return "figure.handball"
        default:            return "trophy"
        }
    }
}
