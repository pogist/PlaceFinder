//
//  MapViewModelTests.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import XCTest
import CoreLocation
@testable import PlaceFinder

class MapViewModelTests: XCTestCase {
    
    var viewModelUnderTest: MapViewModel!
    
    override func setUp() {
        super.setUp()
        viewModelUnderTest = MapViewModel()
    }
    
    override func tearDown() {
        viewModelUnderTest = nil
        super.tearDown()
    }
    
    func testNonNilCameraPosition() {
        // Given
        viewModelUnderTest.currentLocation = CLLocation(latitude: 10, longitude: 11)
        
        // When
        let cameraPosition = viewModelUnderTest.cameraPosition
        
        // Then
        XCTAssertNotNil(cameraPosition)
        XCTAssertEqual(cameraPosition!.target.latitude, 10)
        XCTAssertEqual(cameraPosition!.target.longitude, 11)
    }
    
    func testNilCameraPosition() {
        // Given
        viewModelUnderTest.currentLocation = nil
        
        // When
        let cameraPosition = viewModelUnderTest.cameraPosition
        
        // Then
        XCTAssertNil(cameraPosition)
    }
}
