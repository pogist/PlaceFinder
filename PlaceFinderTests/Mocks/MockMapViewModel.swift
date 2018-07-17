//
//  MockMapViewModel.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 17/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import GoogleMaps
@testable import PlaceFinder

class MockMapViewModel: MapViewModelType {
    
    weak var delegate: MapViewModelDelegate?
    var locationManager: LocationManagerType?
    
    var calledStartsSearchingNearbyPlacesWith: Bool = false
    var startsSearchingNearbyPlacesWithCallCount: Int = 0
    
    func requestAuthorizationForLocationService() {}
    
    func startsSearchingNearbyPlacesWith(keyword: String, quantity: Int) {
        calledStartsSearchingNearbyPlacesWith = true
        startsSearchingNearbyPlacesWithCallCount += 1
    }
}
