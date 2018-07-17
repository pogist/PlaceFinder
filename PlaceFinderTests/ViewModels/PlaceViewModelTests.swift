//
//  PlaceViewModelTests.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 15/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import XCTest
import Moya
import PromiseKit
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
    
    func testPlacePhotoReferenceGetting() {
        // Given
        var place = Place()
        place.photos = [Photo(height: nil, width: nil, reference: "Testing reference", htmlAttributions: nil)]
        
        let viewModel = PlaceViewModel(model: place)
        
        // When
        let photoReference = viewModel.placePhotoReference
        
        // Then
        XCTAssertNotNil(photoReference)
        XCTAssertEqual(photoReference!, "Testing reference")
    }
    
    func testPhotoLoading() {
        // Given
        let mockProvider = MoyaProvider<PlacesAPI>(stubClosure: MoyaProvider.immediatelyStub)
        
        var mockPlace = Place()
        var mockPhoto = Photo()
        
        mockPhoto.reference = "Testing reference"
        mockPlace.photos = [mockPhoto]
        
        var placeViewModelUnderTest = PlaceViewModel(model: mockPlace)
        placeViewModelUnderTest.apiProvider = mockProvider
        
        let validPhotoExpectation = expectation(description: "View model must have a valid photo.")
        
        // When
        placeViewModelUnderTest.loadPhoto().done { newPlaceViewModel in
            if newPlaceViewModel.photo != nil {
                validPhotoExpectation.fulfill()
            }
        }
        .catch { error in
            XCTFail((error as NSError).debugDescription)
        }
        
        // Then
        wait(for: [validPhotoExpectation], timeout: 2)
    }
}
