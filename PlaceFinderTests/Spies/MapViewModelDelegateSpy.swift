//
//  MapViewModelDelegateSpy.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 17/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import XCTest
import GoogleMaps
@testable import PlaceFinder

class MapViewModelDelegateSpy: MapViewModelDelegate {
    
    var result: [GMSMarker]?
    var completionExpectation: XCTestExpectation?
    
    func didLoadMarkers(_ markers: [GMSMarker]) {
        guard let completionExpectation = completionExpectation else {
            XCTFail("MapViewModelDelegateSpy was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.result = markers
        completionExpectation.fulfill()
    }
    
    func didFailToLoadMarkers(with error: Error) {}
    func didUpdateCameraPosition(_ cameraPosition: GMSCameraPosition?) {}
}
