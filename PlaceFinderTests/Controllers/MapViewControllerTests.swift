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
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = controllerUnderTest
        
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
    
    func testOnSearchButtonClicked() {
        // Given
        let mockViewModel = MockMapViewModel()
        controllerUnderTest.mapViewModel = mockViewModel
        
        // When
        controllerUnderTest.searchBarSearchButtonClicked(controllerUnderTest.searchController!.searchBar)
        
        // Then
        XCTAssertTrue(controllerUnderTest.activityIndicator.isAnimating)
        XCTAssertTrue(mockViewModel.calledStartsSearchingNearbyPlacesWith)
        XCTAssertEqual(mockViewModel.startsSearchingNearbyPlacesWithCallCount, 1)
    }
    
    func testOnDidLoadMarkers() {
        // Given
        let mockMarkers = [
            GMSMarker(position: CLLocationCoordinate2D(latitude: 10, longitude: 11)),
            GMSMarker(position: CLLocationCoordinate2D(latitude: 12, longitude: 13)),
            GMSMarker(position: CLLocationCoordinate2D(latitude: 14, longitude: 15))
        ]
        
        // When
        controllerUnderTest.didLoadMarkers(mockMarkers)
        
        // Then
        XCTAssertFalse(controllerUnderTest.searchController!.isBeingPresented)
        XCTAssertFalse(controllerUnderTest.activityIndicator.isAnimating)
        
        mockMarkers.forEach { marker in
            XCTAssertEqual(marker.map!, controllerUnderTest.mapView)
        }
    }
    
    func testDidFailToLoadMarkers() {
        // Given
        let mockError = NSError(domain: "Testing error domain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Testing description"])
        
        // When
        controllerUnderTest.didFailToLoadMarkers(with: mockError)
        
        //Then
        XCTAssert(controllerUnderTest.presentedViewController is UIAlertController)
        
        let alertController = controllerUnderTest.presentedViewController! as! UIAlertController
        XCTAssertEqual(alertController.message!, mockError.localizedDescription)
    }
    
    func testPlaceDetailsViewCreationForValidMarker() {
        // Given
        var place = Place()
        place.geometry = Geometry(location: Geometry.Location(latitude: 10, longitude: 11), viewport: nil)
        
        let placeViewModel = PlaceViewModel(model: place)
        
        let validMarker = GMSMarker(position: placeViewModel.location!)
        validMarker.userData = placeViewModel
        
        // When
        let detailsView = controllerUnderTest.mapView(controllerUnderTest.mapView, markerInfoWindow: validMarker)
        
        // Then
        XCTAssertNotNil(detailsView)
    }
    
    func testPlaceDetailsViewForInvalidMarker() {
        // Given
        let invalidMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 10, longitude: 11))
        
        // When
        let detailsView = controllerUnderTest.mapView(controllerUnderTest.mapView, markerInfoWindow: invalidMarker)
        
        // Then
        XCTAssertNil(detailsView)
    }
}
