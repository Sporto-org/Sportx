//
//  FavouritesViewController.swift
//  SportX
//
//  Created by Zeiad Mohammed on 07/05/2026.
//

import UIKit

class FavouritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        self.navigationItem.title = "Favourites"

        let nib = UINib(nibName: "FavouritesViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeagueCell")
    
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        }
}

// MARK: - TableView DataSource & Delegate
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        
        cell.leagueTitleLabel.text = "Implement Cell Data"
        
        // Note: You will use AlamofireImage/Kingfisher/SDWebImage to load the strBadge URL here later
        // cell.leagueImageView.image = UIImage(named: "placeholder_badge")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Fulfill the SRS requirement: "If the user is online and clicked at any row, it will direct him to the League Details ViewController"
    }
}
