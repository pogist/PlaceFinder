//
//  Photo.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 12/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation

struct Photo: Codable {
    
    var height: Int?
    var width: Int?
    var reference: String?
    var htmlAttributions: [String]?
    
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case reference = "photo_reference"
        case htmlAttributions = "html_attributions"
    }
}
