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
    
    //MARK: Actions
    @IBAction func longPressOnMap(sender: UILongPressGestureRecognizer) {
        print("Long press gesture accepted")
    }
}
