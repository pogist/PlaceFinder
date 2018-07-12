//
//  MapViewController.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var mapViewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapViewModel = MapViewModel()
        mapViewModel.locationManager = CLLocationManager()
        
        mapViewModel.delegate = self
        mapViewModel.requestAuthorizationForLocationService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
}

extension MapViewController: MapViewModelDelegate {
    
    func didUpdateCameraPosition(_ cameraPosition: GMSCameraPosition?) {
        guard let cameraPosition = cameraPosition else {
            return
        }
        
        UIView.animate(
            withDuration: 0.5,
            animations: { [weak self] in
                self?.mapView.animate(to: cameraPosition)
            },
            completion: { [weak self] _ in
                self?.mapView.camera = cameraPosition
            })
    }
}
