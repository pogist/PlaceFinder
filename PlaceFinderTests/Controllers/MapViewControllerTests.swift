//
//  MapViewControllerTests.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 12/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import XCTest
import GoogleMaps
@testable import PlaceFinder

class MapViewControllerTests: XCTestCase {
    
    var controllerUnderTest: MapViewController!
    
    override func setUp() {
        super.setUp()
        
        controllerUnderTest = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mapViewController") as! MapViewController
        _ = controllerUnderTest.view
    }
    
    override func tearDown() {
        controllerUnderTest = nil
        super.tearDown()
    }
    
    func testDidUpdateWithNilCameraPosition() {
        // Given
        let cameraBeforeTheUpdate = controllerUnderTest.mapView.camera
        
        // When
        controllerUnderTest.didUpdateCameraPosition(nil)
        
        // Then
        let cameraAfterTheUpdate = controllerUnderTest.mapView.camera
        XCTAssertEqual(cameraBeforeTheUpdate, cameraAfterTheUpdate)
    }
}
