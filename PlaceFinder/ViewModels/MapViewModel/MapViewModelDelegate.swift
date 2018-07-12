//
//  MapViewModelDelegate.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Foundation
import GoogleMaps

protocol MapViewModelDelegate: class {
    func didUpdateCameraPosition(_ cameraPosition: GMSCameraPosition?)
}
