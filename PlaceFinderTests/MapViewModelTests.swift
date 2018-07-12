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
    
    func testNonNilLocationManager() {
        // Given
        viewModelUnderTest.locationManager = CLLocationManager()
        
        // Then
        XCTAssertNotNil(viewModelUnderTest.locationManager)
        XCTAssertNotNil(viewModelUnderTest.locationManager?.delegate)
        
        XCTAssert(viewModelUnderTest.locationManager!.delegate!.isKind(of: MapViewModel.self))
        
        XCTAssertEqual(viewModelUnderTest.locationManager!.desiredAccuracy, kCLLocationAccuracyBest, "Didn't setup accuracy on didSet call")
        XCTAssertEqual(viewModelUnderTest.locationManager!.distanceFilter, 50, "Didn't setup distance filter on didSet call")
    }
    
    func testNilLocationManager() {
        // Given
        viewModelUnderTest.locationManager = nil
        
        //Then
        XCTAssertNil(viewModelUnderTest.locationManager)
        XCTAssertNil(viewModelUnderTest.currentLocation)
        XCTAssertNil(viewModelUnderTest.cameraPosition)
    }
    
    func testDelegateDidUpdateLocations() {
        // Given
        viewModelUnderTest.locationManager = CLLocationManager()
        let locationManager = viewModelUnderTest.locationManager!
        
        let locations: [CLLocation] = [CLLocation(latitude: 10, longitude: 11), CLLocation(latitude: 12, longitude: 13)]
        
        // When
        locationManager.delegate!.locationManager!(locationManager as! CLLocationManager, didUpdateLocations: locations)
        
        // Then
        XCTAssertNotNil(viewModelUnderTest.currentLocation)
        XCTAssertNotNil(viewModelUnderTest.cameraPosition)
        XCTAssertEqual(viewModelUnderTest.cameraPosition!.target.latitude, 12, "Didn't setup camera position latitude correctly")
        XCTAssertEqual(viewModelUnderTest.cameraPosition!.target.longitude, 13, "Didn't setup camera position longitude correctly")
    }
    
    func testRequestAuthorizationForLocationService_NotDetermined() {
        // Given
        let mockLocationManager = MockCLLocationManager()
        MockCLLocationManager.stubbedAuthorizationStatus = .notDetermined
        
        viewModelUnderTest.locationManager = mockLocationManager
        
        // When
        viewModelUnderTest.requestAuthorizationForLocationService()
        
        // Then
        XCTAssert(mockLocationManager.calledRequestAlwaysAuthorization)
        XCTAssertEqual(mockLocationManager.requestAlwaysAuthorizationCallCount, 1)
    }
    
    func testRequestAuthorizationForLocationService_AlwaysAuthorized() {
        // Given
        let mockLocationManager = MockCLLocationManager()
        MockCLLocationManager.stubbedAuthorizationStatus = .authorizedAlways
        
        viewModelUnderTest.locationManager = mockLocationManager
        
        // When
        viewModelUnderTest.requestAuthorizationForLocationService()
        
        // Then
        XCTAssertFalse(mockLocationManager.calledRequestAlwaysAuthorization)
        XCTAssertEqual(mockLocationManager.requestAlwaysAuthorizationCallCount, 0)
    }
    
    func testStartsUpdatingUserLocation_AlwaysAuthorization() {
        // Given
        let mockLocationManager = MockCLLocationManager()
        MockCLLocationManager.stubbedAuthorizationStatus = .authorizedAlways
        
        viewModelUnderTest.locationManager = mockLocationManager
        
        // When
        viewModelUnderTest.startsUpdatingUserLocation()
        
        // Then
        XCTAssert(mockLocationManager.calledStartUpdatingLocation)
        XCTAssertEqual(mockLocationManager.startUpdatingLocationCallCount, 1)
    }
    
    func testStartsUpdatingUserLocation_WhenInUseAuthorization() {
        // Given
        let mockLocationManager = MockCLLocationManager()
        MockCLLocationManager.stubbedAuthorizationStatus = .authorizedWhenInUse
        
        viewModelUnderTest.locationManager = mockLocationManager
        
        // When
        viewModelUnderTest.startsUpdatingUserLocation()
        
        // Then
        XCTAssert(mockLocationManager.calledStartUpdatingLocation)
        XCTAssertEqual(mockLocationManager.startUpdatingLocationCallCount, 1)
    }
    
    func testStartsUpdatingUserLocation_NotDetermined() {
        // Given
        let mockLocationManager = MockCLLocationManager()
        MockCLLocationManager.stubbedAuthorizationStatus = .notDetermined
        
        viewModelUnderTest.locationManager = mockLocationManager
        
        // When
        viewModelUnderTest.startsUpdatingUserLocation()
        
        // Then
        XCTAssertFalse(mockLocationManager.calledStartUpdatingLocation)
        XCTAssertEqual(mockLocationManager.startUpdatingLocationCallCount, 0)
    }
}
