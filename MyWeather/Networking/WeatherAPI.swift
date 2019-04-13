//
//  WeatherAPI.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/12/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherAPI {
    
    //Mark: Properties
    fileprivate let apiKey = "7d31e50bac4b48240997df9bdbbbafc0"
    
    //MARK: GET Request
    func fetchCurrentWeather(latitude: Double, longitude: Double, measurmentSystem: String) {
        
        guard let url = weatherURL(latitude: String(latitude), longitude: String(longitude), measurmentSystem: measurmentSystem) else {
            print("Url cannot be created.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard data != nil else {
                print("Data could not be created")
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode != 404 else {
                    print("Page not found")
                    return
                }
                guard httpResponse.statusCode != 400 else {
                    print("Bad request")
                    return
                }
            }
            
            print(data!)
            
            let json = JSON(data!)
            
            print(json["name"].string!)
            print(json["id"].int!)
            print(json["main"]["temp"].float!)
            print(json["main"]["humidity"].int!)
            print(json["wind"]["speed"].float!)
            print(json["wind"]["deg"].int!)
            print(json["rain"]["1h"].float ?? 0.0)
            
        }
        task.resume()
    }
    
    //MARK: Methods
    func weatherURL(latitude: String, longitude: String, measurmentSystem: String)-> URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        
        let queryLatitude = URLQueryItem(name: "lat", value: latitude)
        let queryLongitude = URLQueryItem(name: "lon", value: longitude)
        let queryAppId = URLQueryItem(name: "appid", value: apiKey)
        let queryUnits = URLQueryItem(name: "units", value: measurmentSystem)
        
        components.queryItems = [queryLatitude, queryLongitude, queryAppId, queryUnits]

        return components.url
    }
}
