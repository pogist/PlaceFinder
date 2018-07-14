//
//  Geometry.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 12/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation

struct Geometry: Codable {
    
    struct Location: Codable {
        var latitude: Double?
        var longitude: Double?
        
        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lng"
        }
    }
    
    struct ViewPort: Codable {
        var northeast: Location?
        var southwest: Location?
    }
    
    var location: Location?
    var viewport: ViewPort?
}
