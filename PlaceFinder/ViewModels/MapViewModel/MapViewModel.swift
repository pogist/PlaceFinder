//
//  MapViewModel.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import CoreLocation
import Moya
import GoogleMaps
import PromiseKit

final class MapViewModel: NSObject, MapViewModelType {
    
    weak var delegate: MapViewModelDelegate?
    var apiProvider: MoyaProvider<PlacesAPI>!

    var currentLocation: CLLocation?
    var zoomLevel: Float = 14.0
    
    override init() {
        super.init()
        self.apiProvider = MoyaProvider<PlacesAPI>()
    }
    
    /**
     Map's target position based on user's current location.
     */
    var cameraPosition: GMSCameraPosition? {
        get {
            guard let currentLocation = currentLocation else {
                return nil
            }
            
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            
            return GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoomLevel)
        }
    }
    
    var locationManager: LocationManagerProtocol? {
        didSet {
            guard var locationManager = locationManager else {
                return
            }
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 50
            locationManager.delegate = self
        }
    }
    
    /**
     When using the app in production this method must be called before startsUpdatingUserLocation().
     */
    func requestAuthorizationForLocationService() {
        guard let locationManager = self.locationManager else {
            return
        }
        
        if type(of: locationManager).authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    /**
     Calls CLLocationManager.startUpdatingLocation() if the location service is enabled in the device.
     */
    func startsUpdatingUserLocation() {
        guard let locationManager = self.locationManager else {
            return
        }
        
        switch type(of: locationManager).authorizationStatus() {
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        
        default:
            break
        }
    }
    
    /**
     Searches for nearby places from user's current location ranked by distance.
     
     - Parameters:
        - keyword: A term to be matched against all content that Google has indexed for all places.
        - quantity: The number of places to be fetched.
     */
    func startsSearchingNearbyPlacesWith(keyword: String, quantity: Int) {
        guard let currentLocation = self.currentLocation else {
            return
        }
        
        apiProvider.request(.searchNearestPlacesBy(keyword: keyword, location: currentLocation.coordinate))
            .compactMap { response in
                return try response.map(SearchResult.self)
            }
            .map { searchResult -> [PlaceViewModel] in
                return searchResult.places?.prefix(quantity).map { PlaceViewModel(model: $0) } ?? []
            }
            .then { places -> Promise<[PlaceViewModel]> in
                return when(fulfilled: places.map { $0.loadPhoto() })
            }
            .done { [weak self] places in
                guard let strongSelf = self else { return }
                
                let markers = places.map { place -> GMSMarker in
                    let marker = GMSMarker(position: place.location!)
                    marker.userData = place
                    
                    return marker
                }
                
                strongSelf.delegate?.didLoadMarkers(markers)
            }
            .catch { [weak self] error in
                self?.delegate?.didFailToLoadMarkers(with: error)
            }
    }
    
    deinit {
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
}
