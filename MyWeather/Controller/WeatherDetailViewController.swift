//
//  WeatherDetailViewController.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/14/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    //MARK: Properties
    let weatherAPI = WeatherAPI()
    var selectedBookmark = Bookmark(name: "", id: 0)
    var currentForcast = Forcast(name: "", id: 0, temp: 0.0, humidity: 0, windSpeed: 0.0, windDeg: 0, rain: 0.0)
    
    //MARK: Outlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var todaysDateLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentRainChancesLabel: UILabel!
    @IBOutlet weak var currentWindInformationLabel: UILabel!
    
    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        weatherAPI.fetchCurrentWeatherByID(id: selectedBookmark.id, measurmentSystem: UnitOfMeasurment.imperial)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationNameLabel.text = selectedBookmark.name
        print("THIS IS THE ID - \(selectedBookmark.id)")
        
    }

}
