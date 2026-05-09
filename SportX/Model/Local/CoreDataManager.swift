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
    func addLeague(id: String, name: String, badgeURL: String, sportName: String) {
        let newLeague = LeagueDBEntity(context: context)
        newLeague.id = id
        newLeague.name = name
        newLeague.badge = badgeURL
        newLeague.sportName = sportName
        
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
    
    // MARK: - Delete League by ID
    func deleteLeague(id: String) {
        let fetchRequest: NSFetchRequest<LeagueDBEntity> = LeagueDBEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            for league in results {
                context.delete(league)
            }
            appDelegate.saveContext()
        } catch {
            print("Error deleting league by ID: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Check if League is Favorite (Useful for Details Screen)
    func isFavorite(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<LeagueDBEntity> = LeagueDBEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking favorite status: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Toggle Favorite
    func toggleFavorite(id: String, name: String, badgeURL: String, sportName: String) -> Bool {
        if isFavorite(id: id) {
            deleteLeague(id: id)
            return false
        } else {
            addLeague(id: id, name: name, badgeURL: badgeURL, sportName: sportName)
            return true
        }
    }
}
