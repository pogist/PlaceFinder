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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchController: UISearchController? = nil
    var mapViewModel: MapViewModelType!
    
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

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        if let detailsView = Bundle.main.loadNibNamed("PlaceDetailsView", owner: nil, options: nil)?.first as? PlaceDetailsView,
            let placeViewModel = marker.userData as? PlaceViewModel {
            
            detailsView.placeName.text = placeViewModel.placeName
            detailsView.placeAddress.text = placeViewModel.placeAddress
            
            detailsView.placeImage.contentMode = .scaleAspectFill
            detailsView.placeImage.image = placeViewModel.photo ?? #imageLiteral(resourceName: "no-picture")
            
            return detailsView
        } else {
            return nil
        }
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
    
    func didLoadMarkers(_ markers: [GMSMarker]) {
        searchController?.dismiss(animated: true, completion: nil)
        activityIndicator.stopAnimating()
        
        mapView.clear()
        
        markers.forEach { marker in
            marker.appearAnimation = .pop
            marker.map = mapView
        }
    }
    
    func didFailToLoadMarkers(with error: Error) {
        let errorAlert = UIAlertController(for: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.startAnimating()
        mapViewModel.startsSearchingNearbyPlacesWith(keyword: searchBar.text ?? "", quantity: 10)
    }
}
