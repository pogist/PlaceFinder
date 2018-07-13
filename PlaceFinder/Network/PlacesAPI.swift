//
//  PlacesAPI.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 12/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import Moya
import CoreLocation

enum PlacesAPI {
    case searchNearestPlacesBy(keyword: String, location: CLLocationCoordinate2D)
}

extension PlacesAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/place/")!
    }
    
    var path: String {
        switch self {
            
        case .searchNearestPlacesBy(_, _):
            return "nearbysearch/json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        
        case .searchNearestPlacesBy(_, _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        
        case .searchNearestPlacesBy(let keyword, let location):
            let parameters = [
                "key": DefaultKeyProvider().googleMapsAPIKey,
                "location": "\(location.latitude),\(location.longitude)",
                "keyword": keyword,
                "language": "pt-BR",
                "rankby": "distance"
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
