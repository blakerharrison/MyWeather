//
//  ViewController.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/12/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    var userBookmarks = [Bookmark]()
    var weatherAPI = WeatherAPI()
    var selectedIndex = 0
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Create "User" entity if there is none.
        if coreDataManager.numberOfUsers() != nil {
            if coreDataManager.numberOfUsers()! == 0 { coreDataManager.createUser() }
        }
        
        if CoreDataManager().bookmarksArray() != nil { userBookmarks = CoreDataManager().bookmarksArray()! }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        userBookmarks = CoreDataManager().bookmarksArray()!
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let weatherDetailViewController = segue.destination as? WeatherDetailViewController else {
                return
        }
        weatherDetailViewController.selectedBookmark.name = userBookmarks[selectedIndex].name
        weatherDetailViewController.selectedBookmark.id = userBookmarks[selectedIndex].id
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "weatherDetailSegue", sender: self)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            CoreDataManager().deleteBookmark(id: self.userBookmarks[editActionsForRowAt.row].id)
            self.userBookmarks.remove(at: editActionsForRowAt.row)
            self.tableView.reloadData()
        }
        delete.backgroundColor = .red

        return [delete]
    }
    
}

