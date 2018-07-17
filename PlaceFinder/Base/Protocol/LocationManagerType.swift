//
//  LocationManagerType.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import CoreLocation

/**
 Defines a subset of CLLocationManager's interface. Used for mocking location data and status.
 */
protocol LocationManagerType {
    
    var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var distanceFilter: CLLocationDistance { get set }
    
    static func authorizationStatus() -> CLAuthorizationStatus
    
    func startUpdatingLocation()
    func requestAlwaysAuthorization()
    func stopUpdatingLocation()
}
