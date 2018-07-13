//
//  PlacesAPITests.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 12/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import XCTest
import Moya
import Alamofire
import CoreLocation
@testable import PlaceFinder

class PlacesAPITests: XCTestCase {
    
    var targetUnderTest: PlacesAPI!
    
    override func setUp() {
        super.setUp()
        targetUnderTest = PlacesAPI.searchNearestPlacesBy(keyword: "gas-station", location: CLLocationCoordinate2D(latitude: 10, longitude: 11))
    }
    
    override func tearDown() {
        targetUnderTest = nil
        super.tearDown()
    }
    
    func testBaseURL() {
        XCTAssertEqual(targetUnderTest.baseURL, URL(string: "https://maps.googleapis.com/maps/api/place/")!)
    }
    
    func testPath() {
        XCTAssertEqual(targetUnderTest.path, "nearbysearch/json")
    }
    
    func testMethod() {
        XCTAssertEqual(targetUnderTest.method, Moya.Method.get)
    }
    
    func testTask() {
        switch targetUnderTest.task {
            
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            XCTAssert(encoding is URLEncoding)
            
            XCTAssertFalse(parameters.isEmpty)
            
            XCTAssertNotNil(parameters["key"])
            XCTAssertNotNil(parameters["location"])
            XCTAssertNotNil(parameters["keyword"])
            XCTAssertNotNil(parameters["language"])
            XCTAssertNotNil(parameters["rankby"])
            
        default:
            XCTFail("Task: \(targetUnderTest.task) is not in the correct form.")
        }
    }
    
    func testHeaders() {
        XCTAssertNil(targetUnderTest.headers)
    }
    
    func testSampleData() {
        // Given
        let sampleData = targetUnderTest.sampleData
        
        // When
        let sampleDataAsString = String(data: sampleData, encoding: .utf8)
        
        // Then
        XCTAssertNotNil(sampleDataAsString)
    }
}
