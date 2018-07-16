//
//  PlaceViewModel.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 15/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import CoreLocation

struct PlaceViewModel {
    
    private let place: Place
    
    init(model: Place) {
        self.place = model
    }
    
    var placeName: String? {
        return place.name
    }
    
    var placeAddress: String? {
        return place.vicinity
    }
    
    var location: CLLocationCoordinate2D? {
        guard
            let latitude = place.geometry?.location?.latitude,
            let longitude = place.geometry?.location?.longitude
        else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
