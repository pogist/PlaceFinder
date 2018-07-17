//
//  PlacesPhotoAPITests.swift
//  PlaceFinderTests
//
//  Created by Murilo da Paixão on 16/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import XCTest
import Moya
@testable import PlaceFinder

class PlacesPhotoAPITests: XCTestCase {
    
    var targetUnderTest: PlacesAPI!
    var targetUnderTestProvider: MoyaProvider<PlacesAPI>!
    
    override func setUp() {
        super.setUp()
        targetUnderTest = PlacesAPI.photo(reference: "Testing reference", size: CGSize(width: 250, height: 150))
        targetUnderTestProvider = MoyaProvider<PlacesAPI>(stubClosure: MoyaProvider.immediatelyStub)
    }
    
    override func tearDown() {
        targetUnderTest = nil
        targetUnderTestProvider = nil
        super.tearDown()
    }
    
    func testPathGetting() {
        XCTAssertEqual(targetUnderTest.path, "photo")
    }
    
    func testTask() {
        switch targetUnderTest.task {
            
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            XCTAssert(encoding is URLEncoding)
            
            XCTAssertFalse(parameters.isEmpty)
            
            XCTAssertNotNil(parameters["key"])
            XCTAssertNotNil(parameters["photoreference"])
            XCTAssertNotNil(parameters["maxwidth"])
            XCTAssertNotNil(parameters["maxheight"])
            
        default:
            XCTFail("Task: \(targetUnderTest.task) is not in the correct form.")
        }
    }
    
    // Parses a local image. So, test time is constant and predictable.
    func testResultParsing() {
        // Given
        let validImageExpectation = expectation(description: "Response data must be a valid image data")
        let correctImageExpectation = expectation(description: "Parsed image must be equal to actual image")
        
        // When
        targetUnderTestProvider.request(targetUnderTest) { result in
            switch result {
                
            case .success(let response):
                let imageData = response.data
                let image = UIImage(data: imageData)
                
                if image != nil {
                    validImageExpectation.fulfill()
                }
                
                if imageData == UIImageJPEGRepresentation(UIImage(named: "pharmacy-testing-image")!, 1.0) {
                    correctImageExpectation.fulfill()
                }
                
            case .failure(let error as NSError):
                XCTFail(error.debugDescription)
            }
        }
        
        // Then
        wait(for: [validImageExpectation, correctImageExpectation], timeout: 2)
    }

    // Downloads a real image from places API.
    // Since this test is making a real API call, it is completely unpredictable and may fail in the future.
    func testPhotoDownloading() {
        // Given
        let realProvider = MoyaProvider<PlacesAPI>()
        let validImageExpectation = expectation(description: "Response data must be a valid image data")
        let realPhotoReference = "CmRaAAAAfu2kJIj0PQQFCJo4KOZhndSBMkG3BfeXSIOTPfMPeflwA6gntf52DNvatlWijdA3_Lub7DXZ7-4xWpVogNcVXiFz_PsSjBU6FSfTwiJ0Be-7nf323tqYUdQ_NV0OiTajEhBeuSNFH7z5SNpIBuJQ2u0bGhQpsEQSRLpZsnKFL4jLj_DW8dvzNA"
        
        // When
        realProvider.request(.photo(reference: realPhotoReference, size: CGSize(width: 250, height: 150)))  { result in
            switch result {
                
            case .success(let response):
                let image = UIImage(data: response.data)
                
                if image != nil {
                    validImageExpectation.fulfill()
                }
                
            case .failure(let error as NSError):
                XCTFail(error.debugDescription)
            }
        }
        
        wait(for: [validImageExpectation], timeout: 5)
    }
}
