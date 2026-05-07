//
//  CoreDataManager.swift
//  SportX
//
//  Created by Zeiad Mohammed on 07/05/2026.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let appDelegate : AppDelegate
    let context : NSManagedObjectContext
    private init()    {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Add League
    func addLeague(id: String, name: String, badgeURL: String) {
        let newLeague = LeagueDBEntity(context: context)
        newLeague.id = id
        newLeague.name = name
        newLeague.badge = badgeURL
        
        appDelegate.saveContext()
        print("Successfully saved \(name) to Favorites.")
    }
    
    // MARK: - Fetch Leagues
    func fetchLeagues() -> [LeagueDBEntity] {
        let fetchRequest: NSFetchRequest<LeagueDBEntity> = LeagueDBEntity.fetchRequest()
        
        do {
            let leagues = try context.fetch(fetchRequest)
            return leagues
        } catch {
            print("Error fetching favorite leagues: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Delete League
    func deleteLeague(league: LeagueDBEntity) {
        context.delete(league)
        appDelegate.saveContext()
        print("Successfully deleted league from Favorites.")
    }
    
    // MARK: - Check if League is Favorite (Useful for Details Screen)
    func isFavorite(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<LeagueDBEntity> = LeagueDBEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idLeague == %@", id)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking favorite status: \(error.localizedDescription)")
            return false
        }
    }
}
