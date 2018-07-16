//
//  PlaceDetailsViewTests.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 15/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import XCTest
@testable import PlaceFinder

class PlaceDetailsViewTest: XCTestCase {
    
    var detailsViewUnderTest: PlaceDetailsView!
    
    override func setUp() {
        super.setUp()
        detailsViewUnderTest = Bundle.main.loadNibNamed("PlaceDetailsView", owner: nil, options: nil)?.first! as! PlaceDetailsView
    }
    
    override func tearDown() {
        detailsViewUnderTest = nil
        super.tearDown()
    }
    
    func testInspectables() {
        // Given
        detailsViewUnderTest.layer.masksToBounds = false
        detailsViewUnderTest.layer.cornerRadius = 0.0
        
        // When
        detailsViewUnderTest.masksToBounds = true
        detailsViewUnderTest.cornerRadius = 10
        
        // Then
        XCTAssertTrue(detailsViewUnderTest.layer.masksToBounds)
        XCTAssertEqual(detailsViewUnderTest.layer.cornerRadius, 10)
    }
}
