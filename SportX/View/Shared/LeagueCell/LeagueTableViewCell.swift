//
//  LeagueTableViewCell.swift
//  SportX
//
//  Created by Zeiad Mohammed on 07/05/2026.
//

import UIKit
	
class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Fulfill the SRS requirement: "The league badge (strBadge) (Must be circular)"
        leagueImageView.layer.cornerRadius = leagueImageView.frame.size.width / 2
        leagueImageView.clipsToBounds = true
        leagueImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
