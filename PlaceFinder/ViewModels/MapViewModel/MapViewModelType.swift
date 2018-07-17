//
//  MapViewModelType.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 17/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import GoogleMaps

/**
 This protocol represents a subset of MapViewModel's interface. Use it to mock an MapViewModel object.
 */
protocol MapViewModelType {
    
    var delegate: MapViewModelDelegate? { get set }
    var locationManager: LocationManagerProtocol? { get set }
    
    func requestAuthorizationForLocationService()
    func startsSearchingNearbyPlacesWith(keyword: String, quantity: Int)
}
