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
    var searchController: UISearchController? = nil
    
    var mapViewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapViewModel = MapViewModel()
        mapViewModel.locationManager = CLLocationManager()
        
        mapViewModel.delegate = self
        mapViewModel.requestAuthorizationForLocationService()
        
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func setupSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        
        let searchBar = searchController!.searchBar
        
        searchBar.sizeToFit()
        searchBar.placeholder = "Search a place kind. Ex: pharmacy"
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .default
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
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

extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {
            return
        }
        
        // Uses search term....
        
        searchController?.dismiss(animated: true, completion: nil)
    }
}
