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

    //MARK: Outlet
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Methods
    func placePin(latitude: CLLocationDegrees, longitude: CLLocationDegrees, cityName: String) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = centerCoordinate
        annotation.title = cityName
        mapView.addAnnotation(annotation)
    }
    
    //MARK: Actions
    @IBAction func longPressOnMap(sender: UILongPressGestureRecognizer) {

        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Error"
                print("Given location is not retrievable. Descripton: \(errorString)")
                return
            }
            
            let cityName = placemark.locality ?? "\(locationCoordinate.latitude), \(locationCoordinate.longitude)"
            
            self.placePin(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude, cityName: cityName)
            
        }
    }
}
