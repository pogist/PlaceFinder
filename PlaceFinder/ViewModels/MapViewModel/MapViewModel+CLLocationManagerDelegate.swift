//
//  MapViewModel+CLLocationManagerDelegate.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import CoreLocation

extension MapViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
        self.delegate?.didUpdateCameraPosition(cameraPosition)
    }
}
