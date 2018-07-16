//
//  PlaceViewModelTests.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 15/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import XCTest
@testable import PlaceFinder

class PlaceViewModelTests: XCTestCase {
    
    func testPlaceNameGetting() {
        // Given
        var place = Place()
        place.name = "Testing name"
        
        let viewModel = PlaceViewModel(model: place)
        
        // Then
        XCTAssertNotNil(viewModel.placeName)
        XCTAssertEqual(viewModel.placeName!, "Testing name")
    }
    
    func testPlaceAddressGetting() {
        // Given
        var place = Place()
        place.vicinity = "Testing address"
        
        let viewModel = PlaceViewModel(model: place)
        
        // Then
        XCTAssertNotNil(viewModel.placeAddress)
        XCTAssertEqual(viewModel.placeAddress!, "Testing address")
    }
    
    func testPlaceLocationGetting() {
        // Given
        var place = Place()
        place.geometry = Geometry(location: Geometry.Location(latitude: 10, longitude: 11), viewport: nil)
        
        let viewModel = PlaceViewModel(model: place)
        
        // When
        let location = viewModel.location
        
        // Then
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.latitude, 10)
        XCTAssertEqual(location!.longitude, 11)
    }
    
    func testPlaceNilLocationGetting() {
        // Given
        var place = Place()
        place.geometry = Geometry(location: nil, viewport: nil)
        
        let viewModel = PlaceViewModel(model: place)
        
        // When
        let location = viewModel.location
        
        // Then
        XCTAssertNil(location)
    }
}
