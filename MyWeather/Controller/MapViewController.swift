//
//  MapViewController.swift
//  MyWeather
//
//  Created by Blake Harrison on 4/12/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: Properties
    let weatherAPI = WeatherAPI()

    //MARK: Outlet
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Methods
    func placePin(latitude: CLLocationDegrees, longitude: CLLocationDegrees, cityName: String) {
        
        let alert = UIAlertController(title: "Bookmark \(cityName)?", message: "It will be listed on your homescreen.", preferredStyle: .alert)

        //User clicks "Yes"
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.weatherAPI.fetchCurrentWeather(latitude: latitude, longitude: longitude, measurmentSystem: UnitOfMeasurment.imperial)
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = cityName
            self.mapView.addAnnotation(annotation)
        }))
        
        //User clicks "No"
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //MARK: Actions
    @IBAction func longPressOnMap(sender: UILongPressGestureRecognizer) {

            if sender.state != UIGestureRecognizer.State.began { return }
            let touchLocation = sender.location(in: self.mapView)
            let locationCoordinate = self.mapView.convert(touchLocation, toCoordinateFrom: self.mapView)

            self.weatherAPI.getCurrentLocationName(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude, measurmentSystem: UnitOfMeasurment.imperial, completion: { (name) in
 
                guard name != "" else {
                    let alert = UIAlertController(title: "No results found", message: "Try another location.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                
                self.placePin(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude, cityName: name)
            })
    }
}
