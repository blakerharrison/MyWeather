//
//  CoreDataManager.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/14/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import UIKit
import CoreData

let coreDataManager = CoreDataManager()

class CoreDataManager {
    
    //MARK: Create
    func createUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue("imperial", forKey: "preferredUnit")
        
        //Save
        do {
            try managedContext.save()
            print("User entity saved.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveBookmarkedLocation(name: String, id: Int) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let user = try! managedContext.fetch(userFetch)
        
        let theUser: User = user.first as! User
        
        let theLocation = BookmarkedLocation(context: managedContext)
        theLocation.id = Int64(id)
        theLocation.name = name
        
        theUser.addToBookmarkedLocations(theLocation)
        
        //Save
        do {
            try managedContext.save()
            print("Bookmark saved")
        } catch {
            print(error)
        }
    }
    
    //MARK: Read
    func readBookmarks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let user = try! managedContext.fetch(userFetch)
        
        let theUser: User = user.first as! User
        
        for item in theUser.bookmarkedLocations!.allObjects as! [BookmarkedLocation] {
            
            if item.name != nil { print(item.name!) }

        }
    }
    
    func bookmarksArray()->[Bookmark]? {
        var bookmarks = [Bookmark]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let user = try! managedContext.fetch(userFetch)
        
        let theUser: User = user.first as! User
        
        for item in theUser.bookmarkedLocations!.allObjects as! [BookmarkedLocation] {

            bookmarks.append(Bookmark(name: item.name!, id: Int(item.id)))
            
        }
        
       let sortedBookmarks = bookmarks.sorted(by: { $0.name < $1.name })
        
        return sortedBookmarks
    }
    
    func numberOfUsers()-> Int? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let user = try! managedContext.fetch(userFetch)

        return user.count
    }

    //MARK: Delete
    func resetAllRecords(entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There was an error.")
        }
    }
    
    func deleteBookmark(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        
        let bookmarkedLocationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BookmarkedLocation")
        
        bookmarkedLocationFetch.predicate = predicate

        do {
            let location = try managedContext.fetch(bookmarkedLocationFetch) as! [NSManagedObject]
            managedContext.delete(location[0])
            try managedContext.save()

            print("Deleted")
            
        } catch {
            print(error)
        }
    }

}
