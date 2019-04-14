//
//  CoreDataManager.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/14/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import UIKit
import CoreData

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
    
    //MARK: Read
    func numberOfUsers()-> Int? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let user = try! managedContext.fetch(userFetch)

        return user.count
    }
    
    //MARK: Delete
    func resetAllRecords(entity: String) {

        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error.")
        }
    }
}
