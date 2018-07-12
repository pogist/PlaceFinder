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
    
    weak var delegate: MapViewModelDelegate?

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
    
    var locationManager: LocationManagerProtocol? {
        didSet {
            guard var locationManager = locationManager else {
                return
            }
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 50
            locationManager.delegate = self
        }
    }
    
    /**
     When using the app in production this method must be called before startsUpdatingUserLocation().
     */
    func requestAuthorizationForLocationService() {
        guard let locationManager = self.locationManager else {
            return
        }
        
        if type(of: locationManager).authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    /**
     Calls CLLocationManager.startUpdatingLocation() if the location service is enabled in the device.
     */
    func startsUpdatingUserLocation() {
        guard let locationManager = self.locationManager else {
            return
        }
        
        switch type(of: locationManager).authorizationStatus() {
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        
        default:
            break
        }
    }
    
    deinit {
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
}
