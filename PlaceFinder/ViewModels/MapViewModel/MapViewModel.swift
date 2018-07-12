//
//  MapViewModel.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

final class MapViewModel: NSObject {

    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    
    /**
     Map's target position based on user's current location.
     */
    var cameraPosition: GMSCameraPosition? {
        get {
            guard let currentLocation = currentLocation else {
                return nil
            }
            
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            
            return GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoomLevel)
        }
    }
    
    var locationManager: CLLocationManager? {
        didSet {
            guard let locationManager = locationManager else {
                return
            }
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 50
            locationManager.delegate = self
        }
    }
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
    }
    
    deinit {
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
}
