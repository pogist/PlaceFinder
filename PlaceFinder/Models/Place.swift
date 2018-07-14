//
//  Place.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 12/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation

struct Place: Codable {
    
    var id: String?
    var name: String?
    var placeId: String?
    var icon: String?
    var reference: String?
    var scope: String?
    var types: [String]?
    var vicinity: String?
    
    var geometry: Geometry?
    var plusCode: PlusCode?
    var openingHours: OpeningHours?
    var photos: [Photo]?
    
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case placeId = "place_id"
        case icon
        case reference
        case scope
        case types
        case vicinity
        case geometry
        case plusCode = "plus_code"
        case openingHours = "opening_hours"
        case photos
        case rating
    }
}
