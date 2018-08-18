//
//  MapViewControllerUITests.swift
//  PlaceFinderUITests
//
//  Created by Murilo da Paixão on 17/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import XCTest

class MapViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testPlaceSearch() {
        app.launch()
        
        let searchBar = app.navigationBars["PlaceFinder.MapView"].searchFields["Search for a type of place. Eg: drugstore"]
        
        searchBar.tap()
        searchBar.typeText("drugstore")
        
        app.buttons["Search"].tap()
        
        let activityIndicator = app.activityIndicators["In progress"]
        XCTAssertTrue(activityIndicator.exists)
        
        let activityIndicatorDisappear = NSPredicate(format: "exists == 0")
        expectation(for: activityIndicatorDisappear, evaluatedWith: activityIndicator, handler: nil)
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("\(error)")
            }
            
            let alerts = self.app.alerts.count
            XCTAssertEqual(alerts, 0)
        }
    }
}
