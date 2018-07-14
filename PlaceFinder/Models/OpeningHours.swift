//
//  OpeningHours.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 13/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation

struct OpeningHours: Codable {
    
    var openNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}
