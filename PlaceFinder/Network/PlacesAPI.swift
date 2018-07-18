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
    case photo(reference: String, size: CGSize)
}

extension PlacesAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/place/")!
    }
    
    var path: String {
        switch self {
            
        case .searchNearestPlacesBy(_, _):
            return "nearbysearch/json"
            
        case .photo(_, _):
            return "photo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        
        case .searchNearestPlacesBy(_, _), .photo(_, _):
            return .get
        }
    }
    
    var task: Task {
        let apiKey = DefaultKeyProvider().googleMapsAPIKey
        
        switch self {
            
        case .searchNearestPlacesBy(let keyword, let location):
            let locale = NSLocalizedString("MapsLocale", comment: "Locale to use on places searches")
            
            let parameters = [
                "key": apiKey,
                "location": "\(location.latitude),\(location.longitude)",
                "keyword": keyword,
                "language": locale,
                "rankby": "distance"
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .photo(let reference, let size):
            let parameters: [String: Any] = [
                "key" : apiKey,
                "photoreference": reference,
                "maxwidth": size.width,
                "maxheight": size.height
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
