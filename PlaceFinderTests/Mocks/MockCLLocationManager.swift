//
//  MockCLLocationManager.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import CoreLocation
@testable import PlaceFinder

class MockCLLocationManager: LocationManagerType {
    
    var delegate: CLLocationManagerDelegate?
    
    static var stubbedAuthorizationStatus: CLAuthorizationStatus?
    
    var desiredAccuracy: CLLocationAccuracy
    var distanceFilter: CLLocationDistance
    
    init(desiredAccuracy: CLLocationAccuracy, distanceFilter: CLLocationDistance) {
        self.desiredAccuracy = desiredAccuracy
        self.distanceFilter = distanceFilter
    }
    
    convenience init() {
        self.init(desiredAccuracy: kCLLocationAccuracyBest, distanceFilter: 0)
    }
    
    static func authorizationStatus() -> CLAuthorizationStatus {
        return stubbedAuthorizationStatus!
    }
    
    var calledStartUpdatingLocation: Bool = false
    var startUpdatingLocationCallCount: Int = 0
    
    func startUpdatingLocation() {
        calledStartUpdatingLocation = true
        startUpdatingLocationCallCount += 1
    }
    
    var calledRequestAlwaysAuthorization: Bool = false
    var requestAlwaysAuthorizationCallCount: Int = 0
    
    func requestAlwaysAuthorization() {
        calledRequestAlwaysAuthorization = true
        requestAlwaysAuthorizationCallCount += 1
    }
    
    var calledStopUpdatingLocation: Bool = false
    var stopUpdatingLocationCallCount: Int = 0
    
    func stopUpdatingLocation() {
        calledStopUpdatingLocation = true
        stopUpdatingLocationCallCount += 1
    }
}
