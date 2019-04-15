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
    var currentForcast = Forcast(name: "", id: 0, temp: 0.0, humidity: 0, windSpeed: 0.0, windDeg: 0, rain: 0.0, date: 0)
    let date = Date()
    
    //MARK: Outlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var todaysDateLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentRainChancesLabel: UILabel!
    @IBOutlet weak var currentWindInformationLabel: UILabel!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoadForcast(_:)), name: .CurrentWeatherFetched, object: nil)
        locationNameLabel.text = selectedBookmark.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        weatherAPI.fetchCurrentWeatherByID(id: selectedBookmark.id, measurmentSystem: UnitOfMeasurment.imperial)
        
    }
    
    //MARK: Methods
    @objc func LoadForcast(_ notification: Notification) {

        let windDirection = self.weatherAPI.currentForcast.windDeg.degreesToWindDirection
        let dateString = self.weatherAPI.currentForcast.date.unixTimestampToMonthAndDayString
        
        DispatchQueue.main.async {
            self.currentTemperatureLabel.text = String(Int(self.weatherAPI.currentForcast.temp)) + "°"
            self.todaysDateLabel.text = dateString
            self.currentHumidityLabel.text = String(self.weatherAPI.currentForcast.humidity) + "%"
            self.currentRainChancesLabel.text = String(self.weatherAPI.currentForcast.rain) + " mm"
            self.currentWindInformationLabel.text = windDirection + " " + String(Int(self.weatherAPI.currentForcast.windSpeed)) + " mph"
        }
    }

}

extension Notification.Name {
    static let CurrentWeatherFetched = NSNotification.Name("CurrentWeatherFetched")
}

