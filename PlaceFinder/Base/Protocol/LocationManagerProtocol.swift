//
//  LocationManagerProtocol.swift
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
protocol LocationManagerProtocol {
    
    static func authorizationStatus() -> CLAuthorizationStatus
    func startUpdatingLocation()
}
