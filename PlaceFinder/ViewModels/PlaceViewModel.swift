//
//  PlaceViewModel.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 15/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import UIKit
import CoreLocation
import Moya
import PromiseKit

struct PlaceViewModel {
    
    private let place: Place
    private let photoSize = CGSize(width: 250, height: 150)
    
    var apiProvider: MoyaProvider<PlacesAPI>!
    
    init(model: Place, photo: UIImage? = nil, provider: MoyaProvider<PlacesAPI>) {
        self.place = model
        self.photo = photo
        self.apiProvider = provider
    }
    
    init(model: Place, photo: UIImage? = nil) {
        self.init(model: model, photo: photo, provider: MoyaProvider<PlacesAPI>())
    }
    
    var placeName: String? {
        return place.name
    }
    
    var placeAddress: String? {
        return place.vicinity
    }
    
    var placePhotoReference: String? {
        return place.photos?.first?.reference
    }
    
    var photo: UIImage?
    
    var location: CLLocationCoordinate2D? {
        guard
            let latitude = place.geometry?.location?.latitude,
            let longitude = place.geometry?.location?.longitude
        else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    /**
     Downloads a photo from Google, if there's one, and then returns a promise that resolves to a new view model containing the photo.
     */
    func loadPhoto() -> Promise<PlaceViewModel> {
        guard let placePhotoReference = placePhotoReference else {
            return Promise.value(self)
        }
        
        let promise = apiProvider.request(.photo(reference: placePhotoReference, size: photoSize))
            .map { UIImage(data: $0.data) }
            .map { photo -> PlaceViewModel in
                return PlaceViewModel(model: self.place, photo: photo)
            }
        
        return promise
    }
}
