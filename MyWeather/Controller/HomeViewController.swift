//
//  ViewController.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/12/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: Properties
    let coreDataManager = CoreDataManager()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        coreDataManager.resetAllRecords(entity: "User")
        
        if coreDataManager.numberOfUsers() != nil {
            if coreDataManager.numberOfUsers()! == 0 { coreDataManager.createUser() }
        }

    }
    
}

