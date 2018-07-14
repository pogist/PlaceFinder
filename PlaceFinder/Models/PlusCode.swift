//
//  PlusCode.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 13/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation

struct PlusCode: Codable {
    
    var compound: String?
    var global: String?
    
    enum CodingKeys: String, CodingKey {
        case compound = "compound_code"
        case global = "global_code"
    }
}
