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
}
