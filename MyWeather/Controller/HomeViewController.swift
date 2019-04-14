//
//  ViewController.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/12/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    
    //MARK: Properties
    var userBookmarks = [Bookmark]()

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        coreDataManager.resetAllRecords(entity: "User")
        
        userBookmarks.append(Bookmark(name: "Ogallala", id: 5698040))
        userBookmarks.append(Bookmark(name: "Clinton County", id: 4989135))
        userBookmarks.append(Bookmark(name: "Amarillo", id: 5516233))
        
        //Create "User" entity if there is none.
        if coreDataManager.numberOfUsers() != nil {
            if coreDataManager.numberOfUsers()! == 0 { coreDataManager.createUser() }
        }
        
        coreDataManager.readBookmarks()
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel!.text = userBookmarks[indexPath.row].name
        
        return cell
    }
    
}

